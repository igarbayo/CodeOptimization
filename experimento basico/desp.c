#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

// Archivo para resultados
char* nombre_archivo = "resultados/desp.txt";

// Tamaño N del problema, evitando potencias enteras de 2
int N = 95000;
int ITER = 67368;
#define REPETICIONES 10

// Macros para medir el tiempo
typedef struct timeval timeval_t;
timeval_t start_time, end_time, overhead_start, overhead_end;
double overhead = 0.0;

int main() {

    int a = 16;
    int b = 33;
    int c = 0;
    
    int i = 0;
    int j = 0;

    double tiempos[REPETICIONES];

    FILE *file = fopen(nombre_archivo, "w");
    if (!file) {
        perror("No se pudo abrir el archivo para escribir");
        return EXIT_FAILURE;
    }

    // Escribimos la cabecera en el archivo
    fprintf(file, "N\tDESP\n");

    // Medir overhead
    gettimeofday(&overhead_start, NULL);
    gettimeofday(&overhead_end, NULL);
    overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
               (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;

    printf("Overhead: %lf\n", overhead);

    // Operaciones
    for (int k = 0; k < REPETICIONES; k++) {
            gettimeofday(&start_time, NULL);

            for (j = 0; j < ITER; j++) {
                for (i = 0; i < N; i++) {
            		c = b << 4;
            	}
            }

            gettimeofday(&end_time, NULL);
            tiempos[k] = ((end_time.tv_sec - start_time.tv_sec +
                    (end_time.tv_usec - start_time.tv_usec)/1.e6) - overhead)/ITER;

            fprintf(file, "%d\t%.6f\n", N, tiempos[k]);
        }

    fclose(file);
    return 0;
}
