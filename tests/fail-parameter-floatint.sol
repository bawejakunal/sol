/*@author: Kunal Baweja*/

func add(int x, int y) {
    return x + y;
}

func main() {
    int x;
    x = add(40, 2.5); /* Fail: passing a float to a func that expects int */
}
