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
        10000000, 5000000, 3300000, 2000000, 1300000,
        1000000, 660000, 500000, 330000, 220000,
        160000, 120000, 100000, 66000, 50000,
        33000, 22000, 16000, 12000, 10000,
        6600, 5000, 3300, 2500, 1700,
        1300, 1000, 660, 500, 330,
        250, 170, 130, 100, 66,
        50, 33, 20, 13, 10
};

// Tamaño de los vectores N e ITER
#define TAM_N 4

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

void version_sin_optim(int N_local, int ITER_local) {
    int i, j, a, b = 0, m3 = 8, m5 = 32;
    for (j = 0; j < ITER_local; j++) {
        for (i = 0; i < N_local; i++) {
            a = i * m3;
            b += a / m5;
        }
    }
}

void version_optim(int N_local, int ITER_local) {
    int i, j, a, b = 0;
    for (j = 0; j < ITER_local; j++) {
        for (i = 0; i < N_local; i++) {
            b += i >> 2; // división por 4
        }
        a = (N_local - 1) << 3; // multiplicación por 8
    }

}

void inicializar_datos() {
    // no hay que calentar la caché porque no se usa ningún vector
    // solo se utilizan 3 variables que estarán en la pila
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

    
    FILE *file = fopen("resultados_pocos.txt", "w");  // Abrimos el archivo en modo escritura
    if (!file) {
        perror("No se pudo abrir el archivo para escribir");
        return EXIT_FAILURE;
    }

    // Escribimos la cabecera en el archivo
    fprintf(file, "N\tMED_SIN\tDESV_SIN\tMED_OPTIM\tDESV_OPTIM\n");

    inicializar_datos(); // Calentamiento de caché (no se hace)
    medir_overhead();

    for (int index = 0; index < TAM_N; index++) {
        // Accedemos a los valores necesarios
        int N_local = N[index];
        int ITER_local = ITER[index];

        double tiempos_sin_opt[REPETICIONES];
        double tiempos_opt[REPETICIONES];

        for (int i = 0; i < REPETICIONES; i++) {

            //////////// OPTIMIZADA
            iniciar_medida();

            // Versión optimizada
            version_optim(N_local, ITER_local);

            tiempos_opt[i] = finalizar_medida();
            ///////////////////////

            ///////// NO OPTIMIZADA
            iniciar_medida();

            // Versión sin optimizar
            version_sin_optim(N_local, ITER_local);

            tiempos_sin_opt[i] = finalizar_medida();
            ///////////////////////


        }

        double media_sin = calcular_media(tiempos_sin_opt);
        double desv_sin = calcular_desviacion(tiempos_sin_opt, media_sin);

        double media_opt = calcular_media(tiempos_opt);
        double desv_opt = calcular_desviacion(tiempos_opt, media_opt);

        // Escribimos los resultados de esta iteración en el archivo
        fprintf(file, "%d\t%.6f\t%.6f\t%.6f\t%.6f\n", N[index], media_sin, desv_sin, media_opt, desv_opt);
    }

    fclose(file);  // Cerramos el archivo
    return 0;
}
