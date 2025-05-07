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
plot(datos$N, datos$MED_O0, type="n", ylim=ylim_range, xlab = "N", ylab = "Tiempo (s, escala logarítmica)", 
     main = "Comparación entre medias, desviaciones, máximos y mínimos", log = "y")
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


### Speedup 2-3

pdf("graficas/speedup2-3.pdf", width = 7, height = 6)

datos$speedup <- datos$MED_O2 / datos$MED_O3
colores <- ifelse(datos$speedup >= 1, "orange", "blue")
plot(datos$N, datos$speedup, col = colores, 
     pch = 16, cex = 0.7, ylim = range(0.5, 1.5),
     xlab = "N",
     ylab = "Aceleración (O2 / O3)",
     main = "Aceleración comparada")
abline(h = 1, col = "black", lty = 1, lwd = 0.5)  # h = valor de y
lines(datos$N, datos$speedup, col = "orange", lwd = 0.5)

# Primero dividimos los vectores según N
split_O3 <- split(datos_O3$O3, datos_O3$N)
split_O2 <- split(datos_O2$O2, datos_O2$N)

# Calcular cuantiles 25% y 75% para cada N
q25_O3 <- sapply(split_O3, function(x) quantile(x, probs = 0.25))
q75_O3 <- sapply(split_O3, function(x) quantile(x, probs = 0.75))
q25_O2 <- sapply(split_O2, function(x) quantile(x, probs = 0.25))
q75_O2 <- sapply(split_O2, function(x) quantile(x, probs = 0.75))

# Extraer números antes del primer punto
n_vals <- as.numeric(sub("\\..*", "", names(q25_O3)))

# Crear data.frames con nombres consistentes
cuantiles_O3_df <- data.frame(N = n_vals, Q25_O3 = q25_O3, Q75_O3 = q75_O3)
cuantiles_O2_df <- data.frame(N = n_vals, Q25_O2 = q25_O2, Q75_O2 = q75_O2)

# Unir con el dataframe principal
datos <- merge(datos, cuantiles_O3_df, by = "N")
datos <- merge(datos, cuantiles_O2_df, by = "N")

# Cuantil inferior del speedup (poca ganancia): SIN óptimo bajo / OLD óptimo alto
datos$Q25_SPEEDUP <- datos$Q25_O2 / datos$Q75_O3
# Cuantil superior del speedup (máxima ganancia): SIN óptimo alto / OLD óptimo bajo
datos$Q75_SPEEDUP <- datos$Q75_O2 / datos$Q25_O3

# Dibujar flechas solo si la diferencia entre Q75 y Q25 es mayor que un umbral
for (i in 1:nrow(datos)) {
  if (abs(datos$Q75_SPEEDUP[i] - datos$Q25_SPEEDUP[i]) > 1e-5) {
    arrows(datos$N[i], datos$Q25_SPEEDUP[i], 
           datos$N[i], datos$Q75_SPEEDUP[i], 
           col = colores[i], angle = 90, code = 3, length = 0.05)
  }
}

legend("topleft", 
       legend = c("Mejor O2", "Mejor O3"), 
       col = c("blue", "orange"), 
       pch = c(16, 16),
       bty = "n", 
       inset = 0.02)


dev.off()


### Speedup 2-s

pdf("graficas/speedup2-s.pdf", width = 7, height = 6)

datos$speedup <- datos$MED_O2 / datos$MED_Os
colores <- ifelse(datos$speedup >= 1, "green", "blue")
plot(datos$N, datos$speedup, col = colores, 
     pch = 16, cex = 0.7, ylim = range(0.5, 1.5),
     xlab = "N",
     ylab = "Aceleración (O2 / Os)",
     main = "Aceleración comparada")
abline(h = 1, col = "black", lty = 1, lwd = 0.5)  # h = valor de y
lines(datos$N, datos$speedup, col = "green", lwd = 0.5)

# Primero dividimos los vectores según N
split_Os <- split(datos_Os$Os, datos_Os$N)
split_O2 <- split(datos_O2$O2, datos_O2$N)

# Calcular cuantiles 25% y 75% para cada N
q25_Os <- sapply(split_Os, function(x) quantile(x, probs = 0.25))
q75_Os <- sapply(split_Os, function(x) quantile(x, probs = 0.75))
q25_O2 <- sapply(split_O2, function(x) quantile(x, probs = 0.25))
q75_O2 <- sapply(split_O2, function(x) quantile(x, probs = 0.75))

# Extraer números antes del primer punto
n_vals <- as.numeric(sub("\\..*", "", names(q25_O3)))

