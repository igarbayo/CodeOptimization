
# Cargar el archivo como data.frame
datos <- read.table("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/FORMATO_resultados.txt", header = TRUE, sep = "\t")

head(datos)
str(datos)

# Graficar usando la función plot en R base con escala logarítmica en el eje X
ylim_range <- range(c(datos$Q1_SIN, datos$Q3_SIN, datos$Q1_OPTIM, datos$Q3_OPTIM))

# Crear la gráfica con escala logarítmica en el eje X
plot(datos$N, datos$MED_SIN, type = "n", ylim = ylim_range, xlab = "N (escala logarítmica)", ylab = "Tiempo (s)", 
     main = "Comparación entre versión sin optimizar y optimizada", log = "x")


# Añadir ticks con etiquetas rotadas
axis(1, at = datos$N, labels = FALSE)  # solo ticks

# Graficar el rango intercuartílico para la versión sin optimizar
arrows(datos$N, datos$Q1_SIN, datos$N, datos$Q3_SIN, angle = 90, code = 3, col = "red", length = 0.1)
# Graficar el rango intercuartílico para la versión optimizada
arrows(datos$N, datos$Q1_OPTIM, datos$N, datos$Q3_OPTIM, angle = 90, code = 3, col = "blue", length = 0.1)

# Graficar las medianas
points(datos$N, datos$Q2_SIN, col = "red", pch = 16)  # Mediana sin optimizar
points(datos$N, datos$Q2_OPTIM, col = "blue", pch = 16)  # Mediana optimizada

# Unir con líneas las medianas
lowess_sin <- lowess(datos$N, datos$Q2_SIN, f = 0.3)
lines(lowess_sin, col = "red", lwd = 2)
lowess_optim <- lowess(datos$N, datos$Q2_OPTIM, f = 0.3)
lines(lowess_optim, col = "blue", lwd = 2)

# Añadir la leyenda
legend("topright", 
       legend = c("Q2_SIN", "Q2_OPTIM"), 
       col = c("red", "blue"), 
       pch = c(16, 16), 
       lwd = c(2, 2), 
       bty = "n", 
       inset = 0.02)
