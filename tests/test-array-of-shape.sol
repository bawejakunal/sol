/* @author: Kunal Baweja */

/* Test arrays of shapes */

/* Define a line */
shape Line {
    int [2]start;
    int [2]mid;
    int [2]end;

    construct(int [2]first, int [2]second) {
        start = first;
        end = second;
        /* line mid point */
        mid[0] = (start[0] + end[0]) / 2;
        mid[1] = (start[1] + end[1]) / 2;
    }

    draw(){}

    func describe() {
        consolePrint(intToString(start[0]));
        consolePrint(intToString(start[1]));
        consolePrint(intToString(mid[0]));
        consolePrint(intToString(mid[1]));
        consolePrint(intToString(end[0]));
        consolePrint(intToString(end[1]));
    }
}

func main() {

    /* four lines to describe a square */
    Line [4]sq;
    Line tmp;
    int i;

    /* describe four sides */
    sq[0] = shape Line([1,1], [3,1]); /* top */
    sq[1] = shape Line([3,1], [3,3]); /* right */
    sq[2] = shape Line([3,3], [1,3]); /* bottom */
    sq[3] = shape Line([1,3], [1,1]); /* left */

    /* print end and midpoit of each side */
    i = 0;
    while (i < 4) {
        tmp = sq[i];
        tmp.describe();
        i = i + 1;
    }
}