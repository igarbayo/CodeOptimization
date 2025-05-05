#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>


// Archivo para resultados
char* nombre_archivo = "resultados/NOCHE-sin-opt.txt";

const long long PRODUCTO = 6400000000LL;

// Macros para medir el tiempo
typedef struct timeval timeval_t;
timeval_t start_time, end_time, overhead_start, overhead_end;
double overhead = 0.0;


int main(int argc, char **argv) {

    if (argc < 2) {
        perror("Falta el parámetro N.");
        return EXIT_FAILURE;
    }
    int N = atoi(argv[1]);

    // Imprimir o usar el valor de N
    printf("N recibido: %d\n", N);

    int ITER = (int)(PRODUCTO / N);

    FILE *file = fopen(nombre_archivo, "w");  // Abrimos el archivo en modo escritura
    if (!file) {
        perror("No se pudo abrir el archivo para escribir");
        return EXIT_FAILURE;
    }

    // Escribimos la cabecera en el archivo
    fprintf(file, "N\tSIN_OPT\n");

    // Variables locales
    int i, k;
    float x[N], y[N];
    double tiempo;

    // Fase de calentamiento de caché
    for (i = 0; i < N; i++) {
        x[i] = i;
        y[i] = i;
    }

    // Medir overhead
    // Tiene como objetivo estimar el tiempo que tarda en ejecutarse la propia medición del tiempo
    // Mide el tiempo que se tarda en usar gettimeofday() dos veces seguidas.
    gettimeofday(&overhead_start, NULL);
    gettimeofday(&overhead_end, NULL);
    overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
               (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;

    printf("Overhead: %lf\n", overhead);

    ///////////////////////////// SIN OPTIMIZACIÓN
    gettimeofday(&start_time, NULL);

    for(k=0; k<ITER; k++) {
        for(i=0; i<N; i++) {
            if(i==N/2) {
                x[i] = 0;
            } else if(i==N-1) {
                x[i] = N-1;
            } else {
                x[i] = x[i]+y[i];
            }
        }
    }

    gettimeofday(&end_time, NULL);
    tiempo = ((end_time.tv_sec - start_time.tv_sec +
             (end_time.tv_usec - start_time.tv_usec)/1.e6)
             - overhead)/ITER;
    //printf("%.6f\n", tiempo);
    //////////////////////////////////////////////

    fprintf(file, "%d\t%.6f\n", N, tiempo);

    fclose(file);  // Cerramos el archivo
    return 0;
}
