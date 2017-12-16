/* test arrays passed by reference */

func assign(int [5]b) {
    int i;
    i = 0;

    while(i < 5) {
        i = b[i] = i + 1;
    }
}

func main() {
    int [5]a;
    int i;

    /* pass for assignment */
    assign(a);

    /* confirm assigned values */
    i = 0;
    while (i < 5) {
        consolePrint(intToString(a[i]));
        i = i + 1;
    }
}