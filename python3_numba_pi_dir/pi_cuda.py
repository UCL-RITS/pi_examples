# Version of the Python Pi example written to use numba and cuda.
# Dr Owain Kenway

import time
import sys
from numba import cuda
import math
import numpy

# GPU kernel.
@cuda.jit
def calcpi_(n, nchunks, chunks, results):
    index = cuda.grid(1)
    if index < nchunks:
        step = 1.0/n
        t = 0.0
        beginning = 0 + chunks[index-1]
        finish =  chunks[index]
        for i in range(beginning, finish):
            x = (i + 0.5) * step
            t += 4.0/(1.0 + (x * x))
        results[index] = t * step

# Decompostion and setup.
def calcpi(n, nchunks):
    chunks = numpy.full(nchunks, int(n/nchunks))
    results = numpy.zeros(nchunks)
    for a in range(n - numpy.sum(chunks)):
        chunks[a] +=1
    chunks = numpy.cumsum(chunks)
    threadsperblock = 256
    blockspergrid = math.ceil(n/threadsperblock)
    d_chunks = cuda.to_device(chunks)
    d_results = cuda.to_device(results)
    calcpi_[blockspergrid, threadsperblock](n, nchunks, d_chunks, d_results)
    return numpy.sum(d_results)

num_steps = 10000000
num_chunks = 1000

if len(sys.argv) > 1:
    num_steps = int(sys.argv[1])

if len(sys.argv) > 2:
    num_chunks = int(sys.argv[2])

print(f"Calculating PI with:\n  {num_steps} slices\n  {num_chunks} chunks\n")

start = time.time()

p = calcpi(num_steps, num_chunks)

stop = time.time()

print(f"Obtained value of PI: {p}")
print(f"Time taken: {stop - start} seconds")
