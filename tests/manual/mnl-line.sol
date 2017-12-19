/*@author: Kunal Baweja*/

/* Test drawing a line */ 

shape Line {
    int [2]start;
    int [2]mid;
    int [2]end;

    construct(int [2]s, int [2]e) {
        start = s;
        end = e;
        mid[0] = (start[0] + end[0]) / 2;
        mid[1] = (start[1] + end[1]) / 2;
    }

    draw(){
        drawCurve(start, mid, end, 100, [0,150,0]);
    }
}


func main() {
    Line l;
    l = shape Line([2,2], [200,200]);
}