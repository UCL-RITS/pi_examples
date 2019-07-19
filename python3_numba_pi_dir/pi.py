# Version of the Python Pi example written to use numba.

# Dr Owain Kenway

import time
import sys
import numba

# Can't use sum as it makes numba puke.
@numba.jit
def calcpi(n):
	step = 1.0/n
	t = 0.0
	for i in range(n):
		x = (i + 0.5) * step
		t += 4.0/(1.0 + (x * x))
	return t * step	
	

num_steps = 10000000

if len(sys.argv) > 1:
	num_steps = int(sys.argv[1])

print("Calculating PI with: " + str(num_steps) + " slices")

start = time.time()

p = calcpi(num_steps)

stop = time.time()

print("Obtained value of PI: " + str(p))
print("Time taken: " + str(stop - start) + " seconds")
