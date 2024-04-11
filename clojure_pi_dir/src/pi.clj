; We have to define name-space etc. because we want to compile to to Java byte-code.
(ns pi
  (:gen-class
  :methods [#^{:static true} [calcpi [int] double]]))

; The function that does the bulk of our work as usual.
(defn -calcpi [n] ((fn [x] (/ (apply + (map (fn [x] (/ 4 (+ 1 (* x x)))) (range (/ 0.5 x) 1 (/ 1 x)))) x)) n))

(defn calcpi [n] (-calcpi n))
