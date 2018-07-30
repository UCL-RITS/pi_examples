; Pi scheme (chicken) example

(define n 50000000)

(if (> (length (command-line-arguments)) 0)  
  (set! n (string->number (list-ref (command-line-arguments) 0)))
)

(display "Calculating PI using\n  ")
(display n)
(display " slices\n  1 process\n")

(define start (current-milliseconds))

(define sum 0.0d0)
(define st (/ 1.0d0 n))
(define x 0.0d0)

(do ((i 1 (+ i 1))) ((> i n)) 
  (set! x (* (- i 0.5d0) st))
  (set! sum (+ sum (/ 4.0d0 (+ 1.0d0 (* x x)))))
)

(define p (* sum st))

(define stop (current-milliseconds))

(define runt (/ (- stop start) 1000.0))

(display (string-append "Obtained value of PI: "(number->string p)))
(newline)
(display (string-append "Time taken: " (number->string runt)))
(display " seconds\n")

