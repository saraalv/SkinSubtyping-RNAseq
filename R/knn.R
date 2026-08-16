
# k-Nearest Neighbour (k-NN)

load("data/rna1_data.RData")

# creamos una función de normalización minmax
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

rna_train_n <- as.data.frame(lapply(rna1_train,normalize))
rna_test_n <- as.data.frame(lapply(rna1_test,normalize))

# Comprobamos la correcta normalización con alguna de las variables

summary(rna_train_n$RTN2)
summary(rna_test_n$RTN2)

library(class)
library(caret)
knn1 <- knn(train = rna_train_n, test = rna_test_n, cl = labels_train, k = 1)
cm <- confusionMatrix(knn1, labels_test)
m1 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

knn3 <- knn(train = rna_train_n, test = rna_test_n, cl = labels_train, k = 3)
cm <- confusionMatrix(knn3, labels_test)
m3 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

knn5 <- knn(train = rna_train_n, test = rna_test_n, cl = labels_train, k = 5)
cm <- confusionMatrix(knn5, labels_test)
m5 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

knn7 <- knn(train = rna_train_n, test = rna_test_n, cl = labels_train, k = 7)
cm <- confusionMatrix(knn7, labels_test)
m7 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

knn11 <- knn(train = rna_train_n, test = rna_test_n, cl = labels_train, k = 11)
cm <- confusionMatrix(knn11, labels_test)
m11 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

## Tabla resumen de los resultados obtenidos

library(kableExtra)
tablaknn <- rbind(m1,m3,m5,m7,m11)
colnames(tablaknn) <- c("Accuracy", "Kappa", "Sensibilidad T1", "Especificidad T1", "Sensibilidad T2", "Especificidad T2", "Sensibilidad T3", "Especificidad T3")
rownames(tablaknn) <- c("K=1","K=3","K=5","K=7","K=11")
Form.Basic <- c("striped", "hover", "condensed", "responsive")
kable(tablaknn) %>%
  kable_styling(bootstrap_options = Form.Basic)%>%
  row_spec(0, bold = T, color = "white", background = "seagreen3")%>%
  column_spec(1, bold = T)
