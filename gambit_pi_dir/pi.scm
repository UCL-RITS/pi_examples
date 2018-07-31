;; Function to get our command-line arguments.
;; Annoyingly (and obviously) command-line has a different length depending
;; on whether the program is run through gsi or whether it is compiled to a
;; stand-alone executable and run - i.e. either
;;   ./pi <args>
;;   gsi pi.scm <args>
(define (command-line-args) 
  (define args (command-line))
  (if (string=? (car args) "gsi")
    (set! args (cdr args))
  )

;; Strip the program name (./pi or pi.scm)
  (set! args (cdr args))
  args
)

;; Get time in float seconds.
(define (current-time-seconds) 
  (time->seconds(current-time))
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

(define arguments (command-line-args))
(if (> (length arguments) 0)  
  (set! n (string->number (car arguments)))
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
