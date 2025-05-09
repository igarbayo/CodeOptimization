# Suavizado de una imagen en escala de grises mediante vecindades \( 5\times 5 \)

## Técnica utilizada

Partimos de la operación de suavizado de una imagen de dimensiones \( N \times M \) en escala de grises a partir de vecindades de tamaño \( 5 \times 5 \), que viene dada por la fórmula siguiente:

\[
I^\prime (i,j) = \dfrac{1}{25}\, \sum_{m=-2}^2 \sum_{n=-2}^2 I(i+m, j+n),
\]

donde \( I \) es la matriz que representa los valores de los píxeles de la imagen original e \( I^\prime \) la asociada a la imagen suavizada.

## Estructura de ficheros

El entregable presenta los siguientes ficheros:

- `code.c`: fichero de _benchmark_ para el algoritmo propuesto, pero no se utiliza para el experimento, solo pretende ilustrar una estructura general.

- `generar_combinaciones.py`: script que permite generar los códigos C para las 24 permutaciones de los bucles en las 2 opciones de compilación a estudiar, sus códigos en ensamblador y ejecutar los experimentos.

- `suavizado.pdf`: informe sobre la práctica.

En `generar_combinaciones.py`, el número de veces que se efectúa cada experimento se puede modificar en la variable `REPS`.

## Estructura de carpetas

Además, se entregan varias carpetas adicionales:

- `/codigos` contiene los ficheros C generados mediante el script, para cada una de las 48 combinaciones de orden y optimización.

- `/ensamblador` contiene los códigos en ensamblador generados durante la compilación.

- `/graficas` contiene los ficheros PDF con las gráficas realizadas y un CSV con la tabala de análisis. Se han realizado en Python.

- `/resultados` contiene los ficheros de salida de los _benchmarks_. Cada uno cuenta con 2 columnas que indican el tamaño del
problema utilizado en la medida y otra con la medición en segundos.

- `/scripts` de Python para la generación de las gráficas presentes en el informe. 
