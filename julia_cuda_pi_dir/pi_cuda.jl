#!/usr/bin/env julia

# Make sure we have all the CUDA gubbins set up.
using Pkg
Pkg.activate(".")
Pkg.instantiate()
using CUDA

# Actual CUDA kernel.
function pichunk!(threads, n, result)
  rank=threadIdx().x
  lower=floor((rank-1) * n/threads) + 1
  upper=floor((rank) * n/threads)
  step = 1.0/n
  for i=lower:upper
    x = (i + 0.5) * step
    result[rank] += 4.0/(1.0 + x*x)
  end
  return
end

# Sort out CUDA thread setup.
function _picalc(nthr, slices)
  result = CUDA.fill(0.0, nthr)
  @cuda threads=nthr pichunk!(nthr, slices, result)
  synchronize()
  s = sum(result)/slices
  return(s)
end

# Run the benchmark.
function picalc(numsteps, nthr)

  println("Calculating PI using:")
  println("  ", numsteps, " slices")
  println("  ", nthr, " CUDA threads(s)")
  start = time()

  mypi = _picalc(nthr, numsteps)

  elapsed = time() - start

  println("Obtained value of PI: ", mypi)
  println("Time taken: ", elapsed, " seconds")

end

# Parse arguments.
numsteps = if length(ARGS) > 0
  parse(Int, ARGS[1])
else
  1_000_000_000
end

threads = if length(ARGS) > 1
  parse(Int, ARGS[2])
else
  64
end

# Warm things up
print("  Warming up...")
warms = time()
dummy = _picalc(1,10)
warmt = time() - warms
println("done. [", warmt, "s]\n")

# Run the full example
picalc(numsteps,threads)
