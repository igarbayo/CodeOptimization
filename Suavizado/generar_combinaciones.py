import os
import subprocess
from itertools import permutations

# Configuración
N_values = [120, 250, 380, 510, 600]
M_values = [128, 256, 380, 510, 600]
REPS = 100  # Número de repeticiones
loop_orders = [''.join(p) for p in permutations('ijmn')]  # 24 combinaciones
compilation_options = {  # Opciones de compilación
    'O1': '-O1',
    'O1_unroll': '-O1 -funroll-loops'
}

# Plantilla del código C adaptado
C_TEMPLATE = '''
#include <stdio.h>
#include <string.h>
#include <time.h>

#ifndef N
#error "Tienes que definir N"
#endif // N

#ifndef M
#error "Tienes que definir M"
#endif // M

void guardar_imagen(float I[N][M]);

struct timespec inicio, final, overhead;
double tiempo, tiempo_overhead;
char* nombre_archivo;

int main(int argc, char** argv) {{
    float I[N][M], Iprime[N][M];
    float sum[N][M] = {{0}};
    int count[N][M] = {{0}};
    int i, j, m, n;

    if (argc < 2) {{
        perror("Debes pasar un nombre de fichero");
        return 1;
    }}
    nombre_archivo = argv[1];
    FILE* file = fopen(nombre_archivo, "a");
    if (file == NULL) {{
        perror("No se pudo abrir el fichero");
        return 1;
    }}

    // Inicialización
    for (i = 0; i < N; ++i) {{
        for (j = 0; j < M; ++j) {{
            I[i][j] = (float)((i * M + j) % 256);
            Iprime[i][j] = 0.0f;
        }}
    }}

    // Medición de tiempo
    clock_gettime(CLOCK_MONOTONIC, &overhead);
    clock_gettime(CLOCK_MONOTONIC, &inicio);

    // Fase de acumulación
    {accumulation_code}

    // Fase de normalización
    for (i = 0; i < N; ++i) {{
        for (j = 0; j < M; ++j) {{
            Iprime[i][j] = (count[i][j] != 0) ? sum[i][j]/count[i][j] : 0.0f;
        }}
    }}

    clock_gettime(CLOCK_MONOTONIC, &final);
    tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
    tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9 - tiempo_overhead;

    fprintf(file, "%d\\t%d\\t%.9f\\n", N, M, tiempo);
    guardar_imagen(Iprime);
    fclose(file);
    return 0;
}}

void guardar_imagen(float Iprime[N][M]) {{
    // Implementación original...
}}
'''

# Generar archivos C para cada combinación
os.makedirs('resultados', exist_ok=True)
os.makedirs('codigos', exist_ok=True)
os.makedirs('ensamblador', exist_ok=True)
indent = '    '

for order in loop_orders:
    # Construir código de acumulación
    code_lines = []
    current_indent = ''
    
    # Bucles de acumulación según el orden
    for var in order:
        if var == 'i':
            code_lines.append(f'{current_indent}for (int i = 0; i < N; ++i) {{')
        elif var == 'j':
            code_lines.append(f'{current_indent}for (int j = 0; j < M; ++j) {{')
        elif var == 'm':
            code_lines.append(f'{current_indent}for (int m = -2; m <= 2; ++m) {{')
        elif var == 'n':
            code_lines.append(f'{current_indent}for (int n = -2; n <= 2; ++n) {{')
        current_indent += indent
    
    # Cuerpo del bucle interno
    code_lines.append(f'{current_indent}int x = i + m;')
    code_lines.append(f'{current_indent}int y = j + n;')
    code_lines.append(f'{current_indent}if (x >= 0 && x < N && y >= 0 && y < M) {{')
    code_lines.append(f'{current_indent}{indent}sum[i][j] += I[x][y];')
    code_lines.append(f'{current_indent}{indent}count[i][j]++;')
    code_lines.append(f'{current_indent}}}')
    
    # Cerrar bucles
    for _ in order:
        current_indent = current_indent[:-len(indent)]
        code_lines.append(f'{current_indent}}}')
    
    # Unir líneas y generar código C
    accumulation_code = '\n'.join(code_lines)
    c_code = C_TEMPLATE.format(accumulation_code=accumulation_code)
    
    # Escribir archivo
    with open(f'codigos/{order}.c', 'w') as f:
        f.write(c_code)

# Compilar y ejecutar todas las combinaciones
for order in loop_orders:
    for N in N_values:
        for M in M_values:
            for opt_key, opt_flags in compilation_options.items():  # iterar opciones
                # Nombres con sufijo de optimización
                output_file = f"resultados/{order}_{opt_key}.txt"
                ensamblador_file = f"ensamblador/{order}_{opt_key}.s"
                exec_name = f"suavizado_{order}_{N}_{M}_{opt_key}"
                
                # Comando de compilación actualizado
                compile_cmd = [
                    'gcc', 
                    f'-DN={N}', 
                    f'-DM={M}',
                    f'codigos/{order}.c', 
                    '-o', exec_name,
                    '-lm',
                    *opt_flags.split()  # añadir flags de optimización
                ]
                
                ensamblador_cmd = [
                	'gcc',
                	'-S',
                	f'-DN={N}', 
                    f'-DM={M}',
                	f'codigos/{order}.c', 
                    '-o', ensamblador_file,
                    '-lm',
                    *opt_flags.split()  # añadir flags de optimización
                ]
                
                try:
                    subprocess.run(compile_cmd, check=True)
                    subprocess.run(ensamblador_cmd, check=True)
                    # Ejecutar REPS veces
                    for _ in range(REPS):
                        subprocess.run(
                            [f'./{exec_name}', output_file],
                            check=True
                        )
                except subprocess.CalledProcessError as e:
                    print(f"Error en {order} N={N} M={M} Opt={opt_key}: {e}")
                finally:
                    if os.path.exists(exec_name):
                        os.remove(exec_name)


print("¡Proceso completado! Resultados en: resultados/*.txt")


