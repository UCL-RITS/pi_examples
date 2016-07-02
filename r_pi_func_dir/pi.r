#!/usr/bin/env Rscript

# This implementation uses a custom function on a vector rather than a 
# loop which is kinda neat, but can be memory consuming.

numslices <- 100000000

args <- commandArgs(trailingOnly=TRUE)

if (length(args)>0) {
  numslices <- strtoi(args)
}

cat("Calculating PI using", numslices, "slices\n")
cat("  1 process\n")

start <- Sys.time()

slice <- 1.0/numslices

# Define our function
y <- function(x) {
  1/(1+(x^2))
}

# Generate array of points
slices <- slice * 1:numslices

# Sum our function applied to the slices.
mypi <- (4 * sum(y(slices)))/numslices

stop <- Sys.time()
elapsed <- stop - start

cat("Obtained value of PI:", mypi, "\n")
cat("Time taken:", elapsed, "seconds\n")

