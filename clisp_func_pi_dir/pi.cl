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

(defun range (b n j) 
  (loop while (< b n) 
    do (setf b (+ b j)) 
    collect (- b j)
  )
)


(defun pc (c) (/ (apply #'+ (map 'list #'(lambda (x) (/ 4 (+ 1 (* x x))))((lambda (n) (range (/ 0.5 n) 1 (/ 1 n))) c))) c))

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

(defvar p (pc n))

; get-internal-real-time is in some platform specific unit which we can find in
; internal-time-units-per-second
(defvar stop (get-internal-real-time))

(defvar runt (/ (- stop start) internal-time-units-per-second))

(format t "Obtained value of PI: ~a~%" p)

; We have to print the time with ~f to force a float output.
(format t "Time taken: ~f seconds~%" runt)
