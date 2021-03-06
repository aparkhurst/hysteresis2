\name{EllipseData}
\alias{EllipseData}
\docType{data}
\title{
Simulated Ellipse Data for 6 Ellipses with period=24.
}
\description{
6 ellipses created by mel. All 6 ellipses are centered around the origin with a phase angle of pi/2 and differ by subject in terms of their retention and saturation point. Errors in both the input and the output are given a standard deviation of 0.1 for all ellipses. Used in the help page for \code{\link{fel.repeated}}.
}
\usage{data(EllipseData)}
\format{
  A data frame with 144 observations on the following 4 variables.
  \describe{
    \item{\code{X}}{a numeric vector}
    \item{\code{Y}}{a numeric vector}
     \item{\code{subjects}}{subject, one of "A", "B", or "C".}
    \item{\code{repeated}}{which ellipse for subject. Either 1 or 2.}
  }
}
\examples{
##Created using
set.seed(1)
ellip1 <- mel(method = 2, retention = 0.4, b.x = 0.6, b.y = 0.8, cx = 0, cy = 0, 
    sd.x = 0.1, sd.y = 0.1, period = 24, n.points = 48, phase.angle = pi/2)
ellip2 <- mel(method = 2, retention = 0.8, b.x = 0.6, b.y = 0.8, cx = 0, cy = 0, 
    sd.x = 0.1, sd.y = 0.1, period = 24, n.points = 48, phase.angle = pi/2)
ellip3 <- mel(method = 2, retention = 0.4, b.x = 1, b.y = 0.8, cx = 0, cy = 0, 
    sd.x = 0.1, sd.y = 0.1, period = 24, n.points = 48, phase.angle = pi/2)
X <- c(ellip1$x, ellip2$x, ellip3$x)
Y <- c(ellip1$y, ellip2$y, ellip3$y)
subjects <- c(rep("A", length(ellip1$x)), rep("B", length(ellip2$x)), rep("C", 
    length(ellip3$x)))  
    repeated <- rep(c(1,2),each=24,times=3)  
    
##Use.
data(EllipseData) 
models <- fel.repeated(EllipseData$X, EllipseData$Y, method = "harmonic2", subjects = EllipseData$subjects,subjects.in=c("A","C"),repeated=EllipseData$repeated)
models
summodels <- summary(models)
summodels
summodels$models["A",1]
par(mfrow=c(2,3))
plot(models)
}
\keyword{datasets}
