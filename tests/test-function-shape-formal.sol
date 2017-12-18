/* @author: Kunal Baweja */

/* Shapes should be passed by reference */

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
}

/* displace line by d */
func moveLine(Line l, int[2] d) {
    l.start[0] = l.start[0] + d[0];
    l.start[1] = l.start[1] + d[1];

    l.end[0] = l.end[0] + d[0];
    l.end[1] = l.end[1] + d[1];
}

func main() {
    Line l;
    l = shape Line([1,1], [5,5]);
    moveLine(l, [2, 2]);

    /* confirm modified values for pass by reference */
    l.describe();
}