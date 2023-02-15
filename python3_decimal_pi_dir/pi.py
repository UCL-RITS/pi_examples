# Version of the Python Pi example compatible 3 optimised.

# Dr Owain Kenway

import time
import sys
from decimal import Decimal as _DEC

num_steps = 10000000

if len(sys.argv) > 1:
	num_steps = int(sys.argv[1])

print(f"Calculating PI with:\n  {num_steps} slices")

total_sum = _DEC(0)
step = _DEC(1.0) / num_steps

start = time.time()

p = step * sum(4/(1 + ((i + _DEC(0.5)) * (i + _DEC(0.5)) * step * step)) for i in range(num_steps))

# uncomment to prove we have a decimal
#print(type(p))

stop = time.time()

print(f"Obtained value of PI: {p}")
print(f"Time taken: {stop - start} seconds")
