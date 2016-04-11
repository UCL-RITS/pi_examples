program pi_openmp

  parameter (num_steps = 1000000000)
  double precision step, x, sum, pi, my_wtime, start, stop
  integer, external :: omp_get_num_threads 
  integer, external :: omp_get_max_threads
  integer, external :: omp_get_thread_num

! Output start message

  print *,"Calculating PI using:"
  print *,"  ", num_steps, "slices"
  print *,"  ", omp_get_max_threads(), "OpenMP threads"

! Initialise time counter and sum: set step size

  start = omp_get_wtime()
  sum = 0.
  step = 1.0d0 / num_steps

! Specify that the loop be parallelised, with summation of individual
! threads' sum values to yield overall sum. Specify that the variable
! x is local to each thread.

print *, "Worker checkins:"
!$OMP PARALLEL
  print *,"  OpenMP thread ", omp_get_thread_num(), " calculating automatic work allocation" 
!$OMP DO PRIVATE(x) REDUCTION(+:sum)
  do i = 1, num_steps
    x = (i - 0.5d0) * step
    sum = sum + 4.0d0 / (1.0d0 + x*x)
  end do
!$OMP ENDDO
!$OMP END PARALLEL

! Evaluate PI from the final sum value, and stop the clock

  pi = sum * step
  stop = omp_get_wtime()

! output value of PI and time taken

  print *,"Obtained value of PI: ",pi
  print *,"Time taken: ",(stop-start)," seconds"

end program pi_openmp

