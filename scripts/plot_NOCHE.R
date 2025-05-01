# Leer los datos
datos_old <- read.table("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/resultados/NOCHE_OPT_OLD.txt", header = TRUE)
datos_sin <- read.table("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/resultados/NOCHE_SIN_OPT.txt", header = TRUE)

# Calcular la media de OPT_OLD para cada valor de N
medias_old <- aggregate(OPT_OLD ~ N, data = datos_old, FUN = mean)
medias_sin <- aggregate(SIN_OPT ~ N, data = datos_sin, FUN = mean)

datos <- merge(medias_old, medias_sin, by = "N")
names(datos) <- c("N", "MED_OLD", "MED_SIN")

# Calcular mï¿½nimos y mï¿½ximos para cada N
min_max_old <- aggregate(OPT_OLD ~ N, data = datos_old, FUN = function(x) c(min = min(x), max = max(x)))
min_max_sin <- aggregate(SIN_OPT ~ N, data = datos_sin, FUN = function(x) c(min = min(x), max = max(x)))

# Separar en columnas min y max
min_max_old <- data.frame(N = min_max_old$N, MIN_OLD = min_max_old$OPT_OLD[, "min"], MAX_OLD = min_max_old$OPT_OLD[, "max"])
min_max_sin <- data.frame(N = min_max_sin$N, MIN_SIN = min_max_sin$SIN_OPT[, "min"], MAX_SIN = min_max_sin$SIN_OPT[, "max"])

# Unir con las medias
datos <- merge(datos, min_max_old, by = "N")
datos <- merge(datos, min_max_sin, by = "N")


### Tiempos

# Abrir el dispositivo grï¿½fico PDF
pdf("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/graficas/NOCHE_tiempos.pdf", width = 7, height = 6)

ylim_range <- range(c(datos$MED_OLD, datos$MED_SIN))
plot(datos$N, datos$MED_OLD, type="n", ylim=ylim_range, xlab = "N (escala logarítmica)", ylab = "Tiempo (s, escala logarítmica)", 
     main = "Comparación entre medias, máximos y mínimos", log = "xy")
axis(1, at = datos$N, labels = FALSE)
points(datos$N, datos$MED_OLD, col = "blue", pch = 22, cex = 1)
points(datos$N, datos$MED_SIN, col = "red", pch = 21, cex = 1)

# Aï¿½adir lï¿½neas verticales para min y max (como barras de error)
arrows(datos$N, datos$MIN_OLD, datos$N, datos$MAX_OLD, col = "blue", angle = 90, code = 3, length = 0.05)
arrows(datos$N, datos$MIN_SIN, datos$N, datos$MAX_SIN, col = "red", angle = 90, code = 3, length = 0.05)

curve_old <- spline(datos$N, datos$MED_OLD)
lines(curve_old, col="blue", lwd = 1)
curve_sin <- spline(datos$N, datos$MED_SIN)
lines(curve_sin, col="red", lwd = 1)

legend("topleft", 
       legend = c("Multiplicaciones y divisiones", "Desplazamientos"), 
       col = c("red", "blue"), 
       pch = c(21, 22),
       lwd = c(2, 2), 
       bty = "n", 
       inset = 0.02)

# 3. Cerrar el dispositivo grï¿½fico
dev.off()


### Speedup

pdf("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/graficas/NOCHE_speedup.pdf", width = 7, height = 6)

datos$speedup <- datos$MED_SIN / datos$MED_OLD
colores <- ifelse(datos$speedup > 1, "blue", "red")
plot(datos$N, datos$speedup, log="x", col = colores, 
     pch = 16, cex = 1, ylim = range(0.5, 1.5),
     xlab = "N (escala logarítmica)",
     ylab = "Aceleración (operaciones / desplazamientos)",
     main = "Aceleración comparada")
abline(h = 1, col = "black", lty = 1, lwd = 1)  # h = valor de y

legend("topleft", 
       legend = c("Mejor multiplicaciones y divisiones", "Mejor desplazamientos"), 
       col = c("red", "blue"), 
       pch = c(16, 16),
       bty = "n", 
       inset = 0.02)


dev.off()


