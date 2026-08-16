
# Support Vector Machine 

load("data/rna1_data.RData")

library(kernlab)

# modelo lineal
cancer_linear_classifier <- ksvm(Class ~., data = rna1ds_train, kernel = "vanilladot")
linear_predictions <- predict(cancer_linear_classifier, rna1ds_test)

cm <- confusionMatrix(linear_predictions, labels_test)
ml <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )

# modelo gausiano
cancer_gaussian_classifier <- ksvm (Class ~., data = rna1ds_train, kernel = "rbfdot")
gaussian_predictions <- predict(cancer_gaussian_classifier, rna1ds_test)

# Representación de los resultados obtenidos 

cm <- confusionMatrix(gaussian_predictions, labels_test)
mg <- c(cm$overall[c(1,2)],cm$byClass[c(1,4,2,5,3,6)] )
tablaVM <- rbind(ml,mg)
colnames(tablaVM) <- c("Accuracy", "Kappa", "Sensibilidad T1", "Especificidad T1", "Sensibilidad T2", "Especificidad T2", "Sensibilidad T3", "Especificidad T3")
rownames(tablaVM) <- c("Kernel lineal", "Kernel rbf")

kable(tablaVM) %>%
  kable_styling(bootstrap_options = Form.Basic)%>%
  row_spec(0, bold = T, color = "white", background = "seagreen3")%>%
  column_spec(1, bold = T)