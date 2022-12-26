#!/usr/bin/env ruby

# Quick method to output debug messages to stderr in a common format.
def debug(show, message)
  if show
    STDERR.puts("DEBUG >>> " + message)
  end
end

# calc_pi_t integrates a chunk of the curve.
def calc_pi_t(n, start, stop, verbose)
  total_sum = 0.0
  step = 1.0/n
  debug(verbose, "Calculating " + start.to_s + " to " + (stop - 1).to_s)
  (start..(stop - 1)).each do |i|
    x = (i + 0.5) * step
    total_sum += 4.0/(1.0 + (x * x))
  end

  return total_sum * step
end

# This routine forks a new process that runs calc_pi_t
def calc_pi_p(n, start, stop, verbose)
  read, write = IO.pipe

  pid = fork do
    read.close
    p = calc_pi_t(n, start, stop, verbose)
    write.puts(p)
    exit(0)
  end

  write.close
  p = read.read.to_f
  Process.wait(pid)
  return p
end

# calc_pi takes a number of slices and a number of threads.
def calc_pi(n, num_threads, verbose)
  p = 0.0

  # Although we are using processes, wrap their handlers in threads so comms
  # is separated out.
  threads = [num_threads]               # Array of threads.
  per_thread = n / num_threads          # Integer number of slices per thread.
  debug(verbose,"Slices per thread: " + per_thread.to_s)

  loss = n - (num_threads * per_thread) # Leftover from integer division.
  debug(verbose,"Lost slices: " + loss.to_s)

  lower = [num_threads]
  upper = [num_threads]
  
  # Create the threads. We have to be very careful with scope here, hence
  # upper and lower being arrays.
  (0..(num_threads - 1)).each do |i|
    lower[i] = i * per_thread
    upper[i] = (i + 1) * per_thread
  
    if i == (num_threads - 1)
      upper[i] = upper[i] + loss
    end
    debug(verbose,"lower: " + lower[i].to_s + " upper: " + upper[i].to_s)
    threads[i] = Thread.new {
      Thread.current["local_p"] = calc_pi_p(n,lower[i],upper[i],verbose)
    }
  end
  
  # Join the threads and sum p
  threads.each do |i|
    i.join
    p = p + i["local_p"]
  end

  return p
end

# Ruby doesn't have main which is.. great...
n = 50000000
num_threads = 1
verbose = false

if ARGV.size > 0
  n = ARGV[0].to_i
end

# Obey OMP_NUM_THREADS
if ENV.has_key?("OMP_NUM_THREADS")
  num_threads = ENV["OMP_NUM_THREADS"].to_i
end

# Turn on debug messages
if ENV.has_key?("PI_DEBUG")
  verbose_s = ENV["PI_DEBUG"]
  if verbose_s.downcase == "true"
    verbose = true
  end
end

puts "Calculating PI with:\n  " + n.to_s + " slices\n  " + num_threads.to_s + " process(es)"

start = Time.now
p = calc_pi(n,num_threads, verbose)
stop = Time.now

elapsed = stop - start

puts "Obtained value of PI: " + p.to_s 
puts "Time taken: " + elapsed.to_s + " seconds"
