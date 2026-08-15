# SkinSubtyping-RNAseq

## Machine learning classification of skin cancer subtypes from RNA-seq data

This project develops and evaluates different machine learning
classifiers for predicting skin cancer subtypes from gene expression
data obtained through RNA-seq.

The analysis is implemented in **R** and compares several supervised
learning approaches, including k-Nearest Neighbours, Naive Bayes,
neural networks, Support Vector Machines, classification trees and
Random Forest.

---

## Overview

Cancer development is associated with genetic and molecular changes
that can be studied through gene expression profiles.

This project investigates whether RNA-seq gene expression data can be
used to distinguish between different subtypes of skin cancer.

The dataset contains **150 RNA-seq samples from cancerous epithelial
tissue**. The expression data have been normalised and pre-filtered,
and the first column identifies the skin cancer subtype.

Three classes are considered:

- `tipus1`
- `tipus2`
- `tipus3`

The objective is to develop classification models capable of
predicting the cancer subtype from the selected gene expression
features.

---

## Objective

The main objective is:

> **Predict the skin cancer subtype of a patient from RNA-seq gene
> expression data using supervised machine learning.**

The project focuses on comparing different classification algorithms
and evaluating their performance on the same dataset.

---

## Dataset

The input data are provided in:

```text
rna1.csv
```

The dataset contains:

- RNA-seq samples from cancerous epithelial tissue.
- Normalised gene expression measurements.
- Pre-selected gene features.
- A categorical target variable representing the cancer subtype.

The first column contains the class label, while the remaining
columns contain gene expression values.

---

## Exploratory data analysis

The analysis begins by characterising the RNA-seq dataset.

The exploratory stage includes:

- Dataset dimensions.
- Missing-value analysis.
- Class distribution.
- Summary statistics.
- Gene expression distributions.
- Comparison of gene expression between cancer subtypes.

The analysis shows that some genes have substantially different
expression distributions between the three cancer groups, whereas
others show more similar distributions across classes.

---

## Principal Component Analysis

Principal Component Analysis (PCA) is used to explore the structure
of the gene expression data and investigate whether the cancer
subtypes show separation in a reduced-dimensional space.

The first two principal components are visualised and coloured
according to cancer subtype.

The resulting representation shows a clear separation between the
groups, particularly along the first principal component.

The analysis also suggests that subtype 2 overlaps more strongly
with the other groups than subtypes 1 and 3.

---

## Data preparation

The target variable is converted to a categorical factor before
training the classification models.

The dataset is divided into:

```r
Training set: approximately 2/3
Test set: approximately 1/3
```

A fixed random seed is used to make the partition reproducible.

The class proportions are checked in both datasets to ensure a
similar distribution of the three cancer subtypes.

---

## Machine learning models

Several supervised classification algorithms are developed and
evaluated.

### 1. k-Nearest Neighbours

The k-NN classifier is applied after normalising the gene expression
variables using min-max normalisation.

Several values of k are evaluated:

```r
k = 1
k = 3
k = 5
k = 7
k = 11
```

Model performance is evaluated using:

- Accuracy
- Kappa
- Sensitivity
- Specificity
- Confusion matrix

Among the tested configurations, **k = 1** provides the best overall
performance in this analysis.

---

### 2. Naive Bayes

A Naive Bayes classifier is trained using the RNA-seq expression
features.

Two configurations are compared:

```r
Laplace = 0
Laplace = 1
```

Both configurations produce the same overall results in this
analysis.

---

### 3. Neural Network

A neural network classifier is also evaluated.

Two architectures are compared:

```r
1 hidden layer — 30 nodes

2 hidden layers — 50 and 30 nodes
```

The neural network with two hidden layers provides slightly better
performance than the simpler architecture.

The neural network implementation is provided separately because
the original analysis used Python due to limitations with Keras and
TensorFlow in the R environment.

---

### 4. Support Vector Machine

Two SVM models are evaluated using different kernels:

#### Linear kernel
```r
vanilladot
```

#### Gaussian / RBF kernel

```r
rbfdot
```

The **linear kernel** provides the better performance for these
data.

---

### 5. Classification trees

Classification trees are implemented using the C5.0 algorithm.

Two configurations are compared:

```r
Standard C5.0
C5.0 boosting with 10 trials
```

The **boosted model** provides the better performance of the two tree
approaches.

---

### 6. Random Forest 

Random Forest models are trained using different numbers of trees:

```r
100 trees
200 trees
```

The model with **200** trees is selected as the best Random Forest
configuration in the analysis.

---

## Model evaluation 

The classifiers are compared using several performance metrics:

- Accuracy
- Kappa
- Sensitivity
- Specificity
- Confusion matrices

Performance is evaluated separately for each of the three cancer
subtypes.

This is particularly important because the three classes do not
behave identically during classification.

---

## Model comparison 

The best configuration from each algorithm is compared:

