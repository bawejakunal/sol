/* @author Kunal Baweja */

func main() {
    /* test set and get framerate functions */
    consolePrint(intToString(getFramerate()));
    setFramerate(24);
    consolePrint(intToString(getFramerate()));
}