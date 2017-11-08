(defn y [x]
    (/ 1.0 (+ 1 (** x 2)))
)

(defn calcpi [n r]
    (* (/ 4.0 n) (sum (map y r)))
)

; Generator to save memory
(defn gen_x [n]
    (for [element (range n)] (yield (/ (+ element 0.5) n)))  
)

(defn main[] 
    (import time)
    (import sys)

    (setv numslices 5000000)

    (if (> (len sys.argv) 1)
        (setv numslices (int (get sys.argv 1)))
    )

    (print "Calculating PI with:\n " numslices "slices\n " 1 "process")
    (setv start (time.time))
    (setv gen (gen_x numslices))
    (setv p (calcpi numslices gen))
    (setv stop (time.time))
    (print "Obtained value of PI:" p "\nTime taken:" (- stop start) "seconds")
)

(main)