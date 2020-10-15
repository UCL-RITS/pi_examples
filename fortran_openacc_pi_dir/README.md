# OpenACC example.

By default this builds for Myriad with the Nvidia HPC SDK.

There are two versions of the code - a standard one which takes a single argument (a number of slices) and then tries to use that as a 64 bit Int to iterate over.  However, it has been observed that in some targets of the Nvidia HPC SDK, principally multicore, something is getting cast to a 32 bit int in the loop counter resulting in wrong results.  Therefore a second version of the code which takes two arguments, `imax` and `jmax` such that `num_slices = imax * jmax` and which uses nested loops, `pi_big.f90` has been provided.

Issuing `make` on Myriad should produce three binaries:

 * `pi` - the normal version of the code, compiled for P100, V100 and multicore
 * `pi_host` - as above but with the host target (single core) instead of multicore
 * `pi_big` - the version which takes two arguments, built for P100, V100 and multicore

Running the binaries on a node should result in them using either GPU target when available, or the appropriate CPU target if not.

You can control the number of cores for the multicore target with `$ACC_NUM_CORES` but this is not reflected in the output of the program because there does not appear to be an OpenACC equivalent of `omp_num_threads()`.
