func main() {
    int x;
    int y;
    float f;
    float g;
    string s;
    string p;
    string q;

    /* integer assignment */
    x = 5;
    y = x;
    s = intToString(y);
    consolePrint(s);

    /* string variable assignment */
    p = "Hello World";
    q = p;
    consolePrint(q);

    f = 4.2;
    g = f;
    consolePrint(floatToString(g));
}