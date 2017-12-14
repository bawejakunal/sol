make clean all
FILENAME=`basename "$1" ".sol"`
echo "Hello"
echo $1
echo $FILENAME
./sol.native $1 > $FILENAME.ll
llc $FILENAME.ll > $FILENAME.s
cc -o $FILENAME.exe $FILENAME.s predefined.o -lSDL2 -lSDL2_gfx -lm
chmod +x ./$FILENAME.exe
./$FILENAME.exe
