\name{floop}
\alias{floop}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Fit a Hysteresis Loop
}
\description{
Fits a hysteresis loop given values of m and n chosen by the user.
}
\usage{
floop(x, y, n = 1, m = 1, period = 24,subjects=NULL,times="equal",subset=NULL,na.action= getOption("na.action"),extended.classical=FALSE,boot=FALSE) 
}

\arguments{
  \item{x}{
numeric input vector.
}
  \item{y}{
numeric output vector.
}
  \item{n}{
a number, usually odd and always positive. Parameter of the hysteresis loop. Default is 1, which makes loop an ellipse when m is also equal to 1. See details.
}
  \item{m}{
a number, usually odd and always positive. Parameter of the hysteresis loop. Default is 1, which makes loop an ellipse when n is also equal to 1. In this case floop will automatically make a call to \code{\link{fel}}. See details.
}
  \item{period}{
length of time required to make a full loop. Reciprocal of frequency, and if times="equal" the number of points needed to make a full loop.
}
  \item{subjects}{
an optional factor or list of factors, each of the same length as x. Use to identify a list of different loops to be fit from one set of data, in which case \code{floop} returns an object of class \code{fittedlooplist} instead of \code{fittedloop}.
}
  \item{times}{
either a numeric vector of length nrow(x) or the default "equal". If the times at which loop observations are taken are known a numeric vector can be used to give those times. If the default "equal" is used instead time points are assumed to be equally spaced in a counterclockwise fashion.
}
  \item{subset}{
an optional vector specifying a subset of observations to be used in the fitting process.
}
  \item{na.action}{
a function which indicates what should happen when the data contain NAs. The default is set by the \code{na.action} setting of \code{\link{options}}, the �factory-fresh� default 
is \code{\link{na.omit}}. Value \code{link{na.exclude}} can be useful.
}
  \item{extended.classical}{
fit a classical hysteresis loop regardless of the value of n. Use \deqn{y_t=retention*sin(2*pi*t/period)^m+sign(cos(2*pi*t/period))*(b.y*abs(cos(2*pi*t/period))^n)+cy+e_{y,t}} instead of \deqn{y_t=retention*sin(2*pi*t/period)^m+b.y*cos(2*pi*t/period)^n+cy+e_{y,t}}. Allows the user to fit classical loops with any n>1 instead of just odd numbered n. Default is false.
}
  \item{boot}{
logical, if TRUE results will be bootstrapped by the default arguments of \code{\link{summary.fittedloop}}.
}
  \item{...}{
other optional arguments, such as \code{seed},N,\code{cbb}, passed to \code{\link{summary.fittedloop}} if \code{boot=TRUE}.
}
}
\details{
Fits input and output variables x and y that form a hysteresis loop of the form \deqn{x_t=b.x*cos(2pi*t/period+phase.angle)+cx+e_{x,t}} \deqn{y_t=b.y*cos(2pi*t/period+phase.angle)^n+retention*sin(2pi*t/period+phase.angle)^m+cy+e_{y,t}}  where \deqn{t=0,...,n.points-1 if times='equal'} and the error terms e are independently and normally distributed. Also produces a vector of derived values.}
\value{
floop returns an object of class \code{fittedloop}.
  \item{values}{estimated values of various fundamental and derived parameters of the hysteresis loop. See \code{\link{loop.parameters}}}
  \item{x}{the input.}
  \item{y}{the output.}
  \item{pred.x}{fitted x values.}
  \item{pred.y}{fitted y values.}
  \item{period.time}{time vector used to fit x and y.}
  \item{residuals}{residuals measured by Euclidean distance.}
  \item{extended.classical}{whether or not an extended classical loop is fit.}
  \item{fit}{the model fit.}
  \item{Std.Errors}{standard errors for parameters derived using the delta method.}
      If multiple loops are fit simultaneously there will be three arguments to the response, models which will contain the seperate model fits for each loop, Estimates which will have all of the parameter estimates in matrix form, and Std.Errors which will have all of the delta method standard errors in matrix form. See \code{\link{floop.repeated}}.
}
\references{
Lapshin, R. (1995) Analytical model for the approximation of hysteresis loop and its application to the scanning tunneling microscope.
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
Simulate a hysteresis loop with the function \code{\link{mloop}}. Alternatively see \code{\link{fel}} for fitting an ellipse (a hysteresis loop with parameters m=1, n=1) using a variety of methods. If a loop is an ellipse, use of fel is strongly recommended instead of floop. 
}
\examples{
##Simulate and fit a loop.
loop1 <- mloop(sd.x=0.05,sd.y=0.05,m=3,n=5)
model <- floop(loop1$x,loop1$y,m=3,n=5)
summary(model)
plot(model,main="Hysteresis Loop")
}
\keyword{ models }

