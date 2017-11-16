func somefun() {
    return 42; /* Fail: return int from void function */
}

func int main() {
   somefun();
   return 0;
}
