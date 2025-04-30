//
// Created by ignacio on 30/04/25.
//

#include <stdio.h>

int main () {
    // Variables locales
    int i, j;
    volatile int a = 0, b = 0;
    int N_local = 1000;
    int ITER_local = 6000000;

    // Optimización new
    for (j = 0; j < ITER_local; j++) {
        for (i = 0; i < N_local; i++) {
            a = i << 3;     // a = i * 8
            b += a >> 5;    // b += a / 32
        }
    }

    return 0;
}