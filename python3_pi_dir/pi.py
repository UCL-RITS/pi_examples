# Version of the Python Pi example compatible 3 optimised.

# Dr Owain Kenway

import time
import sys


num_steps = 10000000

if len(sys.argv) > 1:
	num_steps = int(sys.argv[1])

print(f"Calculating PI with:\n  {num_steps} slices")

total_sum = 0
step = 1.0 / num_steps

start = time.time()

p = step * sum(4.0/(1.0 + ((i + 0.5) * (i + 0.5) * step * step)) for i in range(num_steps))

stop = time.time()

print(f"Obtained value of PI: {p}")
print(f"Time taken: {stop - start} seconds")
