# Graphcore IPU implementation in Julia

This is an implementation of the pi example in the Julia programming language for running on [Graphcore IPUs](https://www.graphcore.ai/products/ipu), using the package [`IPUToolkit.jl`](https://github.com/JuliaIPU/IPUToolkit.jl) developed among others by the [UCL Centre for Advanced Research Computing](https://www.ucl.ac.uk/advanced-research-computing).
To run this example you will need a version of Julia compatible with the Poplar SDK you are using, see the [documentation of `IPUToolkit.jl`](https://juliaipu.github.io/IPUToolkit.jl/) for more details.
The first time you run the benchmark the package will be installed automatically, this also involves compiling a C++ wrapper around the Poplar SDK, which can take up to ~6-7 minutes, please be patient.
Subsequent runs should be much faster, as the package will be already installed.

The program is parallelised across all the tiles of the attached IPU.
Like the equivalent [C++ program](../cpp_ipu_pi_dir), this uses single precision floating point numbers, so the result may not be very accurate.

Contrary to most of the other implementations in this repository, this script takes two arguments:

1. a [loop unrolling](https://en.wikipedia.org/wiki/Loop_unrolling) factor, which can sensibly speed-up the code.
   The default is to use a loop unrolling of 1, so that no manual loop unrolling is done.
2. `n`, rather than the number of slices.
   The number of slices used = n * number of IPU tiles.
   By default `n` is set to `typemax(UInt32) ÷ num_tiles`.
   `n` must be an integer multiple of the loop unrolling factor, an error is thrown if that's not the case.

## Examples

```console
[cceamgi@mandelbrot julia_ipu_pi_dir]$ ./run.sh
[ Info: Trying to attach to device 0...
[ Info: Successfully attached to device 0
✓ Compiling codelet Pi: 	 Time: 0:00:04
Calculating PI using:
  4294966272 slices
  1472 IPU tiles
  loop unroll factor 1
Obtained value of PI: 3.1499734
Time taken: 0.1325 seconds (245093526 cycles at 1.85 GHz)
[cceamgi@mandelbrot julia_ipu_pi_dir]$ ./run.sh 12
[ Info: Trying to attach to device 0...
[ Info: Successfully attached to device 0
✓ Compiling codelet Pi: 	 Time: 0:00:04
Calculating PI using:
  4294966272 slices
  1472 IPU tiles
  loop unroll factor 12
Obtained value of PI: 3.1499734
Time taken: 0.07492 seconds (138594708 cycles at 1.85 GHz)
[cceamgi@mandelbrot julia_ipu_pi_dir]$ ./run.sh 2 1000
[ Info: Trying to attach to device 0...
[ Info: Successfully attached to device 0
✓ Compiling codelet Pi: 	 Time: 0:00:04
Calculating PI using:
  1472000 slices
  1472 IPU tiles
  loop unroll factor 2
Obtained value of PI: 3.1415932
Time taken: 3.098e-5 seconds (57318 cycles at 1.85 GHz)
```
