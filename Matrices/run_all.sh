#!/bin/bash

# Mapear ejecutables a archivos de resultados
declare -A resultados
mkdir -p resultados
resultados["P1_O0"]="resultados/O0.txt"
resultados["P1_O1"]="resultados/O1.txt"
resultados["P1_O2"]="resultados/O2.txt"
resultados["P1_O3"]="resultados/O3.txt"
resultados["P1_Os"]="resultados/Os.txt"

# Lista de ejecutables
executables=("P1_O0" "P1_O1" "P1_O2" "P1_O3" "P1_Os")

# Número de repeticiones por N
REPS=20

# Recorremos cada ejecutable
for exe in "${executables[@]}"; do
    echo "Turno de $exe..."
    res="${resultados[$exe]}"
        if [[ -x "$exe" ]]; then
            for ((r=1; r<=REPS; r++)); do
            	# echo "    Repetición $r..."
            	./"$exe" "$res"
            done
        else
        	echo "⚠️ El ejecutable $exe no existe o no tiene permisos de ejecución."
    	fi
done

