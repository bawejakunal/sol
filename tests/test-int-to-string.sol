func main() {
    string s;

    s = intToString(-2147483648);
    consolePrint(s);

    s = intToString(-2147483648 + 2147483647);
    consolePrint(s);
    
    s = intToString(0);
    consolePrint(s);

    s = intToString(2147483647);
    consolePrint(s);
}