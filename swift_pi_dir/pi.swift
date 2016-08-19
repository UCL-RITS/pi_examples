#if os(Linux) || os(FreeBSD)
	import Glibc
#else
	import Darwin
#endif

var num_steps: Int = 1000000000

// Set up stuff for timing from Glibc.
// timeval is a Glibc structure.
var rettime:timeval = timeval(tv_sec: 0, tv_usec: 0)

if Process.arguments.count == 2 {
    num_steps = Int(Process.arguments[1])!;
}

print("Calculating PI with:")
print("  " + String(num_steps) + " slices")
print("  1 process")

var total_sim: Double = 0.0
var step: Double = 1.0/Double(num_steps)

// gettimeofday is a Glibc function.
// Call it with the pointer to rettime so that it fills rettime.
gettimeofday(&rettime, nil)
var start: Double = Double(rettime.tv_sec) + (Double(rettime.tv_usec)/1000000)

for i in 1...num_steps {
    var x: Double = (Double(i) - 0.5) * step
    total_sim += 4.0/(1.0+(x*x))
}

var pi: Double = total_sim * step

// Get time of day again.
gettimeofday(&rettime, nil)
var stop: Double = Double(rettime.tv_sec) + (Double(rettime.tv_usec)/1000000)

print("Obtained value of PI: " + String(pi))
print("Time take: " + String(stop - start) + " seconds")
