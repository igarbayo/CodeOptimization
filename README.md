# Reemplazo de multiplicaciones y divisiones enteras por operaciones de desplazamiento

## Técnica utilizada

Partimos del siguiente código base:

```{c}
int i, j, a, b=0, m3=8, m5=32;
for (j=0; j<ITER; j++)
    for (i=0; i<N; i++) {
        a = i * m3;
        b += a / m5;
    }
}
```

Se optimizará mediante el siguiente:

```{c}
for (j=0; j<ITER; j++) {
    for (i=0; i<N; i++) {
        b += i >> 2;
    }
    a= (N-1) << 3;
}
```

## Estructura de ficheros

El entregable presenta los siguientes ficheros:

- `test_opt.c`: fichero de _benchmark_ para la versión optimizada.

- `test_sin_opt.c`: fichero de _benchmark_ para la versión original.

- `makefile`: fichero con las instrucciones de compilación necesarias para crear los programas ejecutables y los archivos
de codigo ensamblador. Se llama con `make` y se borran los ejecutables con `make clean`.

- `run_all.sh`: fichero con las instrucciones de ejecución para los dos _benchmarks_. Antes de llamarlo, es necesario hacer
`chmod +x run_all.sh`, para otorgar los permisos de ejecución necesarios.

- `P12.pdf`: informe sobre la práctica.

En los archivos de código C:

- La variable global `nombre_archivo` contiene el nombre fichero de salida con los resultados.

- La variable global `N[]` representa el _array_ de tamaños del problema.

- El número de veces que se efectúa cada expermiento se puede modificar en la variable global `REPETICIONES`.

## Estructura de carpetas

Además, se entregna varias carpetas adicionales:

- `/ensamblador` contiene los códigos en ensamblador generados durante la compilación.

- `/expermiento reducido` contiene los ficheros necesarios para la programación, compilación y ejecución del experimento 
reducido del que habla en el informe.

- `/graficas` contiene los ficheros PDF con las gráficas realizadas. Se han realizado en R.

- `/resultados` contiene los ficheros de salida de los _benchmarks_. Cada uno cuenta con una columna que indica el tamaño del
problema utilizado en la medida y otra con la medición en segundos.

- `/scripts` de R para la generación de las gráficas presentes en el informe. Las rutas de ficheros se encuentran definidas de forma global,
por lo que conviene modificar estos campos si se desea verificar su buen funcionamiento.