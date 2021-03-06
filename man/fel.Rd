\name{fel}
\alias{fel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Fitting Ellipses
}
\description{
Fit a sinusoidal hysteretic (elliptical) process between an input and an output.
}
\usage{
fel(x, y, method = "harmonic2", period = NULL, subjects = NULL,
  times="unknown",subset = NULL, control=nls.control(),na.action= getOption("na.action"),boot=FALSE,...)
}
\arguments{
  \item{x}{
input
}
  \item{y}{
output
}
  \item{method}{
the method to be used for fitting; one of either the default \code{method="harmonic2"}, \code{method="nls"}, \code{method="direct"}, or \code{method="lm"}.
}
  \item{period}{
an optional number that defines the length of the \code{period}.
}
  \item{subjects}{
an optional factor or list of factors, each of the same length as x. Use to identify several different ellipses to fit at once, in which case \code{fel} returns an object of class \code{ellipsefitlist} instead of \code{ellipsefit}. If \code{subjects} is a list of factors each combination of the factors must be present in the data or an error will be produced.
}
  \item{times}{
either a numeric vector of length \code{nrow(x)} or one of the two options "equal" or the default "unknown". If the times at which ellipse observations are taken are known a numeric vector
can be used to give those times. If not, predicted values are found by minimizing geometric distances from the fitted ellipse to the observations. If "equal" time points are assumed to be equally spaced in a counterclockwise fashion. Do not use the "harmonic2" method unless times are either known or are known to be equal. Bootstrapping results are also more accurate if correct times are used.}
  \item{subset}{
an optional vector specifying a subset of observations to be used in the fitting process.
}
  \item{control}{
optional and only used if \code{method="nls"}. See \code{\link{nls.control}}.
}
  \item{na.action}{
a function which indicates what should happen when the data contain NAs. The default is set by the \code{na.action} setting of \code{\link{options}}, the factory-fresh default 
is \code{\link{na.omit}}. Value \code{link{na.exclude}} can be useful.
}
  \item{boot}{
logical, if TRUE results will be bootstrapped by \code{\link{summary.ellipsefit}}.
}
  \item{...}{
other optional arguments such as \code{seed},N,\code{cbb}, passed to \code{\link{summary.ellipsefit}} if \code{boot=TRUE}.
}
}
\details{
Where the response y is a sinusoidal process with an element of randomness that lags the controlling input x, which is also a stochastic sinusoidal process, an ellipse can be used to fit the relationship between
x and y.

The values of derived parameters such as area, lag, retention, coercion, split angle and hysteresis.y are estimated from this ellipse.

The harmonic2 method is a two step harmonic least squares model using generalized transcendental equations presented by Lapshin (1995).  Yang and Parkhurst provide the efficient estimates 
for derived parameters and as such "harmonic2" is used as the default. Direct specific least squares (\code{method="direct"}) based on the work of Radim Halir and Jan Flusser is also available although work on delta method standard errors is still in progress. Finally \code{method="lm"} and 
ellipse specific non-linear least squares (\code{method="nls"}) are included as well.

If x and y contain more than 1 ellipse that needs to be fit the argument \code{subjects} can be used to identify period of data to fit with separate ellipses.

Bootstrapped estimates for parameter values are provided with \code{\link{summary.ellipsefit}}.  These bootstrapped estimates are generally less biased than those provided by \code{fel} in isolation.
}
\value{
\code{fel} returns an object of class \code{ellipsefit} or \code{ellipsefitlist}.
  \item{method}{the \code{method} used.}
  \item{x}{the input x used.}
  \item{y}{the output y used.}
  \item{pred.x}{the fitted values for x.}
  \item{pred.y}{the fitted values for y.}
  \item{period.time}{a vector that contains times converted to radians for observations, either estimated after the ellipse has been fitted or given beforehand by \code{times}.}
  \item{values}{a named vector of parameter estimates. See \code{\link{loop.parameters}}.}
  \item{residuals}{algebraic residuals from the model. The function \code{\link{residuals.ellipsefit}} can produce other types of residuals from an \code{ellipsefit} object.}
    \item{Std.Errors}{Standard errors produced by the delta method. See \code{\link{delta.error}}.}
    If multiple ellipses are fit simultaneously there will be three arguments to the response, models which will contain the seperate model fits for each ellipse, Estimates which will have all of the parameter estimates in matrix form, and Std.Errors which will have all of the delta method standard errors in matrix form. See \code{\link{fel.repeated}}.
}
\references{
Yang, F. and A. Parkhurst, Efficient Estimation of Elliptical Hysteresis. (submitted)
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
\code{\link{plot.ellipsefit}} for plotting and \code{\link{summary.ellipsefit}} for summarizing and bootstrapping an \code{ellipsefit} object.  
}
\examples{
### Simulate and fit an ellipse.
ellipse1 <- mel(sd.x=0.2,sd.y=0.04)
ellipse1.fit <- fel(ellipse1$x,ellipse1$y)
ellipse1.fit             #Gives estimates, delta standard errors and 95%CI

### Bootstrap estimates and standard errors (Seed is necessary if want to reproduce results)
booted.ellipse <- fel(ellipse1$x,ellipse1$y,boot=TRUE, seed=123)
booted.ellipse                 #Gives boot estimates, boot bias, boot SE and boot quartiles

### Calibration Problem
data(IQsig,package="nlrwr") #Calibration Example: Ellipse when no times available
Kaf=fel(IQsig$I,IQsig$Q, method="nls" )
Kaf
plot(Kaf,xlab="I",ylab="Q",main="Calibration",data=IQsig)

}
\keyword{ models }

