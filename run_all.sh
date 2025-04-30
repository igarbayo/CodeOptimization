#!/bin/bash

# Lista de ejecutables
executables=("P2_OPT_OLD" "P2_SIN_OPT")

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

