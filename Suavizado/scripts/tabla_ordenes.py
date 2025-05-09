import os
import pandas as pd
import numpy as np

# Configuración
resultados_dir = '../resultados'
N_values = [120, 250, 380, 510, 600]
M_values = [128, 256, 380, 510, 600]
output_file = '../graficas/mejores_ordenes.csv'

# Procesar todos los archivos
all_data = []

for filename in os.listdir(resultados_dir):
    if filename.endswith('.txt'):
        try:
            # Parsear nombre
            loop_order, optimization_part = filename.split('_', 1)
            optimization = optimization_part.split('.')[0]
            
            # Leer archivo
            filepath = os.path.join(resultados_dir, filename)
            df_file = pd.read_csv(filepath, sep='\t', header=None,
                                names=['N', 'M', 'tiempo'])
            
            # Filtrar y añadir metadatos
            df_filtered = df_file[
                df_file['N'].isin(N_values) & 
                df_file['M'].isin(M_values)
            ].copy()
            df_filtered['loop_order'] = loop_order
            df_filtered['optimizacion'] = optimization
            
            all_data.append(df_filtered)
            
        except Exception as e:
            print(f"Error procesando {filename}: {str(e)}")

# Combinar datos
full_df = pd.concat(all_data, ignore_index=True)

# Paso 1: Calcular medias por versión y par N-M
medias_por_version = full_df.groupby(
    ['N', 'M', 'loop_order', 'optimizacion']
)['tiempo'].mean().unstack().reset_index()

# Paso 2: Encontrar mejores versiones para cada optimización
mejores_o1 = medias_por_version.groupby(
    ['N', 'M']
)['O1'].idxmin().reset_index()
mejores_o1 = medias_por_version.loc[mejores_o1['O1']][
    ['N', 'M', 'loop_order', 'O1']]
mejores_o1.columns = ['N', 'M', 'Mejor_O1', 'Media_O1']

mejores_unroll = medias_por_version.groupby(
    ['N', 'M']
)['O1_unroll'].idxmin().reset_index()
mejores_unroll = medias_por_version.loc[mejores_unroll['O1_unroll']][
    ['N', 'M', 'loop_order', 'O1_unroll']]
mejores_unroll.columns = ['N', 'M', 'Mejor_O1_unroll', 'Media_Unroll']

# Paso 3: Combinar resultados
tabla_final = pd.merge(
    mejores_o1, 
    mejores_unroll, 
    on=['N', 'M'], 
    how='inner'
)

# Calcular diferencia
tabla_final['Diferencia (%)'] = np.round(
    (tabla_final['Media_Unroll'] - tabla_final['Media_O1']) / 
    tabla_final['Media_O1'] * 100, 
    2
)

# Reordenar columnas
tabla_final = tabla_final[[
    'N', 'M', 
    'Mejor_O1', 'Media_O1', 
    'Mejor_O1_unroll', 'Media_Unroll', 
    'Diferencia (%)'
]]

# Guardar y mostrar
tabla_final.to_csv(output_file, index=False)
print("Tabla de medias generada con éxito!\n")
print(tabla_final.to_markdown(index=False))