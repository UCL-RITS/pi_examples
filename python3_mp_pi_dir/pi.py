# Version of the Python Pi example using multiprocessing.

# Dr Owain Kenway

import time
import sys
from multiprocessing import Process, Queue

def pi_chunk(n, lower, upper, q):
	step = 1.0 / n
	p = step * sum(4.0/(1.0 + ((i + 0.5) * (i + 0.5) * step * step)) for i in range(lower, upper))
	q.put(p)


if __name__=='__main__':

	num_steps = 10000000
	procs = 1
	q = Queue()
	processes = []
	decomp_debug = False

	if len(sys.argv) > 1:
		num_steps = int(sys.argv[1])
	if len(sys.argv) > 2:
		procs = int(sys.argv[2])
	if len(sys.argv) > 3:
		decomp_debug = True

	print("Calculating PI using:\n  " + str(num_steps) + " slices")
	print("  " + str(procs) + " processes")              


	start = time.time()

	for a in range(procs):
		l = int(a * (num_steps/procs))
		u = int((a + 1) * (num_steps/procs))
		if (decomp_debug):
			 print(str(a) + " lower: " + str(l) + " upper: " + str(u))
		processes.append(Process(target=pi_chunk, args=(num_steps, l, u,q)))
		processes[a].start()	


	ps = []
	for a in range(procs):
		ps.append(q.get())
		
	if (decomp_debug):
		print(ps)

	for a in range(procs):
		processes[a].join()

	p = sum(ps)
	stop = time.time()

	print("Obtained value of PI: " + str(p))
	print("Time taken: " + str(stop - start) + " seconds")
