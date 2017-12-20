/* @author: Kunal Baweja */

/* Describe a dancing line */ 

shape DanceLine {
    int [2]start;
    int [2]end;
    int [3]color;
    int freq;   /* oscillation frequency */
    int cnt;
    int d;      /* length change per iteration */

    /* constructor */
    construct(int [2]s, int [2]e, int[3]clr, int f) {
        start = s;
        end = e;
        color = clr; 
        freq = f;   
        cnt = 0;    /* initial counter */
        d = 2;  
    }

    /* drawing specification for single frame */
    draw(){
        int i;
        int [2]s;   /* control points for drawCurve */
        int [2]m;
        int [2]e;

        /* increment count on each frame */
        cnt = cnt + 1;

        if (cnt > freq) {
            d = -d;     /* reverse direction */
            cnt = 0;    /* reset freq counter */
        }

        /* change object length on one end */
        end[1] = end[1] + d;

        s = start;  /* end points of line */
        e = end;

        /* draw 10 bezier curves for thickness */
        i = 0;
        while (i < 10) {
            s[0] = s[0] + 1;
            e[0] = e[0] + 1;

            /* bezier curve mid point */            
            m[0] = (s[0] + e[0]) / 2;
            m[1] = (s[1] + e[1]) / 2;

            /* draw straight bezier curve */
            drawCurve(s, m, e, 2, color);
            i = i + 1;
        }
    }
}

shape DiscoBars {
    DanceLine d1;   /* member variables */
    DanceLine d2;
    DanceLine d3;

    construct () {
        /* instantiate DanceLine member variables */
        d1 = shape DanceLine([100, 300], [100, 252], [30, 144, 255], 20);
        d2 = shape DanceLine([130, 300], [130, 202], [210, 105, 30], 40);
        d3 = shape DanceLine([160, 300], [160, 132], [50, 205, 50], 80);
    }

    draw(){
        /* empty draw function 
         * draw functions of member variables
         * are called implicitly
         */
    }
}

func main() {
    DiscoBars bars;
    bars = shape DiscoBars();
}