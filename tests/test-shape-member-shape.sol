/* @author: Kunal Baweja */

/* Test member shapes */

/* Define a line */
shape Line {
    int [2]start;
    int [2]end;

    construct(int [2]first, int [2]second) {
        start = first;
        end = second;
    }

    draw(){}

    func describe() {
        consolePrint(intToString(start[0]));
        consolePrint(intToString(start[1]));
        consolePrint(intToString(end[0]));
        consolePrint(intToString(end[1]));
    }

    func move(int [2]d) {
        int i;
        i = 0;
        while (i < 2) {
            start[i] = start[i] + d[i];
            end[i] = end[i] + d[i];
            i = i + 1;
        }
    }
}

/* Define rectange as a collection of lines */
shape Rectangle {
    Line top;
    Line right;
    Line bottom;
    Line left;

    construct(Line t, Line r, Line b, Line l) {
        top = t;
        right = r;
        bottom = b;
        left = l;
    }

    draw(){}

    func move(int [2]d) {
        top.move(d);
        right.move(d);
        bottom.move(d);
        left.move(d);
    }

    func describe() {
        top.describe();
        right.describe();
        bottom.describe();
        left.describe();
    }
}

func main() {
    Line t;
    Line b;
    Line r;
    Line l;
    Rectangle sq;

    /* define lines */
    t = shape Line([1,1], [3,1]);
    r = shape Line([3,1], [3,3]);
    b = shape Line([3,3], [1,3]);
    l = shape Line([1,3], [1,1]);

    /* initialize square */
    sq = shape Rectangle(t,r,b,l);
    sq.describe();

    /* move square */
    consolePrint("MOVE [2,2]");
    sq.move([2,2]);

    /*confirm all members are called*/
    sq.describe();
}