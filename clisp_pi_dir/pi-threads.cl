; PI Common LISP example.

; Abstract getting command line arguments.
; In sbcl the interpreter is an extra argument.

; For SBCL: sbcl --script pi.cl <n>

; This implementation checks OMP_NUM_THREADS for number of threads or uses
; a single thread if not present.

; Get arguments
(defun getargs ()
  (or
   #+SBCL (cdr *posix-argv*)
   nil))

; Get environment variable/.
(defun getenvvar (name) 
  (or
   #+SBCL (sb-unix::posix-getenv name)
   nil))

; Version of calcpi that operates on part of the range
(defun calcpi (n fst fnl)
  (/ (loop for i from fst to fnl
	sum (/ 4.d0 (+ 1.d0 (expt (* (- i 0.5d0) (/ 1.d0 n)) 2 ))))
	 n)
)

; Thread paralle pi calculation
; Uses SBCL threads so non-portable
(defun parapi (n threads) 
   (let ((fst 0)  ; first iter index
         (fnl n)  ; final iter index
         (chunk)  ; size of a thread chunk
         (left)   ; leftovers from uneven parallelisation
         (p 0)    ; value of pi
         (tl nil)); threads list
      (setq chunk (floor (/ n threads)))
      (setq left  (- n (* chunk threads)))

      ; Create threads and set them off.
      (loop for j from 0 to (- threads 1) do
         (setq fst (* j chunk))
         (setq fnl (- (* (+ j 1) chunk) 1))
         (if (= j (- threads 1))    ; if we are the last thread also do 
            (setq fnl (+ fnl left)) ; leftovers in this thread
         )
         (format t "DEBUG: Thread ~a from ~a to ~a~%" j fst fnl)
         (setq tl (cons (sb-thread:make-thread (lambda () (calcpi n fst fnl))) tl))
      ) 

      ; Join threads and gather results.
      (loop for item in tl
         do (setq p (+ p (sb-thread:join-thread item)))
      )
      p
   )
)

; Our main body
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

; Perform calculation
(defvar p (parapi n threads))

; get-internal-real-time is in some platform specific unit which we can find in
; internal-time-units-per-second
(defvar stop (get-internal-real-time))
(defvar runt (/ (- stop start) internal-time-units-per-second))

(format t "Obtained value of PI: ~a~%" p)

; We have to print the time with ~f to force a float output.
(format t "Time taken: ~f seconds~%" runt)
