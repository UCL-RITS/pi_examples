
import os
import parseutils
import times

var num_steps = 0

if paramCount() > 0:
   discard parseInt(paramStr(1), num_steps)
else:
   num_steps = 1000000000

echo "Calculating PI using:\n  ", num_steps, " slices\n  1 process"

let step =  1.0 / (float64)num_steps
var sum:float64 = 0.0
var x:float64 = 0.0

var start = cpuTime()

for i in 0 .. num_steps:
  x = ((float64 i) + 0.5) * (float64 step);
  sum += 4 / (1 + x*x)
 
var pi = sum * step

var stop = cpuTime()

echo "Obtained value for PI: ", pi, "\nTime taken: ", (stop - start), " seconds"
