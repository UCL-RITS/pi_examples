#!/usr/bin/env rexx

/* NOTE: for some REXX interpreters you will need to delete the shebang. */

numsteps = 1000000

if arg(1) \= "" then
do
  numsteps = arg(1)
end

say "Calculating PI using: " numsteps " slices"

/* Subsequent calls to time("E") give elapsed time. */
start = time("E")

sum = 0.0
step = 1.0/numsteps

do i = 1 to numsteps
  x = (i - 0.5) * step
  sum = sum + 4.0/(1.0 + (x * x))
end

mypi = sum * step

/* Second call to time("E") gives time since last. */
stop = time("E")

say "Obtained value of PI: " mypi
say "Time taken: " stop " seconds"
