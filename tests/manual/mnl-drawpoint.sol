/* @author: Kunal Baweja */

shape Points {
    int [2]a;

    construct (int [2]x) {
        a = x;
    }

    draw() {
        int i;
        int [2]b;

        b = a;
        i = 0;
        while (i < 50) {
            b[0] = b[0] + i;
            b[1] = b[1] + i;
            drawPoint(b, [0, 0, 0]);
            i = i + 1;
        }
    }
}

func main() {
    Points p;
    p = shape Points([100, 100]);
    setFramerate(2);
}