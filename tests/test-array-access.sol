func main() {
    int i;
    int [5]array;
    string y;

    /* assign array elements */
    array = [0,1,2,3,4];

    /* print array elements */
    i = 0;
    while(i < 5) {
        intToString(y, array[i]);
        consolePrint(y);
        i = i  + 1;
    }
}