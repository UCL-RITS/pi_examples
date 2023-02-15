# Version of the Python Pi example compatible 3 optimised.

# Dr Owain Kenway

import time
import sys
from decimal import Decimal as _DEC

num_steps = 10000000

if len(sys.argv) > 1:
	num_steps = int(sys.argv[1])

print("Calculating PI with: " + str(num_steps) + " slices")

total_sum = _DEC(0)
step = _DEC(1.0) / num_steps

start = time.time()

for i in range(num_steps):
	x = (i + _DEC(0.5)) * step
	total_sum += 4/(1 + x * x)


p = total_sum * step

# Uncomment to prove we have a decimal
#print(type(p))

stop = time.time()

print("Obtained value of PI: " + str(p))
print("Time taken: " + str(stop - start) + " seconds")
