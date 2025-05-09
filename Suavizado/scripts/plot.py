import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Configuración de directorios y parámetros
resultados_dir = '../resultados'
N_grafica = 510
M_grafica = 510

# Leer todos los archivos de resultados
dataframes = []

for filename in os.listdir(resultados_dir):
    if filename.endswith('.txt'):
        # Extraer información del nombre del archivo
        parts = filename.split('_')
        loop_order = parts[0]
        optimization = '_'.join(parts[1:]).split('.')[0]  # Manejar nombres con múltiples _
        
        # Leer el archivo
        filepath = os.path.join(resultados_dir, filename)
        df = pd.read_csv(filepath, sep='\t', header=None, 
                        names=['N', 'M', 'tiempo'])
        
        # Añadir metadatos
        df['loop_order'] = loop_order
        df['optimizacion'] = optimization
        
        dataframes.append(df)

# Combinar todos los datos
full_df = pd.concat(dataframes, ignore_index=True)

# Filtrar y calcular medias
filtered_df = full_df[(full_df['N'] == N_grafica) & (full_df['M'] == M_grafica)]
mean_times = filtered_df.groupby(['loop_order', 'optimizacion'])['tiempo'].mean().reset_index()

# Configurar la gráfica
plt.figure(figsize=(18, 8))
sns.set_theme(style="whitegrid", palette="tab10")

# Crear el gráfico de puntos
scatter = sns.scatterplot(
    x='loop_order',
    y='tiempo',
    hue='optimizacion',
    style='optimizacion',
    data=mean_times,
    s=150,  # Tamaño de los puntos
    markers={'O1': 'o', 'O1_unroll': 'X'},  # Diferenciar por marcador
    edgecolor='black',
    linewidth=0.5
)

# Encontrar los mejores tiempos para cada optimización
best_o1 = mean_times[mean_times['optimizacion'] == 'O1'].nsmallest(1, 'tiempo')
best_o1_unroll = mean_times[mean_times['optimizacion'] == 'O1_unroll'].nsmallest(1, 'tiempo')

# Crear una paleta de colores consistente
palette = sns.color_palette("tab10")

# Marcar mejor O1 con anotación
for idx, row in best_o1.iterrows():
    plt.annotate('Mejor O1', 
                 (row['loop_order'], row['tiempo']),
                 textcoords="offset points",
                 xytext=(-15,20),
                 ha='center',
                 fontsize=10,
                 color=palette[0],
                 arrowprops=dict(arrowstyle="->", color=palette[0]))

# Marcar mejor O1_unroll con anotación
for idx, row in best_o1_unroll.iterrows():
    plt.annotate('Mejor O1_unroll', 
                 (row['loop_order'], row['tiempo']),
                 textcoords="offset points",
                 xytext=(15,-25),
                 ha='center',
                 fontsize=10,
                 color=palette[1],
                 arrowprops=dict(arrowstyle="->", color=palette[1]))

# Resaltar puntos con bordes gruesos
best_points = pd.concat([best_o1, best_o1_unroll])
sns.scatterplot(
    x='loop_order',
    y='tiempo',
    hue='optimizacion',
    data=best_points,
    s=200,
    edgecolor='black',
    linewidth=2,
    legend=False,
    ax=scatter
)

# Personalización avanzada
plt.title(f'Tiempos de ejecución promedio para N={N_grafica}, M={M_grafica}', fontsize=14, pad=20)
plt.xlabel('Orden de bucles', fontsize=12)
plt.ylabel('Tiempo (segundos)', fontsize=12)
plt.xticks(rotation=45, ha='right', fontsize=10)
plt.yticks(fontsize=10)

# Leyenda personalizada
handles, labels = scatter.get_legend_handles_labels()
plt.legend(
    handles=handles,
    title='Optimización',
    title_fontsize=12,
    fontsize=10,
    loc='upper right',
    frameon=True,
    shadow=True
)

# Añadir líneas de referencia
for loop_order in mean_times['loop_order'].unique():
    subset = mean_times[mean_times['loop_order'] == loop_order]
    plt.plot(
        [loop_order, loop_order],
        [subset['tiempo'].min(), subset['tiempo'].max()],
        color='gray',
        linestyle='--',
        alpha=0.4,
        linewidth=1
    )

# Ajustar layout y guardar
plt.tight_layout()
plt.savefig(f'../graficas/tiempos_N{N_grafica}_M{M_grafica}.pdf')
# plt.show()