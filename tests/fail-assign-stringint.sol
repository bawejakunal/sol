func int add(int x, int y) {
    return x + y;
}

func int main() {
    int x;
    string y;
    int z;
    y = "foo";
    x = add(10, 2); 
    z = "bar"; /* cant assign string to int*/

    return 0;
}