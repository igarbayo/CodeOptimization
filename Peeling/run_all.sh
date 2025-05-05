#!/bin/bash

# Mapear ejecutables a archivos fuente
declare -A fuentes
fuentes["P2_OPT"]="test_opt.c"
fuentes["P2_SIN_OPT"]="test_sin_opt.c"  # Por ejemplo

# Lista de ejecutables
executables=("P2_OPT" "P2_SIN_OPT")

# Lista de valores de N
N=(
    3000 4500 7000 9500 12000 17000 25000 34000 40000 56000
    78000 95000 110000 160000 250000 320000 390000 570000 820000
    1000000 1190000 1500000 1750000 1990000 2550000 3190000 4200000
    5100000 5900000 7800000 9500000 11800000 15900000 23900000
    53000000 95000000 199000000 383000000 959000000
)

# Número de repeticiones por N
REPS=15

# Recorremos cada ejecutable
for exe in "${executables[@]}"; do

    
    echo "Turno de $exe..."
	
    src="${fuentes[$exe]}"
    
        for n in "${N[@]}"; do
            # echo "  N=$n"
            if [[ -f "$src" ]]; then
        	gcc -O0 -D N="$n" -D ITER="(7000000000LL/$n)" "$src" -o "$exe"
        	if [[ -x "$exe" ]]; then
        	    for ((r=1; r<=REPS; r++)); do
                	# echo "    Repetición $r..."
                	./"$exe" "$n"
            	    done
            	else
        	    echo "⚠️ El ejecutable $exe no existe o no tiene permisos de ejecución."
    		fi
            else
                echo "⚠️ No se encontró el archivo fuente $src para $exe"
            fi
        done
    
done

