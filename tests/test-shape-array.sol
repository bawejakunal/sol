/* @author: Kunal Baweja */

/* test initializing a shape with an array of points
 * pass an array to the constructor and ensure that
 * the object makes a copy of the array. The contents
 * of array should not change
 */

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
    Line l;
    int [2]first;
    int [2]second;

    first = [1, 1];
    second = [9, 9];

    l = shape Line(first, second);

    /* modify source array */
    first[0] = -1;
    first[1] = -1;
    second[0] = -9;
    second[1] = -9;

    /* verify shape remains unchanged */
    l.describe();
}