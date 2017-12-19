/* @author: Kunal Baweja */

shape Text {
    int [2]loc;
    int [3]clr;
    string text;

    construct(int [2]l, string t, int [3]c) {
        loc = l;
        clr = c;
        text = t;
    }

    draw(){
        print(loc, text, clr);
    }
}

func main() {
    Text t;
    t = shape Text([280, 240], "Welcome to SOL !", [0, 100, 100]);
}