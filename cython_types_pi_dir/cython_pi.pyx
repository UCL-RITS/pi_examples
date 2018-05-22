import time
import sys
import cython

num_steps = 1000*1000*10

if len(sys.argv) > 1:
  num_steps = int(sys.argv[1])

print("Calculating PI with:\n  %d slices\n  1 process" % num_steps)

@cython.locals(i = cython.int, x = cython.double, step=cython.double, num_steps = cython.int, total_sum=cython.double)
@cython.returns(cython.double)
def cy_version(num_steps):
    total_sum = 0
    step = 1.0 / num_steps

    for i in xrange(num_steps):
      x = (i - 0.5) * step
      total_sum += 4.0 / (1.0 + x*x)
    pi = total_sum * step
    return pi

start = time.time()
pi = cy_version(num_steps)
stop = time.time()

print("Obtained value of PI: %.32g\n"
      "Time taken: %g seconds"
      % (pi, stop - start) )




