#!/usr/bin/env swift

import Foundation

let y:(Double) -> Double = {x in 1.0/(1.0+(x*x))}

func calcp(n: Int) -> Double { return ((1...n).map{Double($0)/Double(n)}.map(y).reduce(0,+))*(4.0/Double(n)) }

var num_steps: Int = 10000000

if CommandLine.arguments.count == 2 {
    num_steps = Int(CommandLine.arguments[1])!;
}

print("Calculating PI with:")
print("  " + String(num_steps) + " slices")
print("  1 process")

// Get time.
let start = Date()

var pi: Double = calcp(n:num_steps)

// Get time again.
let stop = Date()
let interval = stop.timeIntervalSince(start)

print("Obtained value of PI: " + String(pi))
print("Time taken: " + String(interval) + " seconds")
