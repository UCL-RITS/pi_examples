#!/usr/bin/env julia

p(n) = (reduce(+,map((x->(4/(1+(x*x)))),(0.5/n):(1/n):1))/n)

function picalc(numsteps)

  # Get number of processes.
  # np = nworkers()
  np = 1

  println("Calculating PI using:")
  println("  ", numsteps, " slices")
  println("  ", np, " worker(s)")
  start = time()

  mypi = p(numsteps)

  stop = time()

  elapsed = (stop - start)

  println("Obtained value of PI: ", mypi)
  println("Time taken: ", elapsed, " seconds")

end

numsteps=50000000

if length(ARGS) > 0
  numsteps = parse(ARGS[1])
end

picalc(numsteps)

