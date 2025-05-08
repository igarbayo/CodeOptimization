# Producto de matrices y optimizaciones

## Técnica utilizada

Partimos del siguiente código base:

```{c}
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
```

## Estructura de ficheros

El entregable presenta los siguientes ficheros:

- `code.c`: fichero de _benchmark_ para el algoritmo propuesto.

- `makefile`: fichero con las instrucciones de compilación necesarias para crear los programas ejecutables y los archivos
de codigo ensamblador. Se llama con `make` y se borran los ejecutables con `make clean`. Aparecen las instrucciones de
compilación con un valor de N de ejemplo. 

- `run_all.sh`: fichero con las instrucciones de ejecución para el _benchmark_. Antes de llamarlo, es necesario hacer
`chmod +x run_all.sh`, para otorgar los permisos de ejecución necesarios.

- `matrices.pdf`: informe sobre la práctica.

En `run_all.sh`, el número de veces que se efectúa cada experimento se puede modificar en la variable `REPS`.

## Estructura de carpetas

Además, se entregan varias carpetas adicionales:

- `/ensamblador` contiene los códigos en ensamblador generados durante la compilación.

- `/graficas` contiene los ficheros PDF con las gráficas realizadas. Se han realizado en R.

- `/objeto` contiene los códigos objeto (sin enlazar) de las diferentes optimizaciones.

- `/resultados` contiene los ficheros de salida de los _benchmarks_. Cada uno cuenta con una columna que indica el tamaño del
problema utilizado en la medida y otra con la medición en segundos.

- `/scripts` de R para la generación de las gráficas presentes en el informe. Las rutas de ficheros se encuentran definidas de forma global,
por lo que conviene modificar estos campos si se desea verificar su buen funcionamiento.
