/* @author: Kunal Baweja */

/* Test drawing an n sided polygon */ 

shape Spokes{
    int [2]center;
    int [3]color;
    float sides;
    float radius;
    float theta;

    construct(int [2]s, int l, int n, float t, int[3] clr) {
        center = s;
        color = clr;
        theta = t;
        sides = intToFloat(n);
        radius = intToFloat(l);
    }

    draw(){
        float i;
        int x;
        int y;
        float degrees;
        int[2] mid;
        int[2] end;

        i = 0.0;
        while(i < sides){
            degrees = (360.0 * i)/sides + theta;
            x = floatToInt(radius * cosine(degrees));
            y = floatToInt(radius * sine(degrees));

            end[0] = x + center[0];
            end[1] = y + center[1];
            mid[0] = (center[0] + end[0]) / 2;
            mid[1] = (center[1] + end[1]) / 2;
            drawCurve(center, mid, end, 2, color);
            i = i + 1.0;
        }
    }
}

shape Polygon{
    int [2]center;
    float sides;
    float radius;
    float theta;
    int [3]color;
    
    construct(int [2]s, int l, int n, float t, int[3] clr) {
        center = s;
        color = clr;
        theta = t;
        sides = intToFloat(n);
        radius = intToFloat(l);
    }

    draw(){
        float i;
        float degrees;
        int[2] strt;
        int[2] mid;
        int[2] end;

        degrees = theta;
        strt[0] = center[0] + floatToInt(radius * cosine(degrees));
        strt[1] = center[1] + floatToInt(radius * sine(degrees));

        i = 1.0;
        while(i <= sides){
            degrees = (360.0 * i)/sides + theta;
            end[0] = center[0] + floatToInt(radius * cosine(degrees));
            end[1] = center[1] + floatToInt(radius * sine(degrees));
            mid[0] = (strt[0] + end[0]) / 2;
            mid[1] = (strt[1] + end[1]) / 2;
            drawCurve(strt, mid, end, 2, color);
            strt = end;
            i = i + 1.0;
        }
    }
}


shape Square {
    Polygon plgn;

    construct(int[2] ctr, int r) {
        plgn = shape Polygon(ctr, r, 4, 45.0, [0, 0, 150]);
    }

    draw(){}
}

shape FerrisWheel {
    float radius;
    int sides;
    int [2]center;
    
    Polygon plgn;
    Spokes spks;
    Square [10]s;

    construct(int[2] ctr, int r, int n) {
        int i;
        float degrees;
        int[2] strt;

        /* carriages rotate around a point below
         * the center of ferris wheel spokes
         */
        center[1] = ctr[1] + 16;
        center[0] = ctr[0];

        radius = intToFloat(r);
        sides = n;
        plgn = shape Polygon(ctr, r, n, 0.0, [160, 82, 45]);
        spks = shape Spokes(ctr, r, n, 0.0, [34, 139, 34]);

        i = 0;
        while(i < sides) {
            degrees = (360.0 * intToFloat(i)) / intToFloat(sides);
            strt[0] = ctr[0] + floatToInt(radius * cosine(degrees)) + 2;
            strt[1] = ctr[1] + floatToInt(radius * sine(degrees)) + 15;
            s[i] = shape Square(strt, 20);
            i = i + 1;
        }
    }

    draw(){
        int i;
        float xn;
        float yn;
        Square tmp;
        float deg;

        deg = 10.0;

        plgn.theta = (plgn.theta + deg) % 360.0;
        spks.theta = (spks.theta + deg) % 360.0;

        i = 0;
        while (i < sides) {
            tmp = s[i];
            /* translate back to origin */
            tmp.plgn.center[0] = tmp.plgn.center[0] - center[0];
            tmp.plgn.center[1] = tmp.plgn.center[1] - center[1];

            /* rotate point*/
            xn = intToFloat(tmp.plgn.center[0]) * cosine(deg);
            xn = xn - intToFloat(tmp.plgn.center[1]) * sine(deg);
            xn = round(xn + intToFloat(center[0]));

            yn = intToFloat(tmp.plgn.center[0]) * sine(deg);
            yn = yn + intToFloat(tmp.plgn.center[1]) * cosine(deg);
            yn = round(yn + intToFloat(center[1]));

            tmp.plgn.center[0] = floatToInt(xn);
            tmp.plgn.center[1] = floatToInt(yn);
            s[i] = tmp;
            i = i + 1;
        }
    }
}

func main() {
    FerrisWheel p;
    p = shape FerrisWheel([320, 240], 120, 10);
    setFramerate(15);
}
