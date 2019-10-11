# Parallel version of the Python Pi example written to use numba.
# You can control thread count by setting NUMBA_NUM_THREADS.
# Parallel is not supported on Windows or 32 bit platforms.

# Dr Owain Kenway

import time
import sys
import numba

# Can't use sum as it makes numba puke.
@numba.jit(parallel=True, nopython=True)
def calcpi(n):
	step = 1.0/n
	t = 0.0
	for i in numba.prange(n):
		x = (i + 0.5) * step
		t += 4.0/(1.0 + (x * x))
	return t * step	
	

num_steps = 10000000

if len(sys.argv) > 1:
	num_steps = int(sys.argv[1])

print(f"Calculating PI with: \n  {num_steps} slices\n  {numba.config.NUMBA_NUM_THREADS} threads")

start = time.time()

p = calcpi(num_steps)

stop = time.time()

print(f"Obtained value of PI: {p}")
print(f"Time taken: {stop - start} seconds")
