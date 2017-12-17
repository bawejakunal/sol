/*@author: Kunal Baweja*/

func checkEqual(int x, int y) {
    if (x == y) {
        consolePrint("CORRECT");
    }
    if (x != y) {
        consolePrint("INCORRECT");
    }
}

func main() {
    int x;

    x = 1 + 20 * 3;    /* 61 */
    checkEqual(x, 61);

    x = 1 - 20 * 3;     /* -59 */
    checkEqual(x, -59);

    x = 1 + 18 / 3;     /* 7 */
    checkEqual(x, 7);

    x = 1 - 18 / 3;     /* -5 */
    checkEqual(x, -5);

    /* parenthesis override */
    x = (1 + 5) / 3;    /* 2 */
    checkEqual(x, 2);

    x = (1 - 7) / 3;    /* -2 */
    checkEqual(x, -2);

    /* for same precedence left to right associativity */
    x = 1 - 7 + 3;
    checkEqual(x, -3);

    x = 30 / 3 * 2;
    checkEqual(x, 20);

    /* unary negation precedes other arithmetic operators*/
    x = 3 + -2;
    checkEqual(x, 1);

    x = 3 - -2;
    checkEqual(x, 5);

    x = 3 * -2;
    checkEqual(x, -6);

    x = 3 / -1;
    checkEqual(x, -3);
}