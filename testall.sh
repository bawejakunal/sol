#!/bin/bash

#@author: Kunal Baweja

# Regression testing script for sol
# Step through a list of files
#  Compile, run, and check the output of each expected-to-work test
#  Compile and check the error of each expected-to-fail test

# Path to the LLVM interpreter
LLI="lli"
#LLI="/usr/local/opt/llvm/bin/lli"

# Path to the LLVM compiler
LLC="llc"

# Path to the C compiler
CC="cc"

# Path to the sol compiler.  Usually "./sol.native"
# Try "_build/sol.native" if ocamlbuild was unable to create a symbolic link.

SOL="./sol.native"

LIB="predefined.o"

SDL_FLAGS="-lSDL2 -lSDL2_gfx -lm"

# Set time limit for all operations
ulimit -t 30

globallog=testall.log
rm -f $globallog
error=0
globalerror=0

keep=0

Usage() {
    echo "Usage: testall.sh [options] [.sol files]"
    echo "-k    Keep intermediate files"
    echo "-h    Print this help"
    exit 1
}

SignalError() {
    if [ $error -eq 0 ] ; then
	echo "FAILED"
	error=1
    fi
    echo "  $1"
}

# close sdl window
closeWindow() {
    # sleep 2 && xdotool key --clearmodifiers --delay 100 alt+F4
    xdotool sleep 2 && xdotool windowactivate --sync $(xdotool search --name "Shape Oriented Language") key --clearmodifiers --delay 100 alt+F4
}

# Compare <outfile> <reffile> <difffile>
# Compares the outfile with reffile.  Differences, if any, written to difffile
Compare() {
    generatedfiles="$generatedfiles $3"
    echo diff -b $1 $2 ">" $3 1>&2
    diff -b "$1" "$2" > "$3" 2>&1 || {
	SignalError "$1 differs"
	echo "FAILED $1 differs from $2" 1>&2
    }
}

# Run <args>
# Report the command, run it, and report any errors
Run() {
    echo $* 1>&2
    if [[ "$1" == *exe && "$1" != *mnl-* ]]; then
        closeWindow &
    fi
    eval $* || {
	   SignalError "$1 failed on $*"
	   return 1
    }
}

# RunFail <args>
# Report the command, run it, and expect an error
# Command may fail, we do not enforce by SignalError
# if it does not fail here
RunFail() {
    echo $* 1>&2
    if [[ "$1" == *exe ]]; then
        closeWindow &
    fi
    eval $* && {
        error=1
        return 1
    }
    return 0
}

Check() {
    error=0
    basename=`echo $1 | sed 's/.*\\///
                             s/.sol//'`
    reffile=`echo $1 | sed 's/.sol$//'`
    basedir="`echo $1 | sed 's/\/[^\/]*$//'`/."

    echo -n "$basename..."

    echo 1>&2
    echo "###### Testing $basename" 1>&2

    generatedfiles=""

    generatedfiles="$generatedfiles ${basename}.ll ${basename}.s ${basename}.exe ${basename}.out" &&
    Run "$SOL" "$1" ">" "${basename}.ll" &&
    Run "$LLC" "${basename}.ll" ">" "${basename}.s" &&
    Run "$CC" "-o" "${basename}.exe" "${basename}.s" "$LIB" "$SDL_FLAGS"&&
    Run "./${basename}.exe" ">" "${basename}.out" &&
    Compare ${basename}.out ${reffile}.gold ${basename}.diff

    # Report the status and clean up the generated files

    if [ $error -eq 0 ] ; then
	if [ $keep -eq 0 ] ; then
	    rm -f $generatedfiles
	fi
	echo "OK"
	echo "###### SUCCESS" 1>&2
    else
	echo "###### FAILED" 1>&2
	globalerror=$error
    fi
}

CheckFail() {
    error=0
    basename=`echo $1 | sed 's/.*\\///
                             s/.sol//'`
    reffile=`echo $1 | sed 's/.sol$//'`
    basedir="`echo $1 | sed 's/\/[^\/]*$//'`/."

    echo -n "$basename..."

    echo 1>&2
    echo "###### Testing $basename" 1>&2

    generatedfiles="${basename}.ll ${basename}.s ${basename}.err ${basename}.exe"
    RunFail "$SOL" "$1" "1>" "${basename}.ll" "2>" "${basename}.err"
    if [ $error -eq 1 ];
    then
        Run "$LLC" "${basename}.ll" "1>" "${basename}.s" &&
        Run "$CC" "-o" "${basename}.exe" "${basename}.s" "$LIB" "$SDL_FLAGS" &&
        RunFail "./${basename}.exe" "1>" "${basename}.err" "2>" "${basename}.err"
        error=0
    fi
    Compare ${basename}.err ${reffile}.err ${basename}.diff

    if [ $error -eq 0 ] ; then
	if [ $keep -eq 0 ] ; then
	    rm -f $generatedfiles
	fi
	echo "OK"
	echo "###### SUCCESS" 1>&2
    else
	echo "###### FAILED" 1>&2
	globalerror=$error
    fi
}

while getopts kdpsh c; do
    case $c in
	k) # Keep intermediate files
	    keep=1
	    ;;
	h) # Help
	    Usage
	    ;;
    esac
done

shift `expr $OPTIND - 1`

LLIFail() {
  echo "Could not find the LLVM interpreter \"$LLI\"."
  echo "Check your LLVM installation and/or modify the LLI variable in testall.sh"
  exit 1
}

which "$LLI" >> $globallog || LLIFail

if [ ! -f predefined.o ]
then
    echo "Could not find predefined.o"
    echo "Try \"make clean all\""
    exit 1
fi

if [ $# -ge 1 ]
then
    files=$@
else
    files="tests/test-*.sol tests/fail-*.sol"
fi

# ignore unknown files
for file in $files
do
    case $file in
	*test-*.sol|*mnl-*.sol)
	    Check $file 2>> $globallog
	    ;;
	*fail-*.sol)
	    CheckFail $file 2>> $globallog
	    ;;
    esac
done

exit $globalerror
