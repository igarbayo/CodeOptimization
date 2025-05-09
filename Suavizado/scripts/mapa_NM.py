import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Configuración
resultados_dir = '../resultados'
loop_order = 'ijmn'
optimizaciones = ['O1', 'O1_unroll']

# Procesar solo los archivos de la versión ijmn
data = []
for filename in os.listdir(resultados_dir):
    if filename.startswith(loop_order) and filename.endswith('.txt'):
        try:
            # Extraer optimización
            loop_order, optimization_part = filename.split('_', 1)
            optimization = optimization_part.split('.')[0]
            
            # Leer archivo
            filepath = os.path.join(resultados_dir, filename)
            df = pd.read_csv(filepath, sep='\t', header=None,
                           names=['N', 'M', 'tiempo'])
            
            data.append((optimization, df))
            
        except Exception as e:
            print(f"Error procesando {filename}: {str(e)}")

# Crear matriz de datos para cada optimización
heatmap_data = {}
for opt in optimizaciones:
    # Filtrar y combinar datos de la optimización
    combined_df = pd.concat([df for o, df in data if o == opt])
    
    # Calcular media y crear matriz
    mean_times = combined_df.groupby(['N', 'M'])['tiempo'].mean().unstack()
    heatmap_data[opt] = mean_times.sort_index(axis=0).sort_index(axis=1)

# Configuración común para todos los heatmaps
vmin = min(df.min().min() for df in heatmap_data.values())
vmax = max(df.max().max() for df in heatmap_data.values())
cmap = 'viridis'
fmt = '.4f'
annot_kws = {'fontsize':8}

# Generar un heatmap por optimización
for opt, matrix in heatmap_data.items():
    plt.figure(figsize=(10, 8))
    sns.set_theme(style="whitegrid")
    
    ax = sns.heatmap(
        matrix, 
        annot=True, 
        fmt=fmt,
        cmap=cmap,
        vmin=vmin,
        vmax=vmax,
        cbar_kws={'label': 'Tiempo promedio (segundos)'},
        annot_kws=annot_kws,
        linewidths=0.5,
        linecolor='grey'
    )
    
    plt.title(f'Versión {loop_order} - Optimización {opt}\nMapa de Tiempos Promedio', pad=20)
    plt.xlabel('Valores de M', labelpad=10)
    plt.ylabel('Valores de N', labelpad=10)
    plt.xticks(rotation=45)
    plt.yticks(rotation=0)
    
    # Guardar y mostrar
    output_file = f'../graficas/heatmap_{loop_order}_{opt}.pdf'
    plt.tight_layout()
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    plt.close()
    
    print(f"Mapa de calor guardado en: {output_file}")