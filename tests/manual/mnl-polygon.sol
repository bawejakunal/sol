/*@author: Kunal Baweja & Erik Dyer*/

/* Test drawing an n sided polygon */ 

shape Spokes{
    int [2]center;
    float sides;
    float radius;
    construct(int [2]s, int l, int n) {
        center = s;
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

        i = 1.0;
        while(i <= sides){
            degrees = (360.0 * i)/sides;
            x = floatToInt(radius * cosine(degrees));
            y = floatToInt(radius * sine(degrees));

            end[0] = x + center[0];
            end[1] = y + center[1];
            mid[0] = (center[0] + end[0]) / 2;
            mid[1] = (center[1] + end[1]) / 2;
            drawCurve(center, mid, end, 2, [150, 0, 0]);
            i = i + 1.0;
        }
    }
}

shape Polygon{
    int [2]center;
    float sides;
    float radius;
    Spokes spks;

    construct(int [2]s, int l, int n) {
        center = s;
        sides = intToFloat(n);
        radius = intToFloat(l);
        spks = shape Spokes(s, l, n);
    }

    draw(){
        float i;
        float degrees;
        int[2] strt;
        int[2] mid;
        int[2] end;

        degrees = 0.0;
        strt[0] = center[0] + floatToInt(radius * cosine(degrees));
        strt[1] = center[1] + floatToInt(radius * sine(degrees));

        i = 1.0;
        while(i <= sides){
            degrees = (360.0 * i)/sides;
            end[0] = center[0] + floatToInt(radius * cosine(degrees));
            end[1] = center[1] + floatToInt(radius * sine(degrees));
            mid[0] = (strt[0] + end[0]) / 2;
            mid[1] = (strt[1] + end[1]) / 2;
            drawCurve(strt, mid, end, 2, [0, 150, 0]);
            strt = end;
            i = i + 1.0;
        }
    }
}


func main() {
    Polygon p;
    p = shape Polygon([320, 240], 120, 24);
}
