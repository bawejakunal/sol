/*@author: Erik DYer*/

/* Test drawing an n sided polygon */ 

shape Polygon{
    int [2]start;
    int sides;
    float pi;

    construct(int [2]s, int [2]l, int n) {
        start = s;
        int sides = n;
        pi = 3.14159265;
    }

    draw(){
        int i;
        int degrees;
        int radians;
        int[] mid;
        int[] end;

        i = 0
        while(i < sides){
            if(i == 0){
                radians = 0.0;
            }
            if(i != 0){
                degrees = (180 - 360/n) * i;
                radians = degrees*pi/180;
            }
            x = floatToInt(l*cos(radians));
            y = floatToInt(l*sin(radians));
            
            end = [x + start[0], y + start[1]];
            mid[0] = (start[0] + end[0]) / 2;
            mid[1] = (start[1] + end[1]) / 2;
            drawCurve(start, mid, end, 100, [0,150,0]);
            start = end;
        }
    }
}


func main() {
    Line l;
    l = shape Line([2,2], [200,200]);
}