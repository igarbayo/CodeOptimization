
#include <stdio.h>
#include <string.h>
#include <time.h>

#ifndef N
#error "Tienes que definir N"
#endif // N

#ifndef M
#error "Tienes que definir M"
#endif // M

void guardar_imagen(float I[N][M]);

struct timespec inicio, final, overhead;
double tiempo, tiempo_overhead;
char* nombre_archivo;

int main(int argc, char** argv) {
    float I[N][M], Iprime[N][M];
    float sum[N][M] = {0};
    int count[N][M] = {0};
    int i, j, m, n;

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

    // Inicialización
    for (i = 0; i < N; ++i) {
        for (j = 0; j < M; ++j) {
            I[i][j] = (float)((i * M + j) % 256);
            Iprime[i][j] = 0.0f;
        }
    }

    // Medición de tiempo
    clock_gettime(CLOCK_MONOTONIC, &overhead);
    clock_gettime(CLOCK_MONOTONIC, &inicio);

    // Fase de acumulación
    for (int i = 0; i < N; ++i) {
    for (int n = -2; n <= 2; ++n) {
        for (int m = -2; m <= 2; ++m) {
            for (int j = 0; j < M; ++j) {
                int x = i + m;
                int y = j + n;
                if (x >= 0 && x < N && y >= 0 && y < M) {
                    sum[i][j] += I[x][y];
                    count[i][j]++;
                }
            }
        }
    }
}

    // Fase de normalización
    for (i = 0; i < N; ++i) {
        for (j = 0; j < M; ++j) {
            Iprime[i][j] = (count[i][j] != 0) ? sum[i][j]/count[i][j] : 0.0f;
        }
    }

    clock_gettime(CLOCK_MONOTONIC, &final);
    tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
    tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9 - tiempo_overhead;

    fprintf(file, "%d\t%d\t%.9f\n", N, M, tiempo);
    guardar_imagen(Iprime);
    fclose(file);
    return 0;
}

void guardar_imagen(float Iprime[N][M]) {
    // Implementación original...
}
