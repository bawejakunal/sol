func main() {
    int i;
    int [5]array;

    /* assign array elements */
    array = [0,1,2,3,4];

    /* print array elements */
    i = 0;
    while(i < 5) {
        consolePrint(intToString(array[i]));
        i = i  + 1;
    }
}