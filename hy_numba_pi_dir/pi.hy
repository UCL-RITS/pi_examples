; Implementation in Hy!
(import time)
(import sys)
(import [numba [jit]])

(with-decorator jit (defn calcpi [n]
  (setv totalsum 0)
  (setv chunk (/ 1 numslices))

  (for [i (range numslices)]
    (setv x (* (+ i 0.5) chunk))
    (setv totalsum (+ totalsum (/ 4.0 (+ 1.0 (* x x)))))
  )
  (* totalsum chunk)
))


(setv numslices 10000000)

(if (> (len sys.argv) 1)
  (setv numslices (int (get sys.argv 1)))
)

(print "Calculating PI with:\n " numslices "slices\n " 1 "process")

(setv start (time.time))

; Hy loops start from 0

(setv pi (calcpi numslices))

(setv stop (time.time))

(print "Obtained value of PI:" pi "\nTime taken:" (- stop start) "seconds")
