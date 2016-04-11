program pi_openmp

  parameter (num_steps = 1000000000)
  double precision step, x, sum, pi, my_wtime, start, stop
  integer, external :: omp_get_num_threads 
  integer, external :: omp_get_max_threads
  integer, external :: omp_get_thread_num

! Output start message

  print *,"Calculating PI using:"
  print *,"  ", num_steps, "slices"
  print *,"  ", 1, "process"

! Initialise time counter and sum: set step size

  call cpu_time(start)
  sum = 0.
  step = 1.0d0 / num_steps

  do i = 1, num_steps
    x = (i - 0.5d0) * step
    sum = sum + 4.0d0 / (1.0d0 + x*x)
  end do

! Evaluate PI from the final sum value, and stop the clock

  pi = sum * step
  call cpu_time(stop)

! output value of PI and time taken
! note cpu_time is only specified as being microsecond res

  print *,"Obtained value of PI: ",pi
  print *,"Time taken: ",(stop-start), "seconds"

end program pi_openmp