| Classifier | Selected configuration | 
| --- | --- | 
| k-NN | k = 1 | 
| Naive Bayes | Laplace = 1 | 
| Neural Network | 2 hidden layers: 50 + 30 nodes |
| SVM | Linear kernel |
|Classification Tree | Boosting = 10 |
| Random Forest | 200 trees| 

The comparison focuses not only on overall accuracy but also on
class-specific sensitivity and specificity.

--- 

## Results 

Overall, the evaluated classifiers achieve high performance, with
most models obtaining accuracies above 90%.

The main differences between classifiers are observed in the
classification of subtype 2.

Subtypes 1 and 3 show clearer separation in the PCA analysis and are
generally classified more accurately.

In contrast, subtype 2 overlaps with the other groups, resulting in
more misclassifications between subtype 2 and subtypes 1 or 3.

This behaviour is also reflected in the sensitivity values and
confusion matrices.

---

## Best performing classifier

Among the evaluated approaches, **k-NN with k = 1** provides the
best overall performance for this dataset.

The analysis therefore selects k-NN with k = 1 as the preferred
classifier because it combines:

- High predictive accuracy.
- Strong classification metrics.
- Lower model complexity compared with some of the alternative
approaches.

The conclusion applies specifically to the dataset and experimental
setup analysed in this project. 

---

## Workflow

```text
RNA-seq gene expression data
            │
            ▼
   Exploratory analysis
            │
            ├── Missing values
            ├── Class distribution
            └── Gene expression profiles
            │
            ▼
           PCA
            │
            ▼
      Data preparation
            │
            ├── Factor conversion
            └── Train / test split
            │
            ▼
   Machine learning models
            │
     ┌──────┼────────┬──────────┐
     ▼      ▼        ▼          ▼
    k-NN  Naive Bayes  Neural   SVM
                      Network
     │      │        │          │
     └──────┴────────┴──────────┘
            │
            ├── Classification trees
            └── Random Forest
            │
            ▼
       Model evaluation
            │
            ├── Accuracy
            ├── Kappa
            ├── Sensitivity
            ├── Specificity
            └── Confusion matrices
            │
            ▼
       Model comparison
            │
            ▼
      Best classifier
        k-NN (k=1)

```

---

## Technologies

### Programming language

- **R**

### Machine learning

- k-Nearest Neighbours
- Naive Bayes
- Neural Networks
- Support Vector Machines
- C5.0 Classification Trees
- Random Forest

### Statistical and machine learning packages

- `caret`
- `e1071`
- `kernlab`
- `C50`
- `randomForest`

### Data analysis and visualisation
- R Markdown
- Principal Component Analysis
- Boxplots
- Confusion matrices
- Performance metrics

---

## Repository structure

```text
SkinSubtyping-RNAseq/
│
├── README.md
│
├── data/
│   └── rna1.csv
│
├── R/
│   ├── exploratory_analysis.R
│   ├── preprocessing.R
│   ├── knn.R
│   ├── naive_bayes.R
│   ├── neural_network.R
│   ├── svm.R
│   ├── classification_tree.R
│   └── random_forest.R
│
├── figures/
│   ├── exploratory/
│   ├── pca/
│   └── models/
│
├── results/
│   └── model_comparison.csv
│
└── notebooks/
    └── SkinSubtyping-classifiers.Rmd
```

---

## Reproducibility

The main analysis was developed using R Markdown.

The workflow follows these steps:

1. Load the RNA-seq dataset.
2. Explore the data.
3. Visualise gene expression distributions.
4. Perform PCA.
5. Prepare training and test datasets.
6. Train the classification models.
7. Evaluate each model.
8. Compare the best configurations.
9. Select the best-performing classifier.

A fixed random seed is used for the train/test partition.

---

## Skills demonstrated

### Bioinformatics

- RNA-seq data analysis
- Gene expression analysis
- Cancer subtype classification
- High-dimensional biological data

### Machine Learning

- Supervised classification
- Model comparison
- Hyperparameter evaluation
- Training/test data partitioning
- Classification performance assessment

### Data Science

- Exploratory data analysis
- Dimensionality reduction
- Data normalisation
- Statistical visualisation
- Confusion matrix analysis
- Model evaluation

### Programming
- **R**
- **R Markdown**
- `caret`
- `class`
- `e1071`
- `kernlab`
- `C50`
- `randomForest`

---

## Academic context

This project was developed as part of a Master's programme in
Bioinformatics.

The analysis focuses on the application of machine learning methods
to RNA-seq gene expression data for the classification of skin
cancer subtypes.

---

## Author

### Sara Álvarez

Master's Degree in Bioinformatics and Bioestatistics | Bachelors Degree in Genetics 

- GitHub: https://github.com/saraalv
- LinkedIn: www.linkedin.com/in/saraalvarezestevez

---

## License

This project is intended for educational and portfolio purposes.
