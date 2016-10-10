library(ggplot2)
library(manipulate)
library(R.matlab)
library(dplyr)
library(tidyr)
 
timerange <- 800

dataClass0 <- readMat("input/1_1_0.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)
dataClass1 <- readMat("input/1_1_1.mat",sparseMatrixClass=c("Matrix"),fixNames=FALSE)

df0 <- data.frame(dataClass0$dataStruct[[1]])
df1 <- data.frame(dataClass1$dataStruct[[1]])

viewer <- function(base){

start <- base
end <- (start - 1) + timerange 

Data.0 <- data.frame(time=1:timerange,df0[start:end,],Event=rep(0,timerange))
Data.1 <- data.frame(time=1:timerange,df1[start:end,],Event=rep(1,timerange))

Buffer <- rbind(Data.0,Data.1)

plotData <- Buffer %>% select(time, Event, X1, X2, X3, X4) %>% gather(Location, value, X1:X4)

ggplot(plotData) + aes(x=time, y=value) + 
  geom_point(aes(colour=Event), data=plotData) +
  facet_wrap(~Location)
}

manipulate(viewer(base), base = slider(1, 240000, step = timerange))


