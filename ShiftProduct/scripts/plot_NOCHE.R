# Leer los datos
datos_old <- read.table("/resultados/NOCHE_OPT_OLD.txt", header = TRUE)
datos_sin <- read.table("/resultados/NOCHE_SIN_OPT.txt", header = TRUE)

# Calcular la media de OPT_OLD para cada valor de N
medias_old <- aggregate(OPT_OLD ~ N, data = datos_old, FUN = mean)
medias_sin <- aggregate(SIN_OPT ~ N, data = datos_sin, FUN = mean)

datos <- merge(medias_old, medias_sin, by = "N")
names(datos) <- c("N", "MED_OLD", "MED_SIN")

# Calcular m�nimos y m�ximos para cada N
min_max_old <- aggregate(OPT_OLD ~ N, data = datos_old, FUN = function(x) c(min = min(x), max = max(x)))
min_max_sin <- aggregate(SIN_OPT ~ N, data = datos_sin, FUN = function(x) c(min = min(x), max = max(x)))

# Separar en columnas min y max
min_max_old <- data.frame(N = min_max_old$N, MIN_OLD = min_max_old$OPT_OLD[, "min"], MAX_OLD = min_max_old$OPT_OLD[, "max"])
min_max_sin <- data.frame(N = min_max_sin$N, MIN_SIN = min_max_sin$SIN_OPT[, "min"], MAX_SIN = min_max_sin$SIN_OPT[, "max"])

# Unir con las medias
datos <- merge(datos, min_max_old, by = "N")
datos <- merge(datos, min_max_sin, by = "N")


### Tiempos

# Abrir el dispositivo gr�fico PDF
pdf("/graficas/NOCHE_tiempos.pdf", width = 7, height = 6)

ylim_range <- range(c(datos$MED_OLD, datos$MED_SIN))
plot(datos$N, datos$MED_OLD, type="n", ylim=ylim_range, xlab = "N (escala logar�tmica)", ylab = "Tiempo (s, escala logar�tmica)", 
     main = "Comparaci�n entre medias, m�ximos y m�nimos", log = "xy")
axis(1, at = datos$N, labels = FALSE)
points(datos$N, datos$MED_OLD, col = "blue", pch = 22, cex = 1)
points(datos$N, datos$MED_SIN, col = "red", pch = 21, cex = 1)

# A�adir l�neas verticales para min y max (como barras de error)
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

# 3. Cerrar el dispositivo gr�fico
dev.off()


### Speedup

pdf("/graficas/NOCHE_speedup.pdf", width = 7, height = 6)

datos$speedup <- datos$MED_SIN / datos$MED_OLD
colores <- ifelse(datos$speedup > 1, "blue", "red")
plot(datos$N, datos$speedup, log="x", col = colores, 
     pch = 16, cex = 1, ylim = range(0.5, 1.5),
     xlab = "N (escala logar�tmica)",
     ylab = "Aceleraci�n (operaciones / desplazamientos)",
     main = "Aceleraci�n comparada")
abline(h = 1, col = "black", lty = 1, lwd = 1)  # h = valor de y

legend("topleft", 
       legend = c("Mejor multiplicaciones y divisiones", "Mejor desplazamientos"), 
       col = c("red", "blue"), 
       pch = c(16, 16),
       bty = "n", 
       inset = 0.02)


dev.off()


