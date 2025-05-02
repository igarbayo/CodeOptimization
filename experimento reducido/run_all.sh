#!/bin/bash

# Lista de ejecutables
executables=("DESP" "ARIT_SIN_POTENCIAS" "ARIT_CON_POTENCIAS")

# Recorremos cada ejecutable
for exe in "${executables[@]}"; do
    echo "Ejecutando $exe..."

    if [[ -x "$exe" ]]; then
        ./"$exe"
    else
        echo "⚠️ El ejecutable $exe no existe o no tiene permisos de ejecución."
    fi

    echo "----------------------------"
done

