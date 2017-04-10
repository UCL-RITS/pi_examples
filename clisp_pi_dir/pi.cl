#!/usr/bin/env clisp
; PI Common LISP example.

(defvar n 5000000)

; Set double precision.
(setf *read-default-float-format* 'double-float)

; This likely only works in GNU Common LISP.
(if (> (list-length *args*) 0)
  (setq n (parse-integer (car *args*)))
)

(format t "Calculating PI using~%")
(format t "  ~a slices~%" n)
(format t "  1 process~%")

; get-internal-real-time gets time from some arbitrary, implementation 
; dependent starting point in some fraction of a second.
(defvar start (get-internal-real-time))

(defvar sum 0.0)
(defvar st (/ 1.0 n))
(defvar x 0.0)

(loop for i from 1 to n do
; In Common LISP we have to enclose multi-line dos in a block. 
  (block inner  
    (setq x (* (- i 0.5) st))
    (setq sum (+ sum (/ 4.0 (+ 1.0 (* x x)))))
  )
)

(defvar p (* sum st))

(defvar stop (get-internal-real-time))

; get-internal-real-time is in some platform specific unit which we can find in
; internal-time-units-per-second
(defvar runt (/ (- stop start) internal-time-units-per-second))

(format t "Obtained value of PI: ~a~%" p)

; We have to print the time with ~f to force a float output.
(format t "Time taken: ~f seconds~%" runt)
