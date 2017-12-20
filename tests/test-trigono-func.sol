/* @author: Kunal Baweja */

/* test trignonometric functions */

func main(){

    /* sine function */
    consolePrint(floatToString(sine(90.0)));
    consolePrint(floatToString(sine(180.0)));
    consolePrint(floatToString(sine(270.0)));
    consolePrint(floatToString(sine(-90.0)));

    /* cosine function */
    consolePrint(floatToString(cosine(90.0)));
    consolePrint(floatToString(cosine(180.0)));
    consolePrint(floatToString(cosine(270.0)));
    consolePrint(floatToString(cosine(0.0)));
}