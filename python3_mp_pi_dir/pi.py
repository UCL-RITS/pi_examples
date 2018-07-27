# Version of the Python Pi example using multiprocessing.

# Dr Owain Kenway

import time
import sys
from multiprocessing import Process, Queue, cpu_count

# We define a function to calculate the area in a chunk so that we can assign
# it to each process.
# n - the _TOTAL_ number of slices.
# lower - the lowest number of the slice.
# upper - the upper limit so that index < upper
# q - a queue to communicate back on.
def pi_chunk(n, lower, upper, q):
	step = 1.0 / n
	p = step * sum(4.0/(1.0 + ((i + 0.5) * (i + 0.5) * step * step)) for i in range(lower, upper))
	q.put(p)

# Our usual main. The docs imply this is _not_ optional for multiprocessing but
# I've not tested this...
if __name__=='__main__':

	num_steps = 10000000 # number of slices

# Default to the number of processors exposed by cpu_count().  
# Note, on systems with SMT/Hyperthreading turned on, this is a number of 
# hardware threads, not real cores.
	procs = cpu_count()

	q = Queue()           # Queue to communicate on
	processes = []        # List where we will store our processes
	decomp_debug = False  # Show debugging?

# First argument is number of slices as normal. Second argument is number of
# processes to launch.  ANY third argument enables debug mode to check
# decomposition.
	if len(sys.argv) > 1:
		num_steps = int(sys.argv[1])
	if len(sys.argv) > 2:
		procs = int(sys.argv[2])
	if len(sys.argv) > 3:
		decomp_debug = True

# Usual output.
	print("Calculating PI using:\n  " + str(num_steps) + " slices")
	print("  " + str(procs) + " processes")              

# Get initial time.
	start = time.time()

# Loop over the number of processes, calculating lower and upper bounds for 
# indices.  Create a process object for each range and add it to the list then
# start it.
	for a in range(procs):
		l = int(a * (num_steps/procs))
		u = int((a + 1) * (num_steps/procs))
		if (a == (procs - 1)):
			u = num_steps # Correct for slight integer div issues.
		if (decomp_debug):
			 print(str(a) + " lower: " + str(l) + " upper: " + str(u))
		processes.append(Process(target=pi_chunk, args=(num_steps, l, u,q)))
		processes[a].start()	


# Create a list of results and then get procs number of results from the queue.
# Because of the algorithm, we don't care which order we get the results in.
	ps = []
	for a in range(procs):
		ps.append(q.get())
		
	if (decomp_debug):
		print(ps)

# Join all the processes.
	for a in range(procs):
		processes[a].join()

# Calculate overall result, stop clock.
	p = sum(ps)
	stop = time.time()

# Print our results.
	print("Obtained value of PI: " + str(p))
	print("Time taken: " + str(stop - start) + " seconds")
