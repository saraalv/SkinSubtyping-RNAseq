
# NaiveBayes

load("data/rna1_data.RData")

library(e1071)

rna_naiveB <- naiveBayes(rna1_train, labels_train, laplace = 0)
rna_naiveB_pred <- predict(rna_naiveB, rna1_test)
cm <- confusionMatrix(rna_naiveB_pred, labels_test)
mnb <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

rna_naiveB1 <- naiveBayes(rna1_train, labels_train, laplace = 1)
rna_naiveB_pred1 <- predict(rna_naiveB1, rna1_test)
cm <- confusionMatrix(rna_naiveB_pred1, labels_test)
mnb1 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

## Tabla resumen de los resultados obtenidos 

tablaNB <- rbind(mnb,mnb1)
colnames(tablaNB) <- c("Accuracy", "Kappa", "Sensibilidad T1", "Especificidad T1", "Sensibilidad T2", "Especificidad T2", "Sensibilidad T3", "Especificidad T3")
rownames(tablaNB) <- c("Laplace = 0", "Laplace = 1")

kable(tablaNB) %>%
  kable_styling(bootstrap_options = Form.Basic) %>%
  row_spec(0, bold = T, color = "white", background = "seagreen3")%>%
  column_spec(1, bold = T)
