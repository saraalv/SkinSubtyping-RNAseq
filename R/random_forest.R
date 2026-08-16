
# Random Forest

load("data/rna1_data.RData")

library(randomForest)

set.seed(12345)
rf100 <- randomForest(Class~., data = rna1ds_train, ntree = 100)
rf100_pred <- predict(rf100, rna1ds_test)
cm <- confusionMatrix(rf100_pred,labels_test)
m100 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

rf200 <- randomForest(Class~., data = rna1ds_train, ntree = 200)
rf200_pred <- predict(rf200, rna1ds_test)
cm <- confusionMatrix(rf200_pred,labels_test)
m200 <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

# Representación de los resultados 

tablaRF <- rbind(ma,mab)
colnames(tablaRF) <- c("Accuracy", "Kappa", "Sensibilidad T1", "Especificidad T1", "Sensibilidad T2", "Especificidad T2", "Sensibilidad T3", "Especificidad T3")
rownames(tablaRF) <- c("100 árboles", "200 árboles")

kable(tablaRF) %>%
  kable_styling(bootstrap_options = Form.Basic)%>%
  row_spec(0, bold = T, color = "white", background = "seagreen3")%>%
  column_spec(1, bold = T)