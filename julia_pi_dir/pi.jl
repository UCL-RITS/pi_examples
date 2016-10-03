#!/usr/bin/env julia

numsteps=10000000

if length(ARGS) > 0
  numsteps = parse(ARGS[1])
end

# Get number of processes.
# Note: In 0.4.5 on Ubuntu, the --help entry for
# -p is wrong.  
# -p <n> adds <n> additional procs for n >=1
# By default runs 1 core, not all available
np = nprocs()

println("Calculating PI using:")
println("  ", numsteps, " slices")
println("  ", np, " processe(s)")
start = time()

sum = 0.0
slice = 1.0/numsteps

sum = @parallel (+) for i = 1:numsteps
  x = (i - 0.5) * slice
  (4.0/(1.0 + x^2))
end

mypi = sum * slice

stop = time()

elapsed = (stop - start)

println("Obtained value of PI: ", mypi)
println("Time taken: ", elapsed, " seconds")
