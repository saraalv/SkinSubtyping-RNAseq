
# Árboles de clasificación 

load("data/rna1_data.RData")

library(C50)

cancerc50 <- C5.0(rna1_train, labels_train)
c50_pred <- predict(cancerc50, rna1_test)
cm <- confusionMatrix(c50_pred,labels_test)
ma <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

c50boost10 <- C5.0(rna1_train, labels_train, trials = 10, control = C5.0Control(earlyStopping = FALSE))
cancerboost_pred <- predict(c50boost10, rna1_test)
cm <- confusionMatrix(cancerboost_pred, labels_test)
mab <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

# Representación de resultados 

tablaAC <- rbind(ma,mab)
colnames(tablaAC) <- c("Accuracy", "Kappa", "Sensibilidad T1", "Especificidad T1", "Sensibilidad T2", "Especificidad T2", "Sensibilidad T3", "Especificidad T3")
rownames(tablaAC) <- c("Sin boost", "Boost = 10")

kable(tablaAC) %>%
  kable_styling(bootstrap_options = Form.Basic)%>%
  row_spec(0, bold = T, color = "white", background = "seagreen3")%>%
  column_spec(1, bold = T)