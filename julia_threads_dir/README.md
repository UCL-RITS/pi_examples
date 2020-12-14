# Julia multi-threaded implementations

This folder contains two multi-threaded implementations in Julia:

* `pi.jl` uses the low-level `Threads.@threads` macro;
* `pi_floops.jl` uses an external package,
  [`FLoops.jl`](https://github.com/JuliaFolds/FLoops.jl), to implement the
  parallel reduction.

To run the first example, use
```
./run.sh
```
use instead
```
./run_floops.sh
```
for the `FLoops.jl`-based example.  `./run_floops.sh` will also take care of
installing the package for you --- this operation can take a while, depending on
how slow/fast is Git in your system.

Julia uses the environment variable `JULIA_NUM_THREADS` to set the number of
threads to use in a process, or the `-t`/`--threads` flags to the `julia`
command (this flag is available only in Julia v1.5+).  If you run the example
using the `./run*.sh` wrappers, you can also use the `OMP_NUM_THREADS`
environment variable instead of `JULIA_NUM_THREADS`.
