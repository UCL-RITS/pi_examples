#!/usr/bin/env Rscript

numsteps <- 10000000

args <- commandArgs(trailingOnly=TRUE)

if (length(args)>0) {
  numsteps <- strtoi(args)
}

cat("Calculating PI using", numsteps, "slices \n")
cat("  1 process\n")

start <- Sys.time()

sum <- 0.0
step <- 1.0/numsteps

for (i in 1:numsteps) {
  x <- (i - 0.5) * step
  sum <- sum + 4.0/(1.0 + (x^2))
}

mypi = sum * step

stop <- Sys.time()
elapsed <- stop - start

cat("Obtained value of PI:", mypi, "\n")
cat("Time taken:", elapsed, "seconds\n")
