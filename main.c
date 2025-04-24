#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <math.h>

#define N 10007 // evitar potencias de 2 para no favorecer la localidad
#define REPETICIONES 4
#define NUM_ITER_VALUES 6
const int ITER_VALUES[NUM_ITER_VALUES] = {10, 100, 1000, 10000, 50000, 100000};

// Macros para medir el tiempo
typedef struct timeval timeval_t;

timeval_t start_time, end_time, overhead_start, overhead_end;
double overhead = 0.0;

void medir_overhead() {
    gettimeofday(&overhead_start, NULL);
    gettimeofday(&overhead_end, NULL);
    overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
               (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
}

void iniciar_medida() {
    gettimeofday(&start_time, NULL);
}

double finalizar_medida() {
    gettimeofday(&end_time, NULL);
    double tiempo = (end_time.tv_sec - start_time.tv_sec) +
                    (end_time.tv_usec - start_time.tv_usec) / 1e6;
    tiempo -= overhead;
    return tiempo;
}

void version_sin_optimizar(int* r, int iter) {
    int i, j, a, b = 0, m3 = 8, m5 = 32;
    for (j = 0; j < iter; j++) {
        for (i = 0; i < N; i++) {
            a = r[i] * m3;
            b += a / m5;
        }
    }
    volatile int sink = b; // evitar optimización del compilador
}

void version_optimizada(int* r, int iter) {
    int i, j, a, b = 0;
    for (j = 0; j < iter; j++) {
        for (i = 0; i < N; i++) {
            b += r[i] >> 2; // división por 4
        }
    }
    a = (r[N - 1]) << 3; // multiplicación por 8
    volatile int sink = b + a;
}

void inicializar_datos(int* r) {
    for (int i = 0; i < N; i++) {
        r[i] = i; // inicialización a mano, evita uso de rand()
    }
}

double calcular_media(double* tiempos) {
    double suma = 0.0;
    for (int i = 0; i < REPETICIONES; i++) {
        suma += tiempos[i];
    }
    return suma / REPETICIONES;
}

double calcular_desviacion(double* tiempos, double media) {
    double suma = 0.0;
    for (int i = 0; i < REPETICIONES; i++) {
        double diff = tiempos[i] - media;
        suma += diff * diff;
    }
    return sqrt(suma / REPETICIONES);
}

int main() {
    int* r = (int*)malloc(sizeof(int) * N);
    if (!r) {
        perror("malloc failed");
        return EXIT_FAILURE;
    }

    inicializar_datos(r); // Calentamiento de caché

    medir_overhead();

    for (int idx = 0; idx < NUM_ITER_VALUES; idx++) {
        int iter = ITER_VALUES[idx];
        double tiempos_sin_opt[REPETICIONES];
        double tiempos_opt[REPETICIONES];

        for (int i = 0; i < REPETICIONES; i++) {
            iniciar_medida();
            version_sin_optimizar(r, iter);
            tiempos_sin_opt[i] = finalizar_medida();

            iniciar_medida();
            version_optimizada(r, iter);
            tiempos_opt[i] = finalizar_medida();
        }

        double media_sin = calcular_media(tiempos_sin_opt);
        double desv_sin = calcular_desviacion(tiempos_sin_opt, media_sin);

        double media_opt = calcular_media(tiempos_opt);
        double desv_opt = calcular_desviacion(tiempos_opt, media_opt);

        printf("\nITER = %d (%d repeticiones):\n", iter, REPETICIONES);
        printf("Sin optimizar: Media = %.6f s, Desviacion = %.6f s\n", media_sin, desv_sin);
        printf("Optimizada   : Media = %.6f s, Desviacion = %.6f s\n", media_opt, desv_opt);
    }

    free(r);
    return 0;
}
