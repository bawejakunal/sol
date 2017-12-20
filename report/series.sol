/* @author: Kunal Baweja */

/* recursive series sum of 1 to n */
func int series(int n) {
	int x;
	if (n < 0) {
		consolePrint(intToString(0));
		return 0;
	}
	if (n < 2) {
		consolePrint(intToString(n));
		return n;
	}
	x = n + series(n-1);
	consolePrint(intToString(x));
	return x;
}

func main() {
	series(5); /*1,3,6,10,15*/
}
