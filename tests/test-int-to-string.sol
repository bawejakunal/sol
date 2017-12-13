func main() {
    string s;

    intToString(s, -2147483648);
    consolePrint(s);

    intToString(s, -2147483648 + 2147483647);
    consolePrint(s);
    
    intToString(s, 0);
    consolePrint(s);

    intToString(s, 2147483647);
    consolePrint(s);
}