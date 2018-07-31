;; Function to get our command-line arguments.
;; Strip off first argument.
(define (command-line-args) 
  (define args (command-line))
  (if (> (length args) 0)
    (set! args (cdr args))
  )
  args
)

;; Get time in float seconds.
(define (current-time-seconds) 
  (* 1.0d0 (/ (get-internal-real-time) internal-time-units-per-second))
)

;; Calculate pi for some n with our ususal method.
(define (calc-pi n) 
  (define sum 0.0d0)
  (define st (/ 1.0d0 n))
  (define x 0.0d0)
  (do ((i 1 (+ i 1))) ((> i n)) 
    (set! x (* (- i 0.5d0) st))
    (set! sum (+ sum (/ 4.0d0 (+ 1.0d0 (* x x)))))
  )
  (* sum st)
)


;; It's unclear how to define a main method?
;; This is our program body proper.
(define n 50000000)

(if (> (length (command-line-args)) 0)  
  (set! n (string->number (car (command-line-args))))
)

(display "Calculating PI using\n  ")
(display n)
(display " slices\n  1 process\n")

(define start (current-time-seconds))
(define p (calc-pi n))
(define stop (current-time-seconds))
(define runt (- stop start))

(display (string-append "Obtained value of PI: "(number->string p)))
(newline)
(display (string-append "Time taken: " (number->string runt)))
(display " seconds\n")

;; Need this otherwise when run with gsi, gsi tries to load subsequent args
;; as files.
(exit)
