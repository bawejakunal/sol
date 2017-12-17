/*@author: Erik Dyer & Kunal Baweja*/

func int add(int x, int y) {
    return x + y;
}

func float fadd(float x, float y) {
    return x + y;
}

func main() {
    int x;
    float y;

    /* integer addition */
    x = add(40, 2);
    if (x == 42) {
        consolePrint("CORRECT");
    }
    if (x != 42) {
        consolePrint("INCORRECT");
    }


    /* float addition */
    y = fadd(38.0, 4.0);
    if (y == 42.0) {
        consolePrint("CORRECT");
    }
    if (y != 42.0) {
        consolePrint("INCORRECT");
    }
}
