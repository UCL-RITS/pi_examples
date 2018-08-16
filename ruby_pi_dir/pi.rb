#!/usr/bin/env ruby

def calc_pi(n)
  total_sum = 0.0
  step = 1.0/n

  for i in 1..(n - 1)
    x = (i + 0.5) * step
    total_sum += 4.0/(1.0 + (x * x))
  end

  return total_sum * step
end

n = 50000000

if ARGV.size > 0
  n = ARGV[0].to_i
end

puts "Calculating PI with:\n  " + n.to_s + " slices\n  1 process"

start = Time.now
p = calc_pi(n)
stop = Time.now

elapsed = stop - start

puts "Obtained value of PI: " + p.to_s 
puts "Time taken: " + elapsed.to_s + " seconds"
