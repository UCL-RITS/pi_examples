# Pi calculating examples

These are intended as examples people can run to show how to run code from jobs, the terminal, or where ever else.

We (UCL ARC) use some of these for cluster training, showing users how to run MPI jobs and demonstrating different parallelisation mechanisms and so on.

The others are mostly just the result of learning a new thing, wanting to do something ridiculous, or just wondering what the performance would be like.

## Maths

They calculate pi using a numerical integration of

```math
y = \frac{1}{1 + x^2}
```

The indefinite integral of $(1 + x^2)^{-1}$ wrt $x$ is $\tan^{-1}(x)$ (+ constant)

OIOW:

```math
\int\frac{1}{1+x^2}\mathrm{d} x = \tan^{-1} x + c
```

Evaluating that integral between $x = 0$ and $x = 1$ gives us $\pi/4$

```math
 \int^{1}_0\frac{1}{1+x^2}\mathrm{d} x = \frac{\pi}{4}                         
```        

So if we add the area of sufficiently many y-high rectangles between $0$ and $1$ for $y = (1+x^2)^{-1}$, and multiply by $4$, we should get a decent approximation for $\pi$.

## Running

So that we can automatically test these, each directory should have a `run.sh` that builds and runs the example. Please use `make` unless you really can't (just to minimise additional dependencies).

## Output Format

To aid in comparison, when writing new ones or updating old ones, here's a few specifications:

  * If convenient, they may optionally take an argument that is the number of slices to use.
  * They are not required to act sensibly if the number of slices is fewer than the number of workers.
  * They should produce output following the scheme below:

```
Calculating PI using:
  1000 slices
  16 MPI tasks
  2 OpenMP threads per task
Worker checkins:
  MPI task 1, thread 0 calculating slices: [0:10000)
  MPI task 0, thread 1 calculating slices: [10000:19999)
Obtained value of PI: 3.141592645453890
Time taken: 0.4124 seconds
```

Worker checkin strings should be adapted to be appropriate to the given parallelisation method, obviously, but should aim to follow the format:

`method` `number`, `method` `number`, `method` `number` calculating slices: `boundary specifier`

Or for automatic distributions:

`method` `number` calculating automatic work allocation

If timing information has not yet been implemented, the following line may replace the time line:

```
No time data obtained
```

Optionally the following line may be appended where applicable:

```
Kahan summation difference: 0.00531
```

