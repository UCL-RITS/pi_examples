#lang racket

(require "pi.rkt")

; Run the main pi example based on command-line args.

(module* main #f

  ; Sort out command-line options.
  (define n (if (> (vector-length (current-command-line-arguments)) 0)
                (string->number (vector-ref  (current-command-line-arguments) 0))
                10000000))
  (pi-calc n)
  )
