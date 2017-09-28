; Implementation in Hy!
(import time)
(import sys)

(setv numslices 10000000)

(if (> (len sys.argv) 1)
  (setv numslices (int (get sys.argv 1)))
)

(print "Calculating PI with:\n " numslices "slices\n " 1 "process")

(setv totalsum 0)
(setv chunk (/ 1 numslices))

(setv start (time.time))

; Hy loops start from 0
(for [i (range numslices)]
  (setv x (* (+ i 0.5) chunk))
  (setv totalsum (+ totalsum (/ 4.0 (+ 1.0 (* x x)))))
)

(setv pi (* totalsum chunk))

(setv stop (time.time))

(print "Obtained value of PI:" pi "\nTime taken:" (- stop start) "seconds")
