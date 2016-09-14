// Needs correcting on timing code
// Docs here: https://golang.org/pkg/time/#Time.UnixNano
// Testpad here: http://tour.golang.org/basics/13

package main

import (
	"fmt"
	"os"
	"runtime"
	"strconv"
	"time"
)

func calc_steps(gort_num int, begin_step int, end_step int, step float64, sum_output chan float64) {
	fmt.Printf("  Goroutine %d calculating slices: [%d:%d)\n", gort_num, begin_step, end_step)
	var i int
	var x float64
	var sum float64

	sum = 0.0

	for i = begin_step; i < end_step; i++ {
		x = (float64(i) + 0.5) * step
		sum += 4.0 / (1.0 + x*x)
	}

	sum_output <- sum

}

func min(a int, b int) int {
	if a < b {
		return a
	} else {
		return b
	}
}

func main() {
	var i int

	var num_steps int
	var err error

	if len(os.Args) > 1 {
		num_steps, err = strconv.Atoi(os.Args[1])
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error parsing argument as step count: %s\n", err)
			os.Exit(1)
		}
	} else {
		num_steps = 1000000000
	}

	num_cores := runtime.NumCPU()

	fmt.Printf("Calculating PI using:\n  %v slices\n  %v goroutines\nWorker checkins:\n", num_steps, num_cores)

	result_channel := make(chan float64, num_cores)

	var overall_sum float64 = 0
	step := 1.0 / float64(num_steps)
	step_blocks := num_steps / num_cores

	var start time.Time = time.Now()

	for i = 0; i < num_cores; i++ {
		go calc_steps(i, i*step_blocks, min(((i+1)*step_blocks), num_steps), step, result_channel)
	}

	for i = 0; i < num_cores; i++ {
		overall_sum += <-result_channel
	}

	var stop time.Time = time.Now()

	var pi = overall_sum * step

	timeTaken := (float64(stop.Sub(start)) * 0.000000001) // Durations come in ns

	fmt.Printf("Obtained value for PI: %.16g\nTime taken: %v s\n", pi, timeTaken)
}

//  const f = "%T(%v)\n"
