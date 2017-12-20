/*@author: Erik Dyer*/

/* Test Collision*/

func findCenter(int [2]m, int[2]x, int[2]y) {
    m[0] = (x[0] + y[0]) / 2;
    m[1] = (x[1] + y[1]) / 2;
}

shape Polyshape{
/* The Laser */
    int [2]startL;
    int [2]midL;
    int [2]endL;


/*wall */

    int [2]startW;
    int [2]midW;
    int [2]endW;

    int time;
    int i;
    int aDir;
    int bDir;

    construct(int t) {
        startL = [0,200];
        endL = [70, 200];
        findCenter(midL, startL, endL);

        startW = [475, 50];
        endW = [475, 400];
        findCenter(midW, startW, endW);
        time = t;
        i = 0;
    }

    draw(){
        if(i < time){
            if(endL[0] >= startW[0]){
               endL[0] = startW[0] -4;
            } 
            if(startL[0] >= startW[0]){
               startL[0] = startW[0] -4;
            } 
            startL[0] = startL[0] + 4;
            endL[0] = endL[0] +4;
            findCenter(midL, startL, endL);
            drawCurve(startL, midL, endL, 2, [150,0,0]);
            i = i+1;
        }
        drawCurve(startW, midW, endW, 2, [0,150,0]);
    }
}

func main(){
    Polyshape c1;

    c1 = shape Polyshape(500);

}
