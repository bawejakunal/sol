func main() {
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
}