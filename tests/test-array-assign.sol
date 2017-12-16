func main() {
    int [5]arr;
    int i;
    string s;

    i = 0;
    while(i < 5) {
        arr[i] = i;
        i = i + 1;
    }

    i = 4;
    while(i >= 0) {
        s = intToString(arr[i]);
        consolePrint(s);
        i = i - 1;
    }
}