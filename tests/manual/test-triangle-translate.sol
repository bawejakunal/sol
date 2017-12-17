/*@author: Erik Dyer*/

/* Test Triangle translate */
/* Run this code, */
shape Triangle {
    int[2] a;
    int[2] b;
    int[2] c;
    /* How much to translate triangle */
    int[2] disp;
    construct Triangle(int[2] a_init, int[2] b_init, int[2] c_init, int[2] disp_init){
        a = a_init;
        b = b_init;
        c = c_init;
        disp = disp_init
    }
 
    func int[] findCentre(int[2] x, int [2]y) {
        int i = 0;
        int [2] center;
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

   func render() {
        translate(disp);
   }
}

func main(){
	int[2] a = [0, 0];
	int[2] b = [2, 0];
	int[2] c = [1, 1];
    int[2] disp = [1,1];
	Triangle t = Triangle(a, b, c, disp);
}