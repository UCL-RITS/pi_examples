@static if VERSION >= v"1"
    using Distributed
end

function work(numsteps, np)
  sum = 0.0
  slice = 1.0/numsteps

  sum = @distributed (+) for i = 1:numsteps
    x = (i - 0.5) * slice
    (4.0/(1.0 + x^2))
  end

  mypi = sum * slice

  return mypi
end 

function picalc(numsteps)

  # Get number of processes.
  np = nworkers()

  println("Calculating PI using:")
  println("  ", numsteps, " slices")
  println("  ", np, " worker(s)")
  temp = work(numsteps,np)
  start = time()

  mypi = work(numsteps,np)

  stop = time()

  elapsed = (stop - start)

  println("Obtained value of PI: ", mypi)
  println("Time taken: ", round(elapsed, digits=3), " seconds")

end

numsteps=1000000000

if length(ARGS) > 0
  numsteps = parse(Int, ARGS[1])
end

# Warm things up
print("  Warming up...")
warms = time()
temp = work(1,1)
warmt = time() - warms
println("done. [", round(warmt, digits=3), "s]\n")

picalc(numsteps)

