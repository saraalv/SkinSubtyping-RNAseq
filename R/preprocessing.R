
rna1<- read.csv("data/rna1.csv")

# Preparación de los datos

rna1$Class <- as.factor(rna1$Class)  # transformaremos la variable `Class` de `character` a `factor`

# Se crean los training y test datasets dividiendo los datos en 2/3 training y 1/3 test.

set.seed(12345)
ntrain <- (2/3)*length(rna1$RTN2)
numtrain <- sample(length(rna1$RTN2),ntrain)
# para algunos algoritmos podremos utilizar el dataset completo y dividir únicamente en training y test 
rna1ds_train <- rna1[numtrain,]
rna1ds_test <- rna1[-numtrain,]
# mientras que en otros necesitaremos separar los datos de sus estiquetas. 
rna1_train <- rna1[numtrain,-1]
rna1_test <- rna1[-numtrain,-1]
labels_train <- rna1[numtrain,1]
labels_test <- rna1[-numtrain,1]


## Comprobamos que hay una distribución similar de los tres tipos de cáncer tanto en el train como en el test dataset.

prop.table(table(rna1ds_train$Class))
prop.table(table(rna1ds_test$Class))

## guardamos los objetos en un archivo RData
save(rna1_test, rna1_train, rna1ds_test, rna1ds_train, labels_test, labels_train,
      file = "data/rna1_data.RData")
