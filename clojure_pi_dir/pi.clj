; We have to define name-space etc. because we want to compile to to Java byte-code.
(ns pi
  (:gen-class
   :methods [[calcpi [] Integer]]))

; The method that does the bulk of our work as usual.
(defn calcpi [n]
  (println "Calculating PI using:")
  (println " " n "slices")
  (println "  1 processes")

; When referring to Java stuff the syntax is class/method.
  (def start (System/currentTimeMillis))
  (def psum 0.0) 
  (def step (/ 1 n))
  
  (loop [i 0] (when (< i n)
    (def x (* (+ i 0.5) step))
    (def psum (+ psum (/ 4 (+ 1 (* x x)))))
    (recur (inc i))
  ))

  (def mypi (* psum step))
  (def stop (System/currentTimeMillis))
  (def difference (/ (- stop start) 1000.0))

  (println "Obtained value of PI:" mypi)
  (println "Time taken:" difference "seconds")
)
