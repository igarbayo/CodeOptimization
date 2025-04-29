
# Cargar el archivo como data.frame
datos <- read.table("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/FORMATO_resultados.txt", header = TRUE, sep = "\t")

head(datos)
str(datos)

# Graficar usando la función plot en R base con escala logarítmica en el eje X
ylim_range <- range(c(datos$Q1_SIN, datos$Q3_SIN,
                      datos$Q1_OPT_OLD, datos$Q3_OPT_OLD,
                      datos$Q1_OPT_NEW, datos$Q3_OPT_NEW))

# Crear la gráfica con escala logarítmica en el eje X
plot(datos$N, datos$Q2_SIN, type = "n", ylim = ylim_range, xlab = "N (escala logarítmica)", ylab = "Tiempo (s)", 
     main = "Comparación entre medianas y rango intercuartílico", log = "x")

# Añadir ticks en eje de N
axis(1, at = datos$N, labels = FALSE)

# Graficar el rango intercuartílico para la versión sin optimizar
arrows(datos$N, datos$Q1_SIN, datos$N, datos$Q3_SIN, angle = 90, code = 3, col = "red", length = 0.1)
# Graficar el rango intercuartílico para la versión optimizada old
arrows(datos$N, datos$Q1_OPT_OLD, datos$N, datos$Q3_OPT_OLD, angle = 90, code = 3, col = "blue", length = 0.1)
# Graficar el rango intercuartílico para la versión optimizada new
arrows(datos$N, datos$Q1_OPT_NEW, datos$N, datos$Q3_OPT_NEW, angle = 90, code = 3, col = "green", length = 0.1)


# Graficar las medianas
points(datos$N, datos$Q2_SIN, col = "red", pch = 16)  # Mediana sin optimizar
points(datos$N, datos$Q2_OPT_OLD, col = "blue", pch = 16)  # Mediana optimizada
points(datos$N, datos$Q2_OPT_NEW, col = "green", pch = 16)  # Mediana optimizada

# Unir con líneas las medianas
lowess_sin <- lowess(datos$N, datos$Q2_SIN, f = 0.3)
lines(lowess_sin, col = "red", lwd = 2)
lowess_opt_old <- lowess(datos$N, datos$Q2_OPT_OLD, f = 0.3)
lines(lowess_opt_old, col = "blue", lwd = 2)
lowess_opt_new <- lowess(datos$N, datos$Q2_OPT_NEW, f = 0.3)
lines(lowess_opt_new, col = "green", lwd = 2)

# Añadir la leyenda
legend("topleft", 
       legend = c("SIN", "OPT_OLD", "OPT_NEW"), 
       col = c("red", "blue", "green"), 
       pch = c(16, 16, 16), 
       lwd = c(2, 2, 2), 
       bty = "n", 
       inset = 0.02)
