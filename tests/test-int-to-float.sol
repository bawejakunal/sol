/* @author Kunal Baweja */

/* int to float type conversion */
func main() {
    float x;

    x = intToFloat(-1);
    consolePrint(floatToString(x));

    x = intToFloat(0);
    consolePrint(floatToString(x));

    x = intToFloat(2);
    consolePrint(floatToString(x));
}