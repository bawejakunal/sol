/*@author: Kunal Baweja */

/* James Bond Introduction */

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
        drawCurve(start, mid, end, 2, [0, 0, 0]);
    }
}

shape Person {
    Polygon head;
    Line body;
    Line lleg;
    Line rleg;
    Line lhand;
    Line rhand;
    int frames;

    construct(int[2] pos) {
        int [2]strt;
        int [2]end;

        frames = 0;
        head = shape Polygon(pos, 12, 50, 0.0, [0, 0, 0]);

        strt[0] = pos[0];
        strt[1] = pos[1] + 12;
        end[0] = pos[0];
        end[1] = pos[1] + 42;
        body = shape Line(strt, end);

        strt[1] = end[1];
        end[0] = strt[0] - 10;
        end[1] = strt[1] + 10;
        lleg = shape Line(strt, end);

        end[0] = strt[0] + 10;
        rleg = shape Line(strt, end);

        /* rhand */
        strt[1] = pos[1] + 22;
        end[1] = pos[1] + 22;
        rhand = shape Line(strt, end);

        /* rhand */
        end[0] = end[0] - 20;
        lhand = shape Line(strt, end);
    }

    draw(){
        if (frames < 120) {
            frames = frames + 1;
        }
        if (frames >= 120) {
            print([-200, 200], "The name is Bond. James Bond !",
                [102, 102, 255]);
        }
    }
}

func main(){
    Polygon c1;
    Polygon c2;
    Polygon c3;
    Person bond;

    c1 = shape Polygon([-50, 100], 40, 80, 30.0, [0,0,150]);
    c2 = shape Polygon([-50, 100], 40, 80, 30.0, [0,150,0]);
    c3 = shape Polygon([-50, 100], 40, 80, 30.0, [150,0,0]);
    bond = shape Person([-50, 80]);


    bond.render = {
        translate([400, 0], 4);
    }

    c1.render = {
        translate([400, 0], 4);
    }

    c2.render = {
        translate([200, 0], 2);
    }

    c3.render = {
        translate([100, 0], 1);
    }
}
