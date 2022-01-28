# Julia multi-threaded implementation

This folder contains multi-threaded implementation in Julia:

* `pi.jl` uses the low-level `Threads.@threads` macro;

To run the example, use
```
./run.sh
```
Julia uses the environment variable `JULIA_NUM_THREADS` to set the number of
threads to use in a process, or the `-t`/`--threads` flags to the `julia`
command (this flag is available only in Julia v1.5+).  If you run the example
using the `./run*.sh` wrappers, you can also use the `OMP_NUM_THREADS`
environment variable instead of `JULIA_NUM_THREADS`.
