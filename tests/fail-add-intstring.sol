/*@author: Erik Dyer*/

func int add(int x, int y) {
    return x + y;
}

func main() {
    float x;
    string y;
    y = "foo";
    x = add(40, y); /* cant add string and int */
}