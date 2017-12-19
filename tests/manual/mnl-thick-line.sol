/*@author: Kunal Baweja*/

/* Test drawing a line */ 

shape Line {
    int [2]start;
    int [2]end;

    construct(int [2]s, int [2]e) {
        start = s;
        end = e;
    }

    draw(){
        int i;
        int [2]s;
        int [2]m;
        int [2]e;
        i = 0;

        s = start;
        e = end;
        while (i < 20) {
            s[0] = s[0] - 1;
            s[1] = s[1] + 1;
            
            e[0] = e[0] - 1;
            e[1] = e[1] + 1;
            
            m[0] = (s[0] + e[0]) / 2;
            m[1] = (s[1] + e[1]) / 2;

            drawCurve(s, m, e, 2, [0,150,0]);
            i = i + 1;
        }
    }
}


func main() {
    Line l;
    l = shape Line([100,2], [200,200]);
    setFramerate(10);
}