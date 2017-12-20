/*@author: Kunal Baweja*/

func main() {

    int x;
    x = 1;

    if (x == 1 && x == 1) {
        consolePrint("AND");
    }
    if (1 == 1 || 1 == 0) {
        consolePrint("OR");
    }
    if (!(1 == 0)) {
        consolePrint("NOT");
    }
}