/*@author: Erik Dyer & Kunal Baweja */

/* Test Triangle*/
/* Run this code, */


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
        int i;
        a = a_init;
        b = b_init;
        c = c_init;

        i = 0;
        while (i < 2) {
            abm[i] = (a[i] + b[i]) / 2;
            bcm[i] = (c[i] + b[i]) / 2;
            acm[i] = (a[i] + c[i]) / 2;
            i = i + 1;
        }

        findCenter(abm, a, b);
        findCenter(acm, a, c);
        findCenter(bcm, c, b);
    }

    draw() {
        /* Draw lines between the three vertices of the triangle*/
        drawCurve(a, abm, b, 2, [150, 0, 0]);
        drawCurve(b, bcm, c, 2, [0, 150, 0]);
        drawCurve(c, acm, a, 2, [0, 0, 150]);
    }
}

func main(){
	Triangle t;
	t = shape Triangle([170, 340], [470, 340], [320, 140]);

}
