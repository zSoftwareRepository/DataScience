library(ggplot2)
library(R.matlab)
library(signal)

plot.frequency.spectrum <- function(X.k, xlimits=c(0,length(X.k)/2)) {
  plot.data <- cbind(0:(length(X.k)-1), Mod(X.k))
  
  plot.data[2:length(X.k),2] <- 2*plot.data[2:length(X.k),2]
  
  plot(plot.data, t="h", lwd=2, main="",
       xlab="Frequency (Hz)", ylab="Strength",
       xlim=xlimits, ylim=c(0,max(Mod(plot.data[,2]))))
}

filepath <- "../input/train_1/"

files <- list.files(path=filepath,pattern = "*.mat")
data  <- readMat(paste0(filepath,files[1]),sparseMatrixClass=c("Matrix"),fixNames=FALSE)$dataStruct[[1]]
data  <- data[apply(data, 1, function(x) !all(x==0)),]
data1 <- data[1:400,4]
rdata <- resample(data[1:400,4],1,4)

par(mfrow = c(4, 2))  # 4 rows and 2 columns

plotData1 <- data.frame(time=1:length(data1),value=data1)
plot(x=plotData1$time, y=plotData1$value, t="l", lwd=2, main="Original",
     xlab="Time", ylab="Signal",
     xlim=c(0,length(plotData1$time)), ylim=c(min(plotData1$value),max(plotData1$value)))
plot.frequency.spectrum(fft(data1)) 

###

plotData2 <- data.frame(time=1:length(rdata),value=rdata)
plot(x=plotData2$time, y=plotData2$value, t="l", lwd=2, main="Resampled",
     xlab="Time", ylab="Signal",
     xlim=c(0,length(plotData2$time)), ylim=c(min(plotData2$value),max(plotData2$value)))
plot.frequency.spectrum(fft(rdata))

###

plotData3 <- plotData1
bf1 <- butter(1, c(1/200,50/200), type = c("pass"))

plotData3$value <- filter(bf1, plotData3$value)
plot(x=plotData3$time, y=plotData3$value, t="l", lwd=2, main="Filtered-Original",
     xlab="Time", ylab="Signal",
     xlim=c(0,length(plotData3$time)), ylim=c(min(plotData3$value),max(plotData3$value)))
plot.frequency.spectrum(fft(as.numeric(plotData3[,2])))

###

plotData4 <- plotData2
bf2 <- butter(1, c(1/100,20/100), type = c("pass"))
plotData4$value <- filter(bf2, plotData4$value)
plot(x=plotData4$time, y=plotData4$value, t="l", lwd=2, main="Filtered-Resampled",
     xlab="Time", ylab="Signal",
     xlim=c(0,length(plotData4$time)), ylim=c(min(plotData4$value),max(plotData4$value)))
plot.frequency.spectrum(fft(as.numeric(plotData4[,2])))