func main() {
    /* Integer comparisons */
    if (0 == 0) {
        consolePrint("EQUALITY");
    }
    if (-1 != 0) {
        consolePrint("INEQUALITY");
    }
    if (2 > 1) {
        consolePrint("GREATER THAN");
    }
    if (-2 < -1) {
        consolePrint("LESS THAN");
    }
    if (1 <= 2) {
        consolePrint("LESS THAN OR EQUAL");
    }
    if (5 >= 3) {
        consolePrint("GREATER THAN OR EQUAL");
    }

    /* float logical comparison */
    if (0.0 == 0.0) {
        consolePrint("FLOAT EQUALITY");
    }
    if (-1.0 != 0.0) {
        consolePrint("FLOAT INEQUALITY");
    }
    if (2.0 > 1.0) {
        consolePrint("FLOAT GREATER THAN");
    }
    if (-1.1 < -1.0) {
        consolePrint("FLOAT LESS THAN");
    }
    if (1.0 <= 2.0) {
        consolePrint("FLOAT LESS THAN OR EQUAL");
    }
    if (5.0 >= 3.0) {
        consolePrint("FLOAT GREATER THAN OR EQUAL");
    }
}