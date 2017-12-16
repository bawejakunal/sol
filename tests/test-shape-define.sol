shape Circle{
    int [2]center;
    int radius;
    construct(int [2]c, int r) {
        center[0] = c[0];
        center[1] = c[1];
        radius = r;
    }

    draw() {}

    func describe() {
        consolePrint("Center X");
        consolePrint(intToString(center[0]));
        consolePrint("Center Y");
        consolePrint(intToString(center[1]));
        consolePrint("Radius");
        consolePrint(intToString(radius));
    }
}
func main() {
    Circle c;
    int a;

    c = shape Circle([3, 5], 5);
    c.describe();

    /* change member variables */
    c.center[0] = -3;
    c.center[1] = -5;
    c.radius = 30;
    c.describe();
}