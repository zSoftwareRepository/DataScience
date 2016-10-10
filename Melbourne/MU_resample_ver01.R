
library(caret)
library(R.matlab)
library(signal)

filepath <- "input/train_1/"

files <- list.files(path=filepath,pattern = "*.mat")
files.m <- matrix(as.numeric(unlist(regmatches(files, gregexpr("[[:digit:]]+", files)))),ncol=3,byrow=T)
files.m$files <- as.character(files.m$files)

files.m <- data.frame(files,files.m[,2:3])
files.m <- files.m[order(files.m[,2],files.m[,3]),]
files.m$X1 <- 1:nrow(files.m)
row.names(files.m) <- NULL
rm(files)

k.fold <- 10

set.seed(8787)
folds <- createFolds(files.m$X2,k.fold)
ul.folds <- unlist(folds)

train      <- ul.folds[!ul.folds %in% folds[[1]]] #Set the training set
validation <- folds[[1]]                          #Set the validation set

rm(folds,ul.folds)

file <- 2

for(file in 1:nrow(files.m[train,])){
  
  data <- data.frame(readMat(paste0(filepath,files.m[file,1]),sparseMatrixClass=c("Matrix"),fixNames=FALSE)$dataStruct[[1]])
  
  ldata <- list()
  for(c in 1:16){
    ldata[[c]] <- resample(data[[c]],1,8)
    cat(length(ldata[[c]]),"\n")
  }
  
  data <- data.frame(ldata)
  
  data <- data[apply(data, 1, function(x) !all(x==0)),]
  
  data <- data.frame(fileno=files.m[file,2],data,class=rep(files.m[file,3],nrow(data)))

  filename <-  gsub(pattern='(.*)[.](.*)','\\1',files.m[file,1])

  write.csv(data,paste0(filepath,filename,".csv"))
  
}

rm(data)
