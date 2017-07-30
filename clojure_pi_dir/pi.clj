(defn calc-pi [n]
  (println "Calculating PI using:")
  (println " " n "slices")
  (println "  1 processes")

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

(calc-pi 10000000)
