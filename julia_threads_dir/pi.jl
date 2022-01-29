#!/usr/bin/env julia

using Base.Threads

function _picalc(numsteps)
    slice = 1.0 / numsteps

    sums = zeros(Float64, nthreads())
    n = cld(numsteps, nthreads())

    Threads.@threads for i in 1:nthreads()
        sum_thread = 0.0
        @simd for j in (1 + (i - 1) * n):min(numsteps, i * n)
            x = (j - 0.5) * slice
            sum_thread += 4.0 / (1.0 + x ^ 2)
        end
        sums[threadid()] = sum_thread
    end

    return sum(sums) * slice
end

function picalc(numsteps)

    println("Calculating PI using:")
    println("  ", numsteps, " slices")
    println("  ", nthreads(), " thread(s)")

    start = time()
    mypi = _picalc(numsteps)
    elapsed = time() - start

    println("Obtained value of PI: ", mypi)
    println("Time taken: ", round(elapsed; digits=3), " seconds")

end

numsteps = if length(ARGS) > 0
    parse(Int, ARGS[1])
else
    1_000_000_000
end

# Warm up kernel
print("  Warming up...")
warms = time()
_picalc(10)
warmt = time() - warms
println("done. [", round(warmt; digits=3), "s]\n")

# Run the full example
picalc(numsteps)
