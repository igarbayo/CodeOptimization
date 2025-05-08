# Directorio de trabajo
setwd("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p1-2 optim/Matrices")

# Leer los datos
datos_O0 <- read.table("resultados/O0.txt", header = TRUE)
datos_O1 <- read.table("resultados/O1.txt", header = TRUE)
datos_O2 <- read.table("resultados/O2.txt", header = TRUE)
datos_O3 <- read.table("resultados/O3.txt", header = TRUE)
datos_Os <- read.table("resultados/Os.txt", header = TRUE)

# Calcular la media para cada valor de N
medias_O0 <- aggregate(O0 ~ N, data = datos_O0, FUN = mean)
medias_O1 <- aggregate(O1 ~ N, data = datos_O1, FUN = mean)
medias_O2 <- aggregate(O2 ~ N, data = datos_O2, FUN = mean)
medias_O3 <- aggregate(O3 ~ N, data = datos_O3, FUN = mean)
medias_Os <- aggregate(Os ~ N, data = datos_Os, FUN = mean)

# Unir las medias en un df
datos <- merge(medias_O0, medias_O1, by = "N")
datos <- merge(datos, medias_O2, by = "N")
datos <- merge(datos, medias_O3, by = "N")
datos <- merge(datos, medias_Os, by = "N")
names(datos) <- c("N", "MED_O0", "MED_O1", "MED_O2", "MED_O3", "MED_Os")

# Calcular la desviación típica para cada valor de N
sd_O0 <- aggregate(O0 ~ N, data = datos_O0, FUN = sd)
sd_O1 <- aggregate(O1 ~ N, data = datos_O1, FUN = sd)
sd_O2 <- aggregate(O2 ~ N, data = datos_O2, FUN = sd)
sd_O3 <- aggregate(O3 ~ N, data = datos_O3, FUN = sd)
sd_Os <- aggregate(Os ~ N, data = datos_Os, FUN = sd)

# Unir las desviaciones típicas en un data frame
desviaciones <- merge(sd_O0, sd_O1, by = "N")
desviaciones <- merge(desviaciones, sd_O2, by = "N")
desviaciones <- merge(desviaciones, sd_O3, by = "N")
desviaciones <- merge(desviaciones, sd_Os, by = "N")
names(desviaciones) <- c("N", "SD_O0", "SD_O1", "SD_O2", "SD_O3", "SD_Os")
datos <- merge(datos, desviaciones, by = "N")

# Calcular mínimos y máximos para cada N
min_max_O0 <- aggregate(O0 ~ N, data = datos_O0, FUN = function(x) c(min = min(x), max = max(x)))
min_max_O1 <- aggregate(O1 ~ N, data = datos_O1, FUN = function(x) c(min = min(x), max = max(x)))
min_max_O2 <- aggregate(O2 ~ N, data = datos_O2, FUN = function(x) c(min = min(x), max = max(x)))
min_max_O3 <- aggregate(O3 ~ N, data = datos_O3, FUN = function(x) c(min = min(x), max = max(x)))
min_max_Os <- aggregate(Os ~ N, data = datos_Os, FUN = function(x) c(min = min(x), max = max(x)))

# Separar en columnas min y max
min_max_O0 <- data.frame(N = min_max_O0$N, MIN_O0 = min_max_O0$O0[, "min"], MAX_O0 = min_max_O0$O0[, "max"])
min_max_O1 <- data.frame(N = min_max_O1$N, MIN_O1 = min_max_O1$O1[, "min"], MAX_O1 = min_max_O1$O1[, "max"])
min_max_O2 <- data.frame(N = min_max_O2$N, MIN_O2 = min_max_O2$O2[, "min"], MAX_O2 = min_max_O2$O2[, "max"])
min_max_O3 <- data.frame(N = min_max_O3$N, MIN_O3 = min_max_O3$O3[, "min"], MAX_O3 = min_max_O3$O3[, "max"])
min_max_Os <- data.frame(N = min_max_Os$N, MIN_Os = min_max_Os$Os[, "min"], MAX_Os = min_max_Os$Os[, "max"])

