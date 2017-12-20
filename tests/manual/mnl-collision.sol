/*@author: Erik Dyer*/

/* Test Collision*/

shape Polydot{
    int [2]a;
    int [2]b;
    int time;
    int i;
    int aDir;
    int bDir;
    construct(int [2]sA, int [2]sB, int t) {
        a = sA;
        b = sB;
        time = t;
        i = 0;
        aDir = 1;
        bDir = -1;
    }

    draw(){
        if(i < time){
            if(a[0] == b[0]){
                if(a[1] == b[1]){
                    aDir = -1;
                    bDir = 1;
                }
            }
            a[0] = a[0] + 1*aDir;
            b[0] = b[0] + 1 *bDir;

            drawPoint(a, [150,0,0]);
            drawPoint(b, [0,0,150]);
            i = i+1;
        }
    }
}

func main(){
    Polydot c1;

    c1 = shape Polydot([20, 50], [500, 50], 300);
}
