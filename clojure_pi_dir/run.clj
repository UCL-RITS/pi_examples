

(def n 10000000)
(if (> (count *command-line-args*) 0)
  (def n(Integer/parseInt (first *command-line-args*)))
)

(import 'pi)

(pi/calcpi n)
