#!/usr/bin/env julia

function picalc(numsteps)

  println("Calculating PI using:")
  println("  ", numsteps, " slices")
  println("  ", 1, " worker(s)")
  start = time()

  sum = 0.0
  slice = 1.0/numsteps

  sum = 0.0

  for i = 1:numsteps
    x = (i - 0.5) * slice
    sum = sum + (4.0/(1.0 + x^2))
  end

  mypi = sum * slice

  stop = time()

  elapsed = (stop - start)

  println("Obtained value of PI: ", mypi)
  println("Time taken: ", elapsed, " seconds")

end

numsteps=1000000000

if length(ARGS) > 0
  numsteps = parse(ARGS[1])
end

picalc(numsteps)

