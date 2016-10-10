
library(xgboost)
library(R.matlab)

filepath <- "input/train_1/"

files <- list.files(path=filepath,pattern = "*.mat")
files.m <- matrix(as.numeric(unlist(regmatches(files, gregexpr("[[:digit:]]+", files)))),ncol=3,byrow=T)

files.m <- data.frame(files,files.m[,2:3])
files.m <- files.m[order(files.m[,2],files.m[,3]),]
files.m$X1 <- 1:nrow(files.m)
row.names(files.m) <- NULL
rm(files)

train.sample <- sample(1:nrow(files.m),nrow(files.m)*0.05)

train <- files.m[train.sample,]
test  <- files.m[-train.sample,]

df1 <- NULL

for(file in 1:nrow(train)){
  
  data <- readMat(paste0(filepath,train[file,1]),sparseMatrixClass=c("Matrix"),fixNames=FALSE)$dataStruct[[1]]
  
  df1 <- rbind(df1,data[apply(data, 1, function(x) !all(x==0)),])
  
}

rm(data)
