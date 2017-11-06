func int main() {
    if (1 == 1 && 2 == 2) {
        consolePrint("AND");
    }
    if (1 == 1 || 1 == 0) {
        consolePrint("OR");
    }
    if (!1 == 0) {
        consolePrint("NOT");
    }
    return 0;
}