; This is a wrapper Clojure script that checks command line args and calls the
; methods we have defined in pi.clj.

; We could actually build in this script because of the way LISPs like Clojure
; work but that would mean building every time, so leave it to Make.

(def n 10000000)
(if (> (count *command-line-args*) 0)
  (def n(Integer/parseInt (first *command-line-args*)))
)

(import 'pi)

(pi/calcpi n)
