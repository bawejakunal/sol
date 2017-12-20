/*@author: Erik DYer*/

/* Test drawing an n sided polygon */ 

shape Polygon{
    int [2]start;
    int sides;
    int length;
    construct(int [2]s, int l, int n) {
        start = s;
        sides = n;
	length = l;
    }

    draw(){
        int i;
        float degrees;
        float radians;
        int[] mid;
        int[] end;

        i = 0
        while(i < sides){
            if(i == 0){
                degrees = 0.0;
            }
            if(i != 0){
                degrees = (180 - 360/n) * i;
            }
            x = floatToInt(length*cos(degrees));
            y = floatToInt(length*sin(degrees));
            
            end = [x + start[0], y + start[1]];
            mid[0] = (start[0] + end[0]) / 2;
            mid[1] = (start[1] + end[1]) / 2;
            drawCurve(start, mid, end, 100, [0,150,0]);
            start = end;
        }
    }
}


func main() {
    Polygon p;
    p = shape Polygon([2,2], 100, 5);
}
