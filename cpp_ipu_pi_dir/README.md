# Graphcore IPU implementation

Note: This version takes "*n*" as the first argument rather than the number of slices.  The number of slices used = *n* * number of IPU tiles, e.g.

```
[uccaoke@mandelbrot cpp_ipu_pi_dir]$ ./pi 1000
Using HW device ID: 0
Calculating PI using:
  1472000 slices
  1472 IPU tiles
Obtained value of PI: 3.14121
Time taken: 4.86941e-05 seconds (90084 cycles at 1.85 GHz)
```

By default *n* is set to `UINT32_MAX/num_tiles`.  Due to the Graphcore systems being single precision this results in extremely wrong values for π:

```
[uccaoke@mandelbrot cpp_ipu_pi_dir]$ ./pi 
Using HW device ID: 0
Calculating PI using:
  4294966272 slices
  1472 IPU tiles
Obtained value of PI: 0.146298
Time taken: 0.141946 seconds (262599924 cycles at 1.85 GHz)
```

