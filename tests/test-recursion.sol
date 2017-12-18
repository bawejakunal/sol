/*@author: Kunal Baweja*/

/* find sum of 1 to n, inclusive */
func int series(int n) {
    if (n < 2)
        return n;
    return n + series(n-1);
}

func main() {
    consolePrint(intToString(series(-1)));  /*-1*/
    consolePrint(intToString(series(0)));   /*0*/
    consolePrint(intToString(series(1)));   /*1*/
    consolePrint(intToString(series(2)));   /*3*/
    consolePrint(intToString(series(10)));  /*55*/
}