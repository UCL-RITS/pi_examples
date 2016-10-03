#!/usr/bin/env julia

numsteps=10000000

if length(ARGS) > 0
  numsteps = parse(ARGS[1])
end

println("Calculating PI using:")
println("  ", numsteps, " slices")

start = time()

sum = 0.0
slice = 1.0/numsteps

for i = 1:numsteps
  x = (i - 0.5) * slice
  sum = sum + (4.0/(1.0 + x^2))
end

mypi = sum * slice

stop = time()

elapsed = (stop - start)

println("Obtained value of PI: ", mypi)
println("Time taken: ", elapsed, " seconds")
