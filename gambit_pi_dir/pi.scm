; PI scheme (Gambit) example.

(define n 5000000)

; Annoyingly, command-line has a different length if we compile a stand-alone
; binary as opposed to run through gsi/gsc, for obvious reasons.
(define args (command-line))

(if (string=? (car args) "gsi")
  (set! args (cdr args))
)

(if (string=? (car args) "gsc")
  (set! args (cdr args))
)

; Pop off filename.
(set! args (cdr args))

; Set n as per arguments.
(if (> (length args) 0)  
  (set! n (string->number (car args)))
)

(display "Calculating PI using\n  ")
(display n)
(display " slices\n  1 process\n")

(define start (time->seconds(current-time)))

(define sum 0.0d0)
(define st (/ 1.0d0 n))
(define x 0.0d0)

(do ((i 1 (+ i 1))) ((> i n)) 
  (set! x (* (- i 0.5d0) st))
  (set! sum (+ sum (/ 4.0d0 (+ 1.0d0 (* x x)))))
)

(define p (* sum st))

(define stop (time->seconds(current-time)))

(define runt (- stop start)) 

(display (string-append "Obtained value of PI: "(number->string p)))
(newline)
(display (string-append "Time taken: " (number->string runt)))
(display " seconds\n")
(exit)
