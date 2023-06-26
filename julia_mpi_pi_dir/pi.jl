using MPI

function picalc(numsteps, np, rank, comm)

  if rank == 0
    println("Calculating PI using:")
    println("  ", numsteps, " slices")
    println("  ", np, " worker(s)")
    start = time()

    counts = [floor(Int64, numsteps/np) for _ in 1:np]
    loss = numsteps - sum(counts)
    for a in 1:loss
      counts[a] += 1
    end

    limits = cumsum(counts)
    prepend!(limits,[0])

  else
    limits = Array{Int64}(undef, np+1)
  end 

  limits = MPI.bcast(limits, 0, comm)

  lower = limits[rank + 1]
  upper = limits[rank + 2] - 1

  s = 0.0
  slice = 1.0/numsteps

  for i = lower:upper
    x = (i - 0.5) * slice
    s += (4.0/(1.0 + x^2))
  end
  s = MPI.Reduce(s, +, 0,comm)

  if rank == 0
    mypi = s * slice
    stop = time()
    elapsed = (stop - start)
    println("Obtained value of PI: ", mypi)
    println("Time taken: ", round(elapsed, digits=3), " seconds")
  end
end

MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)

numsteps=1000000000

if length(ARGS) > 0
  numsteps = parse(Int, ARGS[1])
end

picalc(numsteps, size, rank, comm)

