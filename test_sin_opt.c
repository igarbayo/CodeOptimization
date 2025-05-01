#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>


// Archivo para resultados
char* nombre_archivo = "resultados/NOCHE-res_SIN_OPT.txt";

// Tamaño N del problema, evitando potencias enteras de 2
int N[] = {
    3000, 4500, 7000, 9500, 12000, 17000, 25000, 34000, 40000, 56000,
    78000, 95000, 110000, 160000, 250000, 320000, 390000, 570000, 820000,
    1000000, 1190000, 1500000, 1750000, 1990000, 2550000, 3190000, 4200000,
    5100000, 5900000, 7800000, 9500000, 11800000, 15900000, 23900000,
    53000000, 95000000, 199000000, 383000000, 959000000, 1910000000
};

// Tamaño del array N
#define TAM_N (sizeof(N) / sizeof(N[0]))
#define INDEX_FIN TAM_N
#define INDEX_INICIO 0

// Se ajusta para que cada par N[i], ITER[i] tarde más o menos lo mismo
// Basta con ajustar para que N[i] * ITER[i] se mantenga constante para todo i < TAM_N
void generar_ITER(int *ITER) {
    const long long PRODUCTO = 6400000000LL; 
    for (int i = 0; i < TAM_N; i++) {
        ITER[i] = (int)(PRODUCTO / N[i]); // División entera (truncamiento)
    }
}

// Ejecutamos cada par N[i], ITER[i] un número de REPETICIONES
#define REPETICIONES 20

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
        int N_local = N[index], ITER_local = ITER[index];

        for (int k = 0; k < REPETICIONES; k++) {

            ///////////////////////////// SIN OPTIMIZACIÓN
            b=0;
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
            //printf("%.6f\n", tiempos_sin_opt[k]);
            //////////////////////////////////////////////

            fprintf(file, "%d\t%.6f\n", N_local, tiempos_sin_opt[k]);
        }
    }

    fclose(file);  // Cerramos el archivo
    return 0;
}
