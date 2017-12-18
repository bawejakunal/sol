/*@author: Kunal Baweja*/

/* find sum of 1 to n, inclusive */
func int series(int n) {
    /* fail no terminating condition */
    return n + series(n-1);
}

func main() {
    /* crash due to stack overflow */
    consolePrint(intToString(series(-1)));  /*-1*/
}