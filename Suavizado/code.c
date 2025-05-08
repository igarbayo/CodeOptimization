#include <stdio.h>
#include <string.h>
#include <time.h>

#ifndef N
#error "Tienes que definir N"
#endif // N

#ifndef M
#error "Tienes que definir M"
#endif // M


// Cabeceras de función
void guardar_imagen(float I[N][M]);


// Variables globales
struct timespec inicio, final, overhead;
double tiempo, tiempo_overhead;

char* nombre_archivo;

int main(int argc, char** argv) {
	
    float I[N][M], Iprime[N][M];
    int i, j, m, n;

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
    for (int i = 0; i < N; ++i) {
    	for (int j = 0; j < M; ++j) {
    		// Inicializamos I con patrón simple tipo tablero
        	I[i][j] = (float)((i * M + j) % 256);
        	Iprime[i][j] = 0.0f;
    	}
	}

    
    // Medir el overhead
    clock_gettime(CLOCK_MONOTONIC, &overhead);
    // Medir el inicio
    clock_gettime(CLOCK_MONOTONIC, &inicio);

    // Algoritmo
    for (int i = 0; i < N; ++i) {
    	for (int j = 0; j < M; ++j) {
        	float sum = 0.0;
        	int count = 0;
        	for (int m = -2; m <= 2; ++m) {
            		for (int n = -2; n <= 2; ++n) {
                		int x = i + m;
                		int y = j + n;
                		if (x >= 0 && x < N && y >= 0 && y < M) {
                    			sum += I[x][y];
                    			count++;
                		}
            		}
        	}
        	Iprime[i][j] = sum / count;
    	}	
	}
 
	// Medir el final
    clock_gettime(CLOCK_MONOTONIC, &final);

    // Cálculo de tiempos
    tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
    tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
    tiempo = tiempo - tiempo_overhead;

    // Imprimir en el archivo
    fprintf(file, "%d\t%d\t%.9f\n", N, M, tiempo);
    
    // Imprimir la imagen resultante
    guardar_imagen(Iprime);

    // Cerrar el archivo
    fclose(file);
    return 0;
}



void guardar_imagen(float I[N][M]) {
	char nombre_base[256];
	const char *p = strrchr(nombre_archivo, '/');
	if (p) {
		p++; 	// avanzar tras la última '/'
	} else {
		p = nombre_archivo;
	}
	
	// Copiar desde nombre_archivo
	strncpy(nombre_base, p, sizeof(nombre_base));
	nombre_base[sizeof(nombre_base) - 1] = '\0';
	
	char *punto = strrchr(nombre_base, '.');
	if (punto) {
		*punto = '\0';	// eliminar extensión
	}
	
	// Crear nuevo nombre con .pgm
    char nombre_imagen[300];
    snprintf(nombre_imagen, sizeof(nombre_imagen), "%s.pgm", nombre_base);
	
	
	// Guardar la imagen
    FILE *f = fopen(nombre_imagen, "w");
    fprintf(f, "P2\n%d %d\n255\n", M, N);
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < M; ++j) {
            int val = (int)(I[i][j]);
            if (val < 0) val = 0;
            if (val > 255) val = 255;
            fprintf(f, "%d ", val);
        }
        fprintf(f, "\n");
    }
    fclose(f);
}


