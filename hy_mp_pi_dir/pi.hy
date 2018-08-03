;; Calculate pi in hy using the Python multiprocessing module.
;; Owain Kenway

(import time)
(import sys)
(import multiprocessing)

; Define a function for calculating a chunk.  This is less efficient than the py version so it needs work.
(defn pi_chunk [n lower upper q] 
	(setv step (/ 1.0 n))
	(setv x 0.0)
	(for [i (range lower upper)] (setv x (+ x (/ 4.0 (+ 1.0 (* (+ i 0.5) (+ i 0.5) step step))))))
	(.put q (/ x n))
)

; Our main.
(defmain [&rest args]

	(setv procs (multiprocessing.cpu_count))
	(setv numslices 10000000)

; Parse args to set number of slices and cores.
	(if (> (len sys.argv) 1)
 		(setv numslices (int (get sys.argv 1)))
	)
	(if (> (len sys.argv) 2)
 		(setv procs (int (get sys.argv 2)))
	)

	(print "Calculating PI with:\n " numslices "slices\n " procs "process")

; Start timer.
	(setv start (time.time))

; Queue to communicate on, list to fill with processes.
	(setv q (multiprocessing.Queue))
	(setv processes [])

; For each process, calculate lower and upper bounds and then bind a function to a new process object 
; and then start that.
	(for [a (range procs)]
		(setv l (int (* a (/ numslices procs))))
		(setv u (int (* (+ 1 a)  (/ numslices procs))))
		(if (= a (- procs 1)) (setv u numslices)) ; Fix for integer division issues

		(.append processes (multiprocessing.Process
					:target pi_chunk
					:args [numslices l u q]))

		(.start (get processes a))
	)

; Get our results into a list.  Because of the algorithm, we don't care about order.
	(setv ps [])
	(for [a (range procs)]
		(.append ps (q.get))
	)

; Join all our processes.
	(for [a (range procs)]
		(.join (get processes a))
	)
	
; Calculate pi and stop the clock.
	(setv p (sum ps))
	(setv stop (time.time))

	(print "Obtained value of PI:" p "\nTime taken:" (- stop start) "seconds")
)
