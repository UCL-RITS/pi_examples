// Needs correcting on timing code
// Docs here: https://golang.org/pkg/time/#Time.UnixNano
// Testpad here: http://tour.golang.org/basics/13

package main

import (
	"fmt"
	"time"
)

func main() {
	var i int
	var x float64
	num_steps := 1000000000
	fmt.Printf("Calculating PI using:\n  %v slices\n  1 process\n", num_steps)

	var sum float64 = 0
	step := 1.0 / float64(num_steps)

	var start time.Time = time.Now()

	for i = 0; i < num_steps; i++ {
		x = (float64(i) - 0.5) * step
		sum += 4.0 / (1.0 + x*x)
	}

	var stop time.Time = time.Now()

	var pi = sum * step

	timeTaken := (float64(stop.Sub(start)) * 0.000000001) // Durations come in ns

	fmt.Printf("Obtained value for PI: %.16g\n Time taken: %v s\n", pi, timeTaken)
}

//  const f = "%T(%v)\n"
