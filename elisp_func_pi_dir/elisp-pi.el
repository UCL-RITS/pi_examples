; PI Emacs LISP example.
; Functional!

(defun pc (c) (/ (apply #'+ (mapcar #'(lambda (x) (/ 4 (+ 1 (* x x)))) ((lambda (n) (number-sequence (/ 0.5 n) 1 (/ 1.0 n))) c))) c))

(defun calc-pi (pi-n)

  (princ "Calculating PI using:\n")
  (princ (format "  %d slices\n" pi-n))
  (princ "  1 process\n")

; current-time returns a 4-ple but we can just use the time-subtract
;  and float-time functions below and mostly ignore that
  (defvar pi-start (current-time))

  (defvar pi-p (pc pi-n))

  (defvar pi-stop (current-time))

  (defvar pi-runt (float-time (time-subtract pi-stop pi-start)))

  (princ (format "Obtained value of PI: %.16g\n" pi-p))

; We have to print the time with ~f to force a float output.
  (princ (format "Time taken: %g seconds\n" pi-runt))
  )

; Effectively the main method
(defvar pi-n 5000000)

(if (> (length command-line-args-left) 0)
    (setq pi-n (string-to-number (pop command-line-args-left)))
  )
(calc-pi pi-n)
