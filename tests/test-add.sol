func int add(int x, int y) {
    return x + y;
}

func main() {
    int x;
    x = add(40, 2);
    if (x == 42) {
        consolePrint("CORRECT");
    }
    if (x != 42) {
        consolePrint("INCORRECT");
    }
}
