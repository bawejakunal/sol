/* @author: Kunal Baweja*/
/* confirm return values of member functions */

shape Rectangle {
    int [2]a;
    int [2]b;
    int [2]c;
    int [2]d;

    construct (int [2]w, int[2]x, int[2]y, int[2]z) {
        a = w;
        b = x;
        c = y;
        d = z;
    }

    draw () {}

    /* get area */
    func int area() {
        int h;
        int w;

        h = a[1] - d[1];
        if (h < 0) {
            h = -h;
        }

        w = b[0] - a[0];
        if (w < 0) {
            w = -w;
        }

        return w * h;
    }
}

func main () {
    Rectangle r;
    r = shape Rectangle([1,1],[4,1],[4,4],[1,4]);
    consolePrint(intToString(r.area()));
}