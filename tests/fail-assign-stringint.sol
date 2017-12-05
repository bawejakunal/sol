func int add(int x, int y) {
    return x + y;
}

func main() {
    int x;
    string y;
    int z;
    y = "foo";
    x = add(10, 2); 
    z = "bar"; /* cant assign string to int*/
}