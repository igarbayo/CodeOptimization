# Leer los datos
datos_old <- read.table("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/resultados/res_OPT_OLD.txt", header = TRUE)
datos_sin <- read.table("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/resultados/res_SIN_OPT.txt", header = TRUE)

# Calcular la media de OPT_OLD para cada valor de N
medias_old <- aggregate(OPT_OLD ~ N, data = datos_old, FUN = mean)
medias_sin <- aggregate(SIN_OPT ~ N, data = datos_sin, FUN = mean)

datos <- merge(medias_old, medias_sin, by = "N")
names(datos) <- c("N", "MED_OLD", "MED_SIN")

### Tiempos

# Abrir el dispositivo gráfico PDF
pdf("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/graficas/tiempos.pdf", width = 7, height = 6)

ylim_range <- range(c(datos$MED_OLD, datos$MED_SIN))
plot(datos$N, datos$MED_OLD, type="n", ylim=ylim_range, xlab = "N (escala logarítmica)", ylab = "Tiempo (s)", 
     main = "Comparación entre medias", log = "xy")
axis(1, at = datos$N, labels = FALSE)
points(datos$N, datos$MED_OLD, col = "blue", pch = 3, cex = 1)
points(datos$N, datos$MED_SIN, col = "red", pch = 4, cex = 1)

lowess_old <- lowess(datos$N, datos$MED_OLD, f = 0.2)
lines(lowess_old, col = "blue", lwd = 1)
lowess_sin <- lowess(datos$N, datos$MED_SIN, f = 0.2)
lines(lowess_sin, col = "red", lwd = 1)

legend("topleft", 
       legend = c("SIN_OPT", "OPT_OLD"), 
       col = c("red", "blue"), 
       pch = c(4, 3),
       lwd = c(2, 2), 
       bty = "n", 
       inset = 0.02)

# 3. Cerrar el dispositivo gráfico
dev.off()


### Speedup

pdf("C:/Users/Ignacio/Desktop/OneDrive/Cuarto/Segundo Cuatri/Compiladores/p2 optim/graficas/speedup.pdf", width = 7, height = 6)

datos$speedup <- datos$MED_SIN / datos$MED_OLD
colores <- ifelse(datos$speedup > 1, "blue", "red")
plot(datos$N, datos$speedup, log="x", col = colores, 
     pch = 16, cex = 1, ylim = range(0.5, 1.5),
     xlab = "N (escala logarítmica)",
     ylab = "Aceleración (original/optimizado)",
     main = "Aceleración comparada")
abline(h = 1, col = "black", lty = 1, lwd = 1)  # h = valor de y


dev.off()


