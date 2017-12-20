/* @author: Kunal Baweja */

/* float to int conversions */

func main() {
    int x;

    x = floatToInt(0.5);
    consolePrint(intToString(x));

    x = floatToInt(-0.5);
    consolePrint(intToString(x));

    x = floatToInt(0.0);
    consolePrint(intToString(x));

    x = floatToInt(1.5);
    consolePrint(intToString(x));

    x = floatToInt(-1.5);
    consolePrint(intToString(x));
}