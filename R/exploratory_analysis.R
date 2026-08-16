
rna1<- read.csv(file.choose())

#------------------------------------------------------------------------
# Análisis Exploratorio 
#------------------------------------------------------------------------

dim(rna1)

table(is.na(rna1))  #comprueba si hay valores ausentes 

table(rna1$Class) #comprueba la cantidad de entradas para cada subtipo 

## observamos la distribucion de diferentes variables 

summary(rna1[c(1:3,20:23,199:201)])

col <- c("deepskyblue", "deepskyblue2","deepskyblue4", "darkslategray4", "darkseagreen4", "darkseagreen", "darkseagreen3","darkseagreen2","honeydew", "lemonchiffon","khaki1", "tan1", "coral", "salmon", "darksalmon", "peachpuff", "mistyrose", "pink", "palevioletred1","violetred2")
i <- 2
while (i <=182){
  boxplot(rna1[i:(i+19)], las = 2, col = col)
  i <- i+20
}

## Visualizamos la distribución de las expresiones de algunos de los genes según el tipo de cáncer
set.seed(12345)
par(mfrow=c(1,2))
nums <- sample(201,12)
for (i in nums){
  boxplot(rna1[,i]~rna1[,1], xlab = "Tipo de cáncer", ylab = colnames(rna1[i]), col = c("deepskyblue4", "gray","darkseagreen4"))
}

# -------------------------------------------------------------------------
# Análisis de componentes principales 
# -------------------------------------------------------------------------

cprna <- prcomp(rna1[-1])
# calculamos el porcentaje de variación explicado por cada componente principal
loads <- round(cprna$sdev^2/sum(cprna$sdev^2)*100,1)

# representamos gráficamente las diferentes muestras según sus dos primeros CPs. 

par(mfrow = c(1, 1))

xlab <- c(paste("PC1",loads[1],"%"))
ylab <- c(paste("PC2",loads[2],"%"))
colores<- c("deepskyblue4","gray","darkseagreen4")
plot(cprna$x[,1:2], xlab = xlab, ylab = ylab, col = colores[factor(rna1$Class)], pch = 19)
title("Gráficos de los 2 primero componentes\n principales en el dataset RNA1")
legend("topright", legend = levels(factor(rna1$Class)),
       pch = 19,
       col = colores,
       cex = 1)

