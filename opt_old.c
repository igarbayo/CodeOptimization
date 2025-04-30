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

    // Optimización old
    for (j = 0; j < ITER_local; j++) {
        for (i = 0; i < N_local; i++) {
            b += i >> 2;
        }
        a = (N_local - 1) << 3;
    }

    return 0;
}