# Version of the Python Pi example parallelised with dask

# Adrian Jackson

import time
import sys
from dask.distributed import Client

# We define a function to calculate the area in a chunk so that we can assign
# it to each worker
# n - the _TOTAL_ number of slices.
# lower - the lowest number of the slice.
# upper - the upper limit so that index < upper
def pi_chunk(n, lower, upper):
        step = 1.0 / n
        p = step * sum(4.0/(1.0 + ((i + 0.5) * (i + 0.5) * step * step)) for i in range(lower, upper))
        return p

if __name__=='__main__':

        num_steps = 10000000 # number of slices

# Default to 1 worker
        workers = 1

# First argument is number of slices as normal. Second argument is number of
# workers to use. 
        if len(sys.argv) > 1:
                num_steps = int(sys.argv[1])
        if len(sys.argv) > 2:
                workers = int(sys.argv[2])

# Usual output.
        print("Calculating PI using:\n  " + str(num_steps) + " slices")
        print("  " + str(workers) + " workers")

        start = time.time()

        client = Client(processes=False, n_workers=workers)  # start local workers as threads

        stop = time.time()

        print(f"Dask setup time: {stop - start} seconds")

# Get initial time.
        start = time.time()

        num_steps_range = [num_steps] * workers
        lower_range =  [int(a * (num_steps/workers)) for a in range(workers)]
        upper_range =  [int((a + 1) * (num_steps/workers)) for a in range(workers)]
        upper_range[workers-1] =  num_steps

        futures = client.map(pi_chunk, num_steps_range, lower_range, upper_range)

        results = client.gather(futures) 
        pi = sum(results)
        stop = time.time()

        print(f"Obtained value of PI: {pi}")
        print(f"Time taken: {stop - start} seconds")


