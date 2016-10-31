program pi

  implicit none

  double precision  :: step, x, sum, mypi, start, stop
  integer*8         :: num_steps, i
  character(len=32) :: arg

  num_steps = 1000000000

! Get command line args (Fortran 2003 standard)
  if (command_argument_count() > 0) then
     call get_command_argument(1, arg)
     read(arg,*) num_steps
  end if

! Output start message

  write(*,'(A)') "Calculating PI using:"
  write(*,'(A,1I16,A)') "                  ",num_steps, " slices"
  write(*,'(A,1I16,A)') "                  ",1," process"

! Initialise time counter and sum: set step size

  call cpu_time(start)
  sum = 0.
  step = 1.0d0 / num_steps

  do i = 1, num_steps
    x = (i - 0.5d0) * step
    sum = sum + 4.0d0 / (1.0d0 + x*x)
  end do

! Evaluate PI from the final sum value, and stop the clock

  mypi = sum * step
  call cpu_time(stop)

! output value of PI and time taken
! note cpu_time is only specified as being microsecond res

  write(*,'(A,1F12.10,A)') "Obtained value of PI: ", mypi
  write(*,'(A,1F12.5,A)') "Time taken:           ",(stop-start), " seconds"

end program pi

