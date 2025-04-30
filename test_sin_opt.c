#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>


// Archivo para resultados
char* nombre_archivo = "resultados/res_SIN_OPT.txt";

// Tamaño N del problema, evitando potencias enteras de 2
int N[] = {
        3000, 12000, 40000, 110000, 390000, 1190000, 1990000,
        3190000, 5900000, 11800000, 23900000, 95000000,
        383000000, 959000000, 1910000000
};

// Tamaño del array N
#define TAM_N (sizeof(N) / sizeof(N[0]))
#define INDEX_FIN 11
#define INDEX_INICIO 10

// Se ajusta para que cada par N[i], ITER[i] tarde más o menos lo mismo
// Basta con ajustar para que N[i] * ITER[i] se mantenga constante para todo i < TAM_N
void generar_ITER(int *ITER) {
    const long long PRODUCTO = 4800000000LL; // 4.8e9
    for (int i = 0; i < TAM_N; i++) {
        ITER[i] = (int)(PRODUCTO / N[i]); // División entera (truncamiento)
    }
}

// Ejecutamos cada par N[i], ITER[i] un número de REPETICIONES
#define REPETICIONES 40

// Macros para medir el tiempo
typedef struct timeval timeval_t;
timeval_t start_time, end_time, overhead_start, overhead_end;
double overhead = 0.0;

int main() {

    int ITER[TAM_N]; // Array ITER del mismo tamaño que N
    generar_ITER(ITER); // Generar valores

    FILE *file = fopen(nombre_archivo, "w");  // Abrimos el archivo en modo escritura
    if (!file) {
        perror("No se pudo abrir el archivo para escribir");
        return EXIT_FAILURE;
    }

    // Escribimos la cabecera en el archivo
    fprintf(file, "N\tSIN_OPT\n");

    // no hay que calentar la caché porque no se usa ningún vector
    // solo se utilizan 3 variables que estarán en la pila

    // Medir overhead
    // Tiene como objetivo estimar el tiempo que tarda en ejecutarse la propia medición del tiempo
    // Mide el tiempo que se tarda en usar gettimeofday() dos veces seguidas.
    gettimeofday(&overhead_start, NULL);
    gettimeofday(&overhead_end, NULL);
    overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
               (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;

    printf("Overhead: %lf\n", overhead);

    // Variables locales
    int i, j, m3 = 8, m5 = 32, a = 0, b = 0;

    for (int index = INDEX_INICIO; index < INDEX_FIN; index++) {
        double tiempos_sin_opt[REPETICIONES];

        for (int k = 0; k < REPETICIONES; k++) {

            ///////////////////////////// SIN OPTIMIZACIÓN
            a=0, b=0;
            gettimeofday(&start_time, NULL);

            for (j = 0; j < ITER[index]; j++) {
                for (i = 0; i < N[index]; i++) {
                    a = i * m3;
                    b += a / m5;
                }
            }

            gettimeofday(&end_time, NULL);
            tiempos_sin_opt[k] = ((end_time.tv_sec - start_time.tv_sec +
                                   (end_time.tv_usec - start_time.tv_usec)/1.e6))/ITER[index];
            //printf("%.6f\n", tiempos_sin_opt[k]);
            //////////////////////////////////////////////

            fprintf(file, "%d\t%.6f\n", N[index], tiempos_sin_opt[k]);
        }
    }

    fclose(file);  // Cerramos el archivo
    return 0;
}
