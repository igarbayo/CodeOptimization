# Estudio de Optimización de Código

Este repositorio contiene el desarrollo y análisis de dos técnicas de optimización manual en código: **reemplazo de multiplicaciones/divisiones enteras por desplazamientos** y **peeling de lazos**.

## Instrucciones generales

Se han seguido las siguientes directrices comunes para ambas optimizaciones:

- Se ha implementado la optimización indicada en el enunciado, comparándola con la versión original sin optimizar.
- Las medidas de tiempo se han realizado con **al menos 10 ejecuciones por caso** para obtener estadísticas representativas.
- Las compilaciones se han realizado con la opción `-O0` para evitar interferencias de optimizaciones automáticas del compilador.
- Se ha realizado un **estudio de escalabilidad** en función del parámetro de tamaño del problema `N` y de otros parámetros relevantes en cada caso.

## Estructura del Repositorio

### `ShiftProduct/`

En esta carpeta se analiza el impacto del reemplazo de multiplicaciones y divisiones enteras por operaciones de desplazamiento de bits (`<<`, `>>`), donde es seguro hacerlo. Se compara el rendimiento antes y después de aplicar la optimización.

### `Peeling/`

Aquí se evalúa el uso de **peeling de lazos**, una técnica que consiste en separar iteraciones iniciales del bucle principal para mejorar la eficiencia, por ejemplo, en la alineación de datos o eliminación de dependencias.

### `Matrices/`

Dentro de este ejerciccio se analizan las diferentes opciones de optimización de código disponibles en GCC, a saber: O0, O1, O2, O3 y Os, sobre un problema de multiplicación de matrices cuadradas estáticas.

## Resultados

Los resultados de las pruebas y el análisis de escalabilidad se encuentran en los respectivos subdirectorios `resultados/` de cada técnica y en 
el informe correspondiente. Se incluyen gráficos, tablas de tiempos y comentarios sobre la influencia del tamaño del problema y de la optimización aplicada.
