; PI scheme (Guile) example.

(define n 5000000)

; Set n as per arguments.
(if (> (length (command-line)) 1)  
  (set! n (string->number (list-ref (command-line) 1)))
)

(display "Calculating PI using\n  ")
(display n)
(display " slices\n  1 process\n")

; get-internal-real-time gets time from some arbitrary, implementation 
; dependent starting point in some fraction of a second.
(define start (get-internal-real-time))

(define sum 0.0d0)
(define st (/ 1.0d0 n))
(define x 0.0d0)

(do ((i 1 (+ i 1))) ((> i n)) 
  (set! x (* (- i 0.5d0) st))
  (set! sum (+ sum (/ 4.0d0 (+ 1.0d0 (* x x)))))
)

(define p (* sum st))

; get-internal-real-time gets time from some arbitrary, implementation 
; dependent starting point in some fraction of a second.
(define stop (get-internal-real-time))

(define runt (* 1.0d0 (/ (- stop start) internal-time-units-per-second)))

(display (string-append "Obtained value of PI: "(number->string p)))
(newline)
(display (string-append "Time taken: " (number->string runt)))
(display " seconds\n")
