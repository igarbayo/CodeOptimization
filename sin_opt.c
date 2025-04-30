#include <stdio.h>

int main () {
    // Variables locales
    int i, j, m3 = 8, m5 = 32;
    volatile int a = 0, b = 0;
    int N_local = 1000;
    int ITER_local = 6000000;

    // Sin optimizar
    for (j = 0; j < ITER_local; j++) {
        for (i = 0; i < N_local; i++) {
            a = i * m3;
            b += a / m5;
        }
    }

    return 0;
}
