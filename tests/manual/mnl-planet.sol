/* @author Kunal Baweja */

/* Solar System Revolve */

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

func main() {
    Polygon sun;
    Polygon earth;
    sun = shape Polygon([320, 240], 40, 80, 30.0, [255,128,0]);
    earth = shape Polygon([500, 240], 40, 80, 30.0, [0,153,0]);

    earth.render = {
        rotate(-720.0, [-180, 0], 10);
    }
}