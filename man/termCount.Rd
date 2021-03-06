% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CTM.R
\name{termCount}
\alias{termCount}
\title{Term Count}
\usage{
termCount(doc, shortTermDeleted)
}
\arguments{
\item{doc}{The Chinese text document.}

\item{shortTermDeleted}{Deltected short word when nchar <2.}
}
\description{
Computing term count from text documents
}
\details{
This function run a Chinese word segmentation by jiebeR and
compute term count from these text document.
}
\examples{
library(CTM)
a <- "hello taiwan"
b <- "world of tank"
c <- "taiwan weather"
d <- "local weather"
text <- t(data.frame(a,b,c,d))
count <- termCount(doc = text, shortTermDeleted = FALSE)
}
\author{
Jim Liu
}

