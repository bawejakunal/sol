make clean all
FILENAME = `basename "$1"`
./sol.native {$1} > {$FILENAME}.ll
llc {$FILENAME}.ll > {$FILENAME}.s
cc -o {$FILENAME}.exe {$FILENAME}.s predifined.o -lSDL2 -lSDL2_gfx -lm
