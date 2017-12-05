#lang racket

; PI scheme (Racket) example.

(provide pi-calc)

; Define pi-calc as a function so we can test it interactively in DrRacket.
; To run at command-line:
; $ racket run.rkt

(define (pi-calc n)
  
  (display "Calculating PI using\n  ")
  (display n)
  (display " slices\n  1 process\n")
  
  ; current-inexact-milliseconds returns an "inexact integer" number of ms.
  (define start (current-inexact-milliseconds))
  
  (define p ((lambda (n) (/ (apply + (map (lambda (n) (/ 4 (+ 1 (* n n)))) ((lambda (n) (range (/ 0.5 n) 1 (/ 1 n))) n))) n)) n))
  
  ; current-inexact-milliseconds returns an "inexact integer" number of ms.
  (define stop (current-inexact-milliseconds))
  
  (define runt (/ (- stop start) 1000.0d0))
  
  (display (string-append "Obtained value of PI: "(number->string p)))
  (newline)
  (display (string-append "Time taken: " (number->string runt)))
  (display " seconds\n")
  )