# Unir con las medias
datos <- merge(datos, min_max_O0, by = "N")
datos <- merge(datos, min_max_O1, by = "N")
datos <- merge(datos, min_max_O2, by = "N")
datos <- merge(datos, min_max_O3, by = "N")
datos <- merge(datos, min_max_Os, by = "N")


### Tiempos general

# Abrir el dispositivo gráfico PDF
pdf("graficas/tiempos.pdf", width = 7, height = 6)

ylim_range <- range(c(datos$MED_O0, datos$MED_O1, datos$MED_O2, datos$MED_O3, datos$MED_Os))
plot(datos$N, datos$MED_O0, type="n", ylim=ylim_range, xlab = "N", ylab = "Tiempo (s)", 
     main = "Comparación entre medias, desviaciones, máxs. y míns.")
axis(1, at = datos$N, labels = FALSE)
points(datos$N, datos$MED_O0, col = "red", pch = 20, cex = 0.7)
points(datos$N, datos$MIN_O0, col = "red", pch = 20, cex = 0.7)
points(datos$N, datos$MAX_O0, col = "red", pch = 20, cex = 0.7)
points(datos$N, datos$MED_O1, col = "purple", pch = 20, cex = 0.7)
points(datos$N, datos$MIN_O1, col = "purple", pch = 20, cex = 0.7)
points(datos$N, datos$MAX_O1, col = "purple", pch = 20, cex = 0.7)
points(datos$N, datos$MED_O2, col = "blue", pch = 20, cex = 0.7)
points(datos$N, datos$MIN_O2, col = "blue", pch = 20, cex = 0.7)
points(datos$N, datos$MAX_O2, col = "blue", pch = 20, cex = 0.7)
points(datos$N, datos$MED_O3, col = "orange", pch = 20, cex = 0.7)
points(datos$N, datos$MIN_O3, col = "orange", pch = 20, cex = 0.7)
points(datos$N, datos$MAX_O3, col = "orange", pch = 20, cex = 0.7)
points(datos$N, datos$MED_Os, col = "green", pch = 20, cex = 0.7)
points(datos$N, datos$MIN_Os, col = "green", pch = 20, cex = 0.7)
points(datos$N, datos$MAX_Os, col = "green", pch = 20, cex = 0.7)

# Añadir líneas verticales para sd (como barras de error)
arrows(datos$N, datos$MED_O0 - datos$SD_O0, datos$N, datos$MED_O0 + datos$SD_O0, col = "red", angle = 90, code = 3, length = 0.05)
arrows(datos$N, datos$MED_O1 - datos$SD_O1, datos$N, datos$MED_O1 + datos$SD_O1, col = "purple", angle = 90, code = 3, length = 0.05)
arrows(datos$N, datos$MED_O2 - datos$SD_O2, datos$N, datos$MED_O2 + datos$SD_O2, col = "blue", angle = 90, code = 3, length = 0.05)
arrows(datos$N, datos$MED_O3 - datos$SD_O3, datos$N, datos$MED_O3 + datos$SD_O3, col = "orange", angle = 90, code = 3, length = 0.05)
arrows(datos$N, datos$MED_Os - datos$SD_Os, datos$N, datos$MED_Os + datos$SD_Os, col = "green", angle = 90, code = 3, length = 0.05)

lines(spline(datos$N, datos$MED_O0), col="red", lwd = 1)
lines(spline(datos$N, datos$MED_O1), col="purple", lwd = 1)
lines(spline(datos$N, datos$MED_O2), col="blue", lwd = 1)
lines(spline(datos$N, datos$MED_O3), col="orange", lwd = 1)
lines(spline(datos$N, datos$MED_Os), col="green", lwd = 1)

legend("topleft", 
       legend = c("O0", "O1", "O2", "O3", "Os"), 
       col = c("red", "purple", "blue", "orange", "green"), 
       pch = c(20, 20, 20, 20, 20),
       lwd = c(2, 2, 2, 2,2), 
       bty = "n", 
       inset = 0.02)

# 3. Cerrar el dispositivo grï¿½fico
dev.off()