# Crear data.frames con nombres consistentes
cuantiles_Os_df <- data.frame(N = n_vals, Q25_Os = q25_Os, Q75_Os = q75_Os)
cuantiles_O2_df <- data.frame(N = n_vals, Q25_O2 = q25_O2, Q75_O2 = q75_O2)

# Unir con el dataframe principal
datos <- merge(datos, cuantiles_Os_df, by = "N")
datos <- merge(datos, cuantiles_O2_df, by = "N")

# Cuantil inferior del speedup (poca ganancia): SIN óptimo bajo / OLD óptimo alto
datos$Q25_SPEEDUP <- datos$Q25_O2 / datos$Q75_Os
# Cuantil superior del speedup (máxima ganancia): SIN óptimo alto / OLD óptimo bajo
datos$Q75_SPEEDUP <- datos$Q75_O2 / datos$Q25_Os

# Dibujar flechas solo si la diferencia entre Q75 y Q25 es mayor que un umbral
for (i in 1:nrow(datos)) {
  if (abs(datos$Q75_SPEEDUP[i] - datos$Q25_SPEEDUP[i]) > 1e-5) {
    arrows(datos$N[i], datos$Q25_SPEEDUP[i], 
           datos$N[i], datos$Q75_SPEEDUP[i], 
           col = colores[i], angle = 90, code = 3, length = 0.05)
  }
}

legend("topleft", 
       legend = c("Mejor O2", "Mejor Os"), 
       col = c("blue", "green"), 
       pch = c(16, 16),
       bty = "n", 
       inset = 0.02)


dev.off()


### Speedup 3-s

pdf("graficas/speedup3-s.pdf", width = 7, height = 6)

datos$speedup <- datos$MED_O3 / datos$MED_Os
colores <- ifelse(datos$speedup >= 1, "green", "orange")
plot(datos$N, datos$speedup, col = colores, 
     pch = 16, cex = 0.7, ylim = range(0.5, 1.5),
     xlab = "N",
     ylab = "Aceleración (O3 / Os)",
     main = "Aceleración comparada")
abline(h = 1, col = "black", lty = 1, lwd = 0.5)  # h = valor de y
lines(datos$N, datos$speedup, col = "green", lwd = 0.5)

# Primero dividimos los vectores según N
split_Os <- split(datos_Os$Os, datos_Os$N)
split_O3 <- split(datos_O3$O3, datos_O3$N)

# Calcular cuantiles 25% y 75% para cada N
q25_Os <- sapply(split_Os, function(x) quantile(x, probs = 0.25))
q75_Os <- sapply(split_Os, function(x) quantile(x, probs = 0.75))
q25_O3 <- sapply(split_O3, function(x) quantile(x, probs = 0.25))
q75_O3 <- sapply(split_O3, function(x) quantile(x, probs = 0.75))

# Extraer números antes del primer punto
n_vals <- as.numeric(sub("\\..*", "", names(q25_O3)))

# Crear data.frames con nombres consistentes
cuantiles_Os_df <- data.frame(N = n_vals, Q25_Os = q25_Os, Q75_Os = q75_Os)
cuantiles_O3_df <- data.frame(N = n_vals, Q25_O3 = q25_O3, Q75_O3 = q75_O3)

# Unir con el dataframe principal
datos <- merge(datos, cuantiles_Os_df, by = "N")
datos <- merge(datos, cuantiles_O3_df, by = "N")

# Cuantil inferior del speedup (poca ganancia): SIN óptimo bajo / OLD óptimo alto
datos$Q25_SPEEDUP <- datos$Q25_O3 / datos$Q75_Os
# Cuantil superior del speedup (máxima ganancia): SIN óptimo alto / OLD óptimo bajo
datos$Q75_SPEEDUP <- datos$Q75_O3 / datos$Q25_Os

# Dibujar flechas solo si la diferencia entre Q75 y Q25 es mayor que un umbral
for (i in 1:nrow(datos)) {
  if (abs(datos$Q75_SPEEDUP[i] - datos$Q25_SPEEDUP[i]) > 1e-5) {
    arrows(datos$N[i], datos$Q25_SPEEDUP[i], 
           datos$N[i], datos$Q75_SPEEDUP[i], 
           col = colores[i], angle = 90, code = 3, length = 0.05)
  }
}

legend("topleft", 
       legend = c("Mejor O3", "Mejor Os"), 
       col = c("orange", "green"), 
       pch = c(16, 16),
       bty = "n", 
       inset = 0.02)


dev.off()


