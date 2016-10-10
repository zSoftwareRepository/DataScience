
library(R.matlab)

path <- "input/"

files <- list.files(path=path,pattern = "*.mat")

data <- list()

for(file in files){
  data[[file]] <- readMat(paste0(path,file),sparseMatrixClass=c("Matrix"),fixNames=FALSE)
}
