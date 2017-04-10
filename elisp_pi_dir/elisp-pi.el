; PI Emacs LISP example.

(defvar n 5000000)

(if (> (length command-line-args-left) 0)
  (setq n (string-to-number (pop command-line-args-left)))
)

(princ "Calculating PI using:\n")
(princ (format "  %d slices\n" n))
(princ "  1 process\n")

; current-time returns a 4-ple but we can just use the time-subtract
;  and float-time functions below and mostly ignore that
(defvar start (current-time))

(defvar sum 0.0)
(defvar st (/ 1.0 n))
(defvar x 0.0)

; dotimes can only start at 0 as far as I can tell.
(dotimes (i (- n 1))
    (setq x (* (+ i 0.5) st))
    (setq sum (+ sum (/ 4.0 (+ 1 (* x x)))))
)

(defvar p (* sum st))

(defvar stop (current-time))

(defvar runt (float-time (time-subtract stop start)))

(princ (format "Obtained value of PI: %.16g\n" p))

; We have to print the time with ~f to force a float output.
(princ (format "Time taken: %g seconds\n" runt))

