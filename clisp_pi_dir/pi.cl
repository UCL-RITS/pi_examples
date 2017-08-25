; PI Common LISP example.

; Abstract getting command line arguments.
; In sbcl the interpreter is an extra argument.

; For CLISP: clisp pi.cl <n>
; For SBCL: sbcl --script pi.cl <n>
; For GCL: gcl -f pi.cl <n>
; For ECL: ecl -shell pi.cl <n>

(defun getargs ()
  (or
   #+CLISP *args*
   #+SBCL (cdr *posix-argv*)
   #+GCL (cdr si::*command-args*)
   #+ECL (cdr(cdr(cdr si::*command-args*)))
   nil))

(defvar n 5000000)

(if (> (list-length(getargs)) 0)
  (setq n (parse-integer (car (getargs))))
)

(format t "Calculating PI using~%")
(format t "  ~a slices~%" n)
(format t "  1 process~%")

; get-internal-real-time gets time from some arbitrary, implementation 
; dependent starting point in some fraction of a second.
(defvar start (get-internal-real-time))

(defvar sum 0.d0)
(defvar st (/ 1.d0 n))
(defvar x 0.d0)

(loop for i from 1 to n do
    (setq x (* (- i 0.d5) st))
    (setq sum (+ sum (/ 4.d0 (+ 1.d0 (* x x)))))
)

(defvar p (* sum st))

; get-internal-real-time is in some platform specific unit which we can find in
; internal-time-units-per-second
(defvar stop (get-internal-real-time))

(defvar runt (/ (- stop start) internal-time-units-per-second))

(format t "Obtained value of PI: ~a~%" p)

; We have to print the time with ~f to force a float output.
(format t "Time taken: ~f seconds~%" runt)
