; PI Common LISP example.

; Abstract getting command line arguments.
; In sbcl the interpreter is an extra argument.

; For SBCL: sbcl --script pi.cl <n>

(defun getargs ()
  (or
   #+SBCL (cdr *posix-argv*)
   nil))

(defun getenvvar (name) 
  (or
   #+SBCL (sb-unix::posix-getenv name)
   nil))

(defun calcpi (n fst fnl)
  (/ (loop for i from fst to fnl
	sum (/ 4.d0 (+ 1.d0 (expt (* (- i 0.5d0) (/ 1.d0 n)) 2 ))))
	 n)
)

(defvar n 50000000)
(defvar threads 1)

(if (> (list-length(getargs)) 0)
  (setq n (parse-integer (car (getargs))))
)

; Choose thread count based on OMP_NUM_THREADS.
(if (> (length(getenvvar "OMP_NUM_THREADS")) 0)
  (setq threads (parse-integer (getenvvar "OMP_NUM_THREADS")))
  (format t "DEBUG: OMP_NUM_THREADS not set - defaulting to 1~%")
)

(format t "Calculating PI using:~%")
(format t "  ~a slices~%" n)
(format t "  ~a thread(s)~%" threads)

; get-internal-real-time gets time from some arbitrary, implementation 
; dependent starting point in some fraction of a second.
(defvar start (get-internal-real-time))

; This is SBCL specific.
(defvar fst 0)
(defvar fnl n)
(defvar chunk (floor (/ n threads)))
(defvar left (- n (* chunk threads)))
(defvar p 0)
(defvar tl nil)
(loop for j from 0 to (- threads 1) do
   (setq fst (* j chunk))
   (setq fnl (- (* (+ j 1) chunk) 1))
   (if (= j (- threads 1)) 
      (setq fnl (+ fnl left))
   )
   (format t "DEBUG: Thread ~a from ~a to ~a~%" j fst fnl)
   (setq tl (cons (sb-thread:make-thread (lambda () (calcpi n fst fnl))) tl))
)

(loop for item in tl
   do (setq p (+ p (sb-thread:join-thread item)))
)
; get-internal-real-time is in some platform specific unit which we can find in
; internal-time-units-per-second
(defvar stop (get-internal-real-time))

(defvar runt (/ (- stop start) internal-time-units-per-second))

(format t "Obtained value of PI: ~a~%" p)

; We have to print the time with ~f to force a float output.
(format t "Time taken: ~f seconds~%" runt)
