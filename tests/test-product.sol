func int mult(int x, int y) {
    return x * y;
}

func float fmult(float x, float y) {
    return x * y;
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

    /* integer multiplication */
    x = mult(40, 2);
    checkInt(x, 80);

    x = mult(1, 0);
    checkInt(x, 0);

    /* float multiplication */
    y = fmult(-3.0, 2.0);
    checkFloat(y, -6.0);

    y = fmult(0.0, 1.0);
    checkFloat(y, 0.0);
}
