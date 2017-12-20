/*@author: Erik Dyer */
/* Test Triangle Translate*/

func findCenter(int [2]m, int[2]x, int[2]y) {
    m[0] = (x[0] + y[0]) / 2;
    m[1] = (x[1] + y[1]) / 2;
}

shape Triangle {
    int[2] a;
    int[2] b;
    int[2] c;

    int[2] abm;
    int[2] bcm;
    int[2] acm;

    construct (int[2] a_init, int[2] b_init, int[2] c_init){
        a = a_init;
        b = b_init;
        c = c_init;

        findCenter(abm, a, b);
        findCenter(acm, a, c);
        findCenter(bcm, c, b); 
    }

    draw() {
        /* Draw lines between the three vertices of the triangle*/
        drawCurve(a, abm, b, 2, [150, 100, 0]);
        drawCurve(b, bcm, c, 2, [0, 150, 100]);
        drawCurve(c, acm, a, 2, [100, 0, 150]);
    }
}

func main(){
	Triangle t;
	t = shape Triangle([170, 340], [470, 340], [320, 140]);
    t.render = {
        translate([130, 130], 2);
        translate([-30, -130], 3);
        translate([-100, -100], 2);
    }
}
