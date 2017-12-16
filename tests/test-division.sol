func int div(int x, int y) {
    return x / y;
}

func float fdiv(float x, float y) {
    return x / y;
}

func checkInt(int x, int y) {
    if (x == y) {
        consolePrint("CORRECT");
    }
    if (x != y) {
        consolePrint("INCORRECT");
    }
}

func checkFloat(float x, float y) {
    if (x == y) {
        consolePrint("CORRECT");
    }
    if (x != y) {
        consolePrint("INCORRECT");
    }
}

func main() {
    int x;
    float y;

    /* integer diviplication */
    x = div(40, 2);
    checkInt(x, 20);

    x = div(2, 5);
    checkInt(x, 0);

    /* float division */
    y = fdiv(-4.0, 2.0);
    checkFloat(y, -2.0);

    y = fdiv(0.0, 1.0);
    checkFloat(y, 0.0);
}
