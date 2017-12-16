func main() {
    float f;
    string s;

    f = -10.0;
    floatToString(s, f);
    consolePrint(s);

    f = 0.0;
    floatToString(s, f);
    consolePrint(s);

    f = 10.0;
    floatToString(s, f);
    consolePrint(s);
}