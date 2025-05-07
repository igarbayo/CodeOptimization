#include <stdio.h>
#include <time.h>

#define Nmax 700

struct timespec inicio, final, overhead;
double tiempo, tiempo_overhead;

char* nombre_archivo;

void producto(float x, float y, float *z) {
    *z=x*y;
}

int main(int argc, char** argv) {
    float A[Nmax][Nmax], B[Nmax][Nmax], C[Nmax][Nmax], t, r;
    int i,j,k;

    // Abrir fichero de escritura
    if (argc < 2) {
        perror("Debes pasar un nombre de fichero");
        return 1;
    }
    nombre_archivo = argv[1];
    FILE* file = fopen(nombre_archivo, "a");
    if (file == NULL) {
        perror("No se pudo abrir el fichero");
        return 1;
    }

    // Calentamiento de la caché
    for(i=0;i<Nmax;i++) { /* Valores de las matrices */
        for(j=0;j<Nmax;j++) {
            A[i][j]=(i+j)/(j+1.1);
            B[i][j]=(i-j)/(j+2.1);
        }
    }
    
    // Medir el overhead
    clock_gettime(CLOCK_MONOTONIC, &overhead);
    clock_gettime(CLOCK_MONOTONIC, &inicio);

    for(j=0;j<Nmax;j++) { /* Producto matricial */
        for(i=0;i<Nmax;i++) {
            t=0;
            for (k=0;k<Nmax;k++) {
                producto(A[i][k],B[k][j],&r);
                t+=r; 
            }
            C[i][j]=t; 
        } 
    }

    clock_gettime(CLOCK_MONOTONIC, &final);

    // Cálculo de tiempos
    tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
    tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;

    // Imprimir en el archivo
    fprintf(file, "%d\t%.9f\n", Nmax, tiempo);

    // Cerrar el archivo
    fclose(file);
    return 0;
}

