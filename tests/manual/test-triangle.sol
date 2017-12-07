/* Test Triangle*/
/* Run this code, */
shape Triangle {
    int[2] a;
    int[2] b;
    int[2] c;
    construct Triangle(int[2] a_init, int[2] b_init, int[2] c_init) {
        a = a_init;
        b = b_init;
        c = c_init;
    }
 
    func int[] findCentre(int[2] x, int [2]y) {
        int i = 0;
        int center[2];
        while(i < 2) {
            center[i] = a[i] + b[i] / 2;
            i = i + 1;
        }
        return center;
    }
    func draw() {
        /* Draw lines between the three vertices of the triangle */
         drawcurve(a, findCentre(a, b), b, [255, 0, 0]);
        drawcurve(b, findCentre(b, c), c, [0, 255, 0]);
        drawcurve(c, findCentre(c, a), a, [0, 0, 255]);
   }
}

func main(){
	int[2] a = [0, 0];
	int[2] b = [2, 0];
	int[2] c = [1, 1];
	Triangle t = Triangle(a, b, c);
}
 

