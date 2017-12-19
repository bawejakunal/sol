/* @author: Kunal Baweja */

shape Points {
    int [2]a;

    construct (int [2]x) {
        a = x;
    }

    draw() {
        int i;
        i = 0;
        while (i < 50) {
            a[0] = a[0] + i;
            a[1] = a[1] + i;
            drawPoint(a, [0, 0, 0]);
            i = i + 1;
        }
    }
}

func main() {
    Points p;
    p = shape Points([100, 100]);
    setFramerate(2);
}