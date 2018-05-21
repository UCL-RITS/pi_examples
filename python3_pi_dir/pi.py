# Version of the Python Pi example compatible 3 optimised.

# Dr Owain Kenway

import time
import sys


num_steps = 10000000

if len(sys.argv) > 1:
	num_steps = int(sys.argv[1])

print("Calculating PI with: " + str(num_steps) + " slices")

total_sum = 0
step = 1.0 / num_steps

start = time.time()

for i in range(num_steps):
	x = (i + 0.5) * step
	total_sum += 4.0/(1.0 + x * x)

#p = step * sum(4.0/(1.0 + ((i + 0.5) * (i + 0.5) * step * step)) for i in range(num_steps))

p = total_sum * step

stop = time.time()

print("Obtained value of PI: " + str(p))
print("Time taken: " + str(stop - start) + " seconds")
