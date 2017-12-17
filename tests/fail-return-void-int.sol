/*@author: Erik Dyer*/

func somefun() {
    return 42; /* Fail: return int from void function */
}

func main() {
   somefun();
}
