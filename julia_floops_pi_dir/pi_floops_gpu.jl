#!/usr/bin/env julia

using FoldsCUDA, CUDA, FLoops

function _picalc(numsteps)
    slice = 1.0 / numsteps

    @floop CUDAEx() for i = 1:numsteps
        x = (i - 0.5) * slice
        @reduce(sum += 4.0 / (1.0 + x ^ 2))
    end

    return sum * slice
end

function picalc(numsteps)

    println("Calculating PI using:")
    println("  ", numsteps, " slices")
    println("  1 gpu")

    start = time()
    mypi = _picalc(numsteps)
    elapsed = time() - start

    println("Obtained value of PI: ", mypi)
    println("Time taken: ", elapsed, " seconds")

end

numsteps = if length(ARGS) > 0
    parse(Int, ARGS[1])
else
    1_000_000_000
end

# Warm up kernel
_picalc(10)

# Run the full example
picalc(numsteps)
