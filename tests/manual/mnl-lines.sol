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
        int i;
        i = 0;
        while (i < 20) {
            start[0] = (start[0] + 1) % 640;
            mid[0] = (mid[0] + 1) % 640;
            end[0] = (end[0] + 1) % 640;
            start[1] = (start[1] + 1) % 480;
            mid[1] = (mid[1] + 1) % 480;
            end[1] = (end[1] + 1) % 480;
            drawCurve(start, mid, end, 100, [0,150,0]);
            i = i + 1;
        }
    }
}


func main() {
    Line l;
    l = shape Line([100,2], [200,200]);
    setFramerate(10);
}