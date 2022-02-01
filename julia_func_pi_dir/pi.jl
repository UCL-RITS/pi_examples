#!/usr/bin/env julia

p(n) = mapreduce(x -> (4 / (1 + (x * x))), +, (0.5 / n):(1 / n):1) / n

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
  println("Time taken: ", round(elapsed; digits=3), " seconds")

end

const numsteps = if length(ARGS) > 0
    parse(Int, ARGS[1])
else
    1_000_000_000
end

# Warm up kernel
print("  Warming up...")
warms = time()
p(10)
warmt = time() - warms
println("done. [", round(warmt; digits=3), "s]\n")

# Run the full example
picalc(numsteps)
