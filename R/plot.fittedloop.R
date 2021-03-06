plot.fittedloop <- function (a,split.line=TRUE,xlim=NULL,ylim=NULL,putNumber=FALSE,values=NULL,main=NULL,...) {
  ti <- (1:101)*pi/50
  Input <- a$values["b.x"]*cos(ti)+a$values["cx"]
  if (a$extended.classical==FALSE) Output <- a$values["b.y"]*cos(ti)^a$values["n"]+a$values["retention"]*sin(ti)^a$values["m"]+a$values["cy"]
  else Output <- sign(cos(ti))*a$values["b.y"]*abs(cos(ti))^a$values["n"]+a$values["retention"]*sin(ti)^a$values["m"]+a$values["cy"]
  if (is.null(xlim)) xlim <-c(min(c(a$x,Input)),max(c(a$x,Input)))
  if (is.null(ylim)) ylim <- c(min(c(a$y,Output)),max(c(a$y,Output)))                           
 if (is.null(values)) plot(Output~Input,type="l",ylim=ylim,xlim=xlim,main=main,...)
  else {
    if (values=="inherent") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x"],digits=3)," b.y=",format(a$values["b.y"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("cx=",format(a$values["cx"],digits=3)," cy=",format(a$values["cy"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Retention=",format(a$values["retention"],digits=3)),side=3,line=0.0,cex=0.75)
    }
    
    if (values=="hysteresis") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x"],digits=3)," b.y=",format(a$values["b.y"],digits=3)," cx=",format(a$values["cx"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("cy=",format(a$values["cy"],digits=3)," Area=",format(a$values["area"],digits=3)," Lag=",format(a$values["lag"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Retention=",format(a$values["retention"],digits=3)," Coercion=",format(a$values["coercion"],digits=3)),side=3,line=0.0,cex=0.75)
    }
    
    if (values=="hysteresis.all") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x"],digits=3)," b.y=",format(a$values["b.y"],digits=3)," cx=",format(a$values["cx"],digits=3)," cy=",format(a$values["cy"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("Area=",format(a$values["area"],digits=3)," Lag=",format(a$values["lag"],digits=3)," Retention=",format(a$values["retention"],digits=3)," Split Angle=",format(a$values["split.angle"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Coercion=",format(a$values["coercion"],digits=3)," Hysteresis x=",format(a$values["hysteresis.x"],digits=3)," Hysteresis y=",format(a$values["hysteresis.y"],digits=3)),side=3,line=0.0,cex=0.75)
    }
  
  if (values=="derived") {
    plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
    title(line=3, paste(main),cex=1.2)
    mtext(paste(
      "Coercion=",format(a$values["coercion"],digits=3)," Area=",format(a$values["area"],digits=3)),side=3,line=1.85,cex=0.75)
    mtext(paste("Lag=",format(a$values["lag"],digits=3)," Split Angle=",format(a$values["split.angle"],digits=3)),side=3,line=0.95,cex=0.75)
    mtext(paste("Hysteresis x=",format(a$values["hysteresis.x"],digits=3)," Hysteresis y=",format(a$values["hysteresis.y"],digits=3)),side=3,line=0.0,cex=0.75)
  }
  }
  points(a$y~a$x,pch=1,cex=0.85)
  if (split.line==TRUE) {
  if (a$extended.classical==FALSE) split.line <- a$values["b.y"]*cos(ti)^a$values["n"]+a$values["cy"]
  else split.line <- sign(cos(ti))*a$values["b.y"]*abs(cos(ti))^a$values["n"]+a$values["cy"]
  lines(Input,split.line,lty=2)}
  if(putNumber==TRUE) text(a$x,a$y,as.character(format(1:length(a$y),digits=4)))
}