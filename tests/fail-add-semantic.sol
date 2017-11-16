func float add(int x, float y) {
    return x + y;
}

func int main() {
    float x;
    x = add(40, 2.5);
    if (x == 42.5) {
        consolePrint("CORRECT");
    }
    if (x != 42.5) {
        consolePrint("INCORRECT");
    }
    return 0;
}
