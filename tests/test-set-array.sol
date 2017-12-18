/*@author: Erik Dyer*/

func main() {
    int[2] x;
    int[2] y;

    y[0] = 4;
    y[1] = 2;

    x = y;
    consolePrint(intToString(x[0]));
    consolePrint(intToString(x[1]));
}
