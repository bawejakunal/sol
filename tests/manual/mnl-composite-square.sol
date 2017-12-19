/* @author: Kunal Baweja */

/* Test member shapes */

/* Define a line */
shape Line {
    int [2]start;
    int [2]mid;
    int [2]end;
    int [3]color;

    construct(int [2]first, int [2]second, int [3]clr) {
        start = first;
        end = second;
        color = clr;

        mid[0] = (start[0] + end[0]) / 2;
        mid[1] = (start[1] + end[1]) / 2;
    }

    draw(){
        drawCurve(start, mid, end, 2, color);
    }

}

/* Define rectange as a collection of lines */
shape Rectangle {
    Line top;
    Line right;
    Line bottom;
    Line left;

    construct(int [2]a, int [2]b, int [2]c, int [2]d) {
        top = shape Line(a, b, [150, 0, 0]);
        right = shape Line(b, c, [0, 150, 0]);
        bottom = shape Line(c, d, [0, 0, 150]);
        left = shape Line(d, a, [150, 150, 150]);
    }

    draw(){}

}

func main() {
    Rectangle sq;

    /* define lines */

    /* initialize square */
    sq = shape Rectangle([10,10], [300,10], [300, 300], [10, 300]);
}