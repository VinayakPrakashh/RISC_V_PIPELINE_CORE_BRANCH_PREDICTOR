// main.c — simple RISC-V test program
int main() {
    volatile int a = 10;
    volatile int b = 20;
    volatile int c = a + b;
    return c;  // return 30
}
