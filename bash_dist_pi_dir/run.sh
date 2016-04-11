#!/usr/bin/env bash

# Calculates pi using a numerical integration of
#           1
#   y = --------- 
#        1 + x^2

# The indefinite integral of 1/(1+x^2) wrt x is tan^-1 x (+ constant)
# \int\frac{1}{1+x^2}\mathrm{d} x = \tan^{-1} x + c

# Evaluating that integral between x = 0 and x = 1 gives us pi/4
# \int^{1}_0\frac{1}{1+x^2}\mathrm{d} x = \frac{\pi}{4}

# So if we add the area of sufficiently many y-high rectangles between 0 and 1
#  for y = 1/(1+x^2) , and multiply by 4, we should get a decent approximation for pi

#set -v -x

num_threads=$(cat machinefile | wc -l)

num_steps=100000000

if [ -n "$1" ]; then
  num_steps=$1
fi

start=$(date +%s.%N)
sum=0
step=$(bc <<<"scale=32; 1 / $num_steps")

echo "Calculating PI using:
  $num_steps slices
  $num_threads distributed bc processes"

ceildiv() { 
  div=$(( $1/$2 ))
  divmul=$(( div*$2 ))
  if [ $divmul -eq $1 ]; then 
    echo $div 
  else 
    echo $(( $div + 1 ))
  fi 
}

min() { 
  if [ $1 -lt $2 ]; then 
    echo "$1"
  else 
    echo "$2"
  fi 
}


slices_per_thread=$( ceildiv $num_steps $num_threads )

echo "Worker checkins:"
exec 2>&1
values=$( \
    thread=0
    for machine in `cat machinefile`; do
      my_slice_start=$(( thread * $slices_per_thread ))
      my_slice_stop=$(min $(( (thread + 1) * $slices_per_thread )) $num_steps)
      echo "  bc process $thread calculating slices: [${my_slice_start}-${my_slice_stop})" >&2
      ssh $machine bc <<EOF 2>/dev/null &
             scale=32 
             my_slice_start = $thread * $num_steps / $num_threads 
             my_slice_stop  = (($thread + 1) * $num_steps / $num_threads) - 1 
             for (i=$my_slice_start;i<$my_slice_stop;i=i+1) {
               x = (i - 0.5) * $step
               sum = sum + ( 4 / ( 1 + x*x ) )
             }
             sum
EOF
      let thread=thread+1
    done 
    wait 
    )

for value in $values; do
  sum=$(bc <<<"scale=32; $sum + ($value * $step)")
done

# Add Kahan summation, compare difference to naive

stop=$(date +%s.%N)
time_taken=$(bc <<<"scale=32; $stop - $start")


echo "Obtained value of PI: $sum"
echo "Time taken: $time_taken seconds"

