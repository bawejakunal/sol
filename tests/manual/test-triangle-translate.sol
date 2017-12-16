/* Test Triangle translate */
/* Run this code, */
shape Triangle {
    int[2] a;
    int[2] b;
    int[2] c;
    /* How much to translate triangle */

    construct Triangle(int[2] a_init, int[2] b_init, int[2] c_init){
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
}

func main(){
    	int[2] disp;
	Triangle t;
	
	disp = [1,1];
	Triangle t = Triangle([0, 0], [2, 0], [1, 1]);
	
	t.render = {
		translate(disp);
	}
}
