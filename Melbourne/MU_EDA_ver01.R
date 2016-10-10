

library(R.matlab)

data_1_9_0 <- readMat("input/1_9_0.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)
data_1_9_1 <- readMat("input/1_9_1.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)
df <- data.frame(data_1_9_0$dataStruct[[1]])
df <- data.frame(data_1_9_1$dataStruct[[1]])

data_3_100_0 <- readMat("input/3_100_0.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)
data_3_100_1 <- readMat("input/3_100_1.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)
matrix0 <- data_3_100_0$dataStruct[[1]]
matrix1 <- data_3_100_1$dataStruct[[1]]

data_2_100_0 <- readMat("input/2_100_0.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)
data_2_100_1 <- readMat("input/2_100_1.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)
matrix0 <- data_2_100_0$dataStruct[[1]]
matrix1 <- data_2_100_1$dataStruct[[1]]

df1 <- df[ !rowSums(df[,colnames(df)[(3:ncol(df))]]==0)==ncol(df)-2, ]

df1 <- df[apply(df[,-1], 1, function(x) !all(x==0)),]

#write.csv(matrix0,"input/matrix0.csv")
#write.csv(matrix1,"input/matrix1.csv")
