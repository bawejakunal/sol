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
    int time;

/*polygon */
    int [2]center;
    float sides;
    float radius;
    float theta;
    int [3]color;

    int j;



    construct(int [2]s, int l, int n, float t) {
        startL = [0,200];
        endL = [70, 200];
        findCenter(midL, startL, endL);

        /* polygon */

        center = s;
        color = [0, 0, 0];
        theta = t;
        sides = intToFloat(n);
        radius = intToFloat(l);

        time = 500;
        j = 0;
    }

    draw(){
        float i;
        float degrees;
        int[2] strt;
        int[2] mid;
        int[2] end;
        int[2] originStart;


        degrees = theta;
        strt[0] = center[0] + floatToInt(radius * cosine(degrees)) - j;
        strt[1] = center[1] + floatToInt(radius * sine(degrees));
        originStart = strt;
        i = 1.0;
        while(i <= sides){
            degrees = (360.0 * i)/sides + theta;
            end[0] = center[0] + floatToInt(radius * cosine(degrees)) -j;
            end[1] = center[1] + floatToInt(radius * sine(degrees));
            mid[0] = (strt[0] + end[0]) / 2;
            mid[1] = (strt[1] + end[1]) / 2;
            drawCurve(strt, mid, end, 2, color);
            strt = end;
            i = i + 1.0;
        }


        if(j < time){
            if(endL[0] >= strt[0]-70){
               endL[0] = strt[0] -74;
            } 
            if(startL[0] >= strt[0]- 70){
               startL[0] = strt[0] -74;
            } 
            startL[0] = startL[0] + 4;
            endL[0] = endL[0] +4;
            findCenter(midL, startL, endL);
            drawCurve(startL, midL, endL, 2, [150,0,0]);
            j = j + 1;
        }
    }
}

func main(){
    Polyshape c1;

    c1 = shape Polyshape([550, 215], 40, 80, -30.0);

}
