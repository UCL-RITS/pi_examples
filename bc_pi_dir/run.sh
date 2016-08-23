#!/usr/bin/env bash

date >/dev/null 2>/dev/null # warm file cache

var_start=$(date +%s.%N)
var_stop=$(date +%s.%N)

if [ "${1:-}" != "" ]; then
    num_steps="$1"
else
    num_steps=1000000
fi


start=$(date +%s.%N)
bc -q <<EOF

scale=32
num_steps = $num_steps

print "Calculating PI with:\n  ", num_steps, " slices\n  1 process\n"

total_sum = 0
step = 1.0 / num_steps

for (i=0; i<num_steps; i++) {
  x = (i-0.5) * step
  total_sum += 4.0 / (1.0 + x*x)
}

pi = total_sum * step

print "Obtained value of PI: ", pi, "\n"

EOF
stop=$(date +%s.%N)

time_taken=$(bc <<<"scale=32;($stop - $start) - ($var_stop - $var_start)")

echo "Time taken: $time_taken seconds"

