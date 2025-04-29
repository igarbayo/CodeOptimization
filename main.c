#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <math.h>

// Tamaño N del problema
int N[] = {
        10, 20, 30, 50, 75,
        100, 150, 200, 300, 450,
        600, 800, 1000, 1500, 2000,
        3000, 4500, 6000, 8000, 10000,
        15000, 20000, 30000, 40000, 60000,
        80000, 100000, 150000, 200000, 300000,
        400000, 600000, 800000, 1000000, 1500000,
        2000000, 3000000, 5000000, 7500000, 10000000
};

// Se ajusta para que cada par N[i], ITER[i] tarde más o menos lo mismo
// Basta con ajustar para que N[i] * ITER[i] se mantenga constante para todo i < TAM_N
int ITER[] = {
        10000000, 5000000, 3333333, 2000000, 1333333,
        1000000, 666666, 500000, 333333, 222222,
        166666, 125000, 100000, 66666, 50000,
        33333, 22222, 16666, 12500, 10000,
        6666, 5000, 3333, 2500, 1666,
        1250, 1000, 666, 500, 333,
        250, 166, 125, 100, 66,
        50, 33, 20, 13, 10
};


// Tamaño de los vectores N e ITER
#define TAM_N 40

// Ejecutamos cada par N[i], ITER[i] un número de REPETICIONES
#define REPETICIONES 25

// Macros para medir el tiempo
typedef struct timeval timeval_t;

timeval_t start_time, end_time, overhead_start, overhead_end;
double overhead = 0.0;

// tiene como objetivo estimar el tiempo que tarda en ejecutarse la propia medición del tiempo
// Mide el tiempo que se tarda en usar gettimeofday() dos veces seguidas.
void medir_overhead() {
    gettimeofday(&overhead_start, NULL);
    gettimeofday(&overhead_end, NULL);
    overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
               (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
}

void inicializar_datos() {
    // no hay que calentar la caché porque no se usa ningún vector
    // solo se utilizan 3 variables que estarán en la pila
}

// Comparador para qsort
int comparar_doubles(const void* a, const void* b) {
    double x = *(double*)a;
    double y = *(double*)b;
    return (x > y) - (x < y);
}

// Ordena el array y calcula la mediana (percentil 50)
double calcular_mediana(double* datos) {
    qsort(datos, REPETICIONES, sizeof(double), comparar_doubles);

    if (REPETICIONES % 2 == 0) {
        return (datos[REPETICIONES/2 - 1] + datos[REPETICIONES/2]) / 2.0;
    } else {
        return datos[REPETICIONES/2];
    }
}

// Cuantil 25 (Q1)
double calcular_cuantil_25(double* datos) {
    qsort(datos, REPETICIONES, sizeof(double), comparar_doubles);

    int idx = (int)(0.25 * (REPETICIONES - 1));
    return datos[idx];
}

// Cuantil 75 (Q3)
double calcular_cuantil_75(double* datos) {
    qsort(datos, REPETICIONES, sizeof(double), comparar_doubles);

    int idx = (int)(0.75 * (REPETICIONES - 1));
    return datos[idx];
}



int main() {

    FILE *file = fopen("FORMATO_resultados.txt", "w");  // Abrimos el archivo en modo escritura
    if (!file) {
        perror("No se pudo abrir el archivo para escribir");
        return EXIT_FAILURE;
    }

    // Escribimos la cabecera en el archivo
    fprintf(file, "N\tQ2_SIN\tQ1_SIN\tQ3_SIN\tQ2_OPT_OLD\tQ1_OPT_OLD\tQ3_OPT_OLD"
                  "\tQ2_OPT_NEW\tQ1_OPT_NEW\tQ3_OPT_NEW\n");
    //fprintf(file, "N\tQ2_SIN\tQ2_OPT_OLD\tQ2_OPT_NEW\n");

    inicializar_datos(); // Calentamiento de caché (no se hace)
    medir_overhead();
    printf("Overhead: %lf\n", overhead);

    for (int index = 0; index < TAM_N; index++) {
        // Accedemos a los valores necesarios
        int N_local = N[index];
        int ITER_local = ITER[index];

        // Variables locales
        int i, j, m3 = 8, m5 = 32;
        volatile int a = 0, b = 0;

        double tiempos_sin_opt[REPETICIONES];
        double tiempos_opt_old[REPETICIONES];
        double tiempos_opt_new[REPETICIONES];

        for (int k = 0; k < REPETICIONES; k++) {

            ///////////////////////////// SIN OPTIMIZACIÓN
            gettimeofday(&start_time, NULL);

            for (j = 0; j < ITER_local; j++) {
                for (i = 0; i < N_local; i++) {
                    a = i * m3;
                    b += a / m5;
                }
            }

            gettimeofday(&end_time, NULL);
            tiempos_sin_opt[k] = ((end_time.tv_sec - start_time.tv_sec +
                                   (end_time.tv_usec - start_time.tv_usec)/1.e6))/ITER_local;
            //////////////////////////////////////////////

            /////////////////////////////// OPTIMIZADA OLD
            gettimeofday(&start_time, NULL);

            for (j = 0; j < ITER_local; j++) {
                for (i = 0; i < N_local; i++) {
                    b += i >> 2;
                }
                a = (N_local - 1) << 3;
            }

            gettimeofday(&end_time, NULL);
            tiempos_opt_old[k] = ((end_time.tv_sec - start_time.tv_sec +
                                   (end_time.tv_usec - start_time.tv_usec)/1.e6))/ITER_local;
            //////////////////////////////////////////////

            /////////////////////////////// OPTIMIZADA NEW
            gettimeofday(&start_time, NULL);

            for (j = 0; j < ITER_local; j++) {
                for (i = 0; i < N_local; i++) {
                    a = i << 3;     // a = i * 8
                    b += a >> 5;    // b += a / 32
                }
            }

            gettimeofday(&end_time, NULL);
            tiempos_opt_new[k] = ((end_time.tv_sec - start_time.tv_sec +
                               (end_time.tv_usec - start_time.tv_usec)/1.e6))/ITER_local;
            //////////////////////////////////////////////


        }

        double q2_sin = calcular_mediana(tiempos_sin_opt);
        double q1_sin = calcular_cuantil_25(tiempos_sin_opt);
        double q3_sin = calcular_cuantil_75(tiempos_sin_opt);

        double q2_opt_old = calcular_mediana(tiempos_opt_old);
        double q1_opt_old = calcular_cuantil_25(tiempos_opt_old);
        double q3_opt_old = calcular_cuantil_75(tiempos_opt_old);

        double q2_opt_new = calcular_mediana(tiempos_opt_new);
        double q1_opt_new = calcular_cuantil_25(tiempos_opt_new);
        double q3_opt_new = calcular_cuantil_75(tiempos_opt_new);

        // Escribimos los resultados de esta iteración en el archivo
        fprintf(file, "%d\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\n",
                N[index],
                q2_sin, q1_sin, q3_sin,
                q2_opt_old, q1_opt_old, q3_opt_old,
                q2_opt_new, q1_opt_new, q3_opt_new);
        /*fprintf(file, "%d\t%.6f\t%.6f\t%.6f\n",
                N[index],
                q2_sin,
                q2_opt_old,
                q2_opt_new);*/

    }

    fclose(file);  // Cerramos el archivo
    return 0;
}