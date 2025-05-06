# Peeling de lazos

## Técnica utilizada

Partimos del siguiente código base:

```{c}
for(k=0; k<ITER; k++) {
    for(i=0; i<N; i++) {
        if(i == N/2) {
            x[i] = 0;
        } else if(i == N-1) {
            x[i] = N-1;
        } else {
            x[i] = x[i] + y[i];
        }
    }
}
```

Se optimizará mediante el siguiente:

```{c}
for(k = 0; k<ITER; k++) {
    for(i = 0; i<N/2; i++) {
        x[i] = x[i] + y[i];
    }
    x[N/2]=0;
    for(i = N/2 + 1; i<N - 1; i++) {
        x[i] = x[i] + y[i];
    }
    x[N - 1] = N - 1;
}
```

## Estructura de ficheros

El entregable presenta los siguientes ficheros:

- `test_opt.c`: fichero de _benchmark_ para la versión optimizada.

- `test_sin_opt.c`: fichero de _benchmark_ para la versión original.

- `makefile`: fichero con las instrucciones de compilación necesarias para crear los programas ejecutables y los archivos
de codigo ensamblador. Se llama con `make` y se borran los ejecutables con `make clean`. Aparecen las instrucciones de
compilación con un valor de N de ejemplo, pues la compilación sobre el vector de tamaños se hará desde `run_all.sh`. 

- `run_all.sh`: fichero con las instrucciones de ejecución para los dos _benchmarks_. Antes de llamarlo, es necesario hacer
`chmod +x run_all.sh`, para otorgar los permisos de ejecución necesarios. Conoce en tiempo de compilación el valor de N y de
ITER, y los pasa como `#define` compilando con la opción `-D`.

- `P13.pdf`: informe sobre la práctica.

En los archivos de código C, la variable global `nombre_archivo` contiene el nombre fichero de salida con los resultados.

En `run_all.sh`, el número de veces que se efectúa cada experimento se puede modificar en la variable `REPS`.

## Estructura de carpetas

Además, se entregan varias carpetas adicionales:

- `/ensamblador` contiene los códigos en ensamblador generados durante la compilación.

- `/graficas` contiene los ficheros PDF con las gráficas realizadas. Se han realizado en R.

- `/resultados` contiene los ficheros de salida de los _benchmarks_. Cada uno cuenta con una columna que indica el tamaño del
problema utilizado en la medida y otra con la medición en segundos.

- `/scripts` de R para la generación de las gráficas presentes en el informe. Las rutas de ficheros se encuentran definidas de forma global,
por lo que conviene modificar estos campos si se desea verificar su buen funcionamiento.
