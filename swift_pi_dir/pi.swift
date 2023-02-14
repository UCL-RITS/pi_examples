#!/usr/bin/env swift

import Foundation

var num_steps: Int = 10000000

if CommandLine.arguments.count == 2 {
    num_steps = Int(CommandLine.arguments[1])!;
}

print("Calculating PI with:")
print("  " + String(num_steps) + " slices")
print("  1 process")

var total_sim: Double = 0.0
var step: Double = 1.0/Double(num_steps)

// Get time.
let start = Date()

for i in 1...num_steps {
    let x: Double = (Double(i) - 0.5) * step
    total_sim += 4.0/(1.0+(x*x))
}

var pi: Double = total_sim * step

// Get time again.
let stop = Date()
let interval = stop.timeIntervalSince(start)

print("Obtained value of PI: " + String(pi))
print("Time taken: " + String(interval) + " seconds")
