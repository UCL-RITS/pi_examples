program pi

  use ISO_FORTRAN_ENV

  implicit none
  
  double precision              :: step, x, s, mypi, start, stop, omp_get_wtime
  integer(kind=int64)           :: num_steps, i
  character(len=:), allocatable :: a
  integer, external             :: omp_get_max_threads
  integer                       :: argl

  num_steps = 100000000
  num_steps = num_steps * 100 ! work around nvfortran constant size error

! Get command line args (Fortran 2003 standard)
  if (command_argument_count() > 0) then
     call get_command_argument(1, length=argl)
     allocate(character(argl) :: a)
     call get_command_argument(1, a)
     read(a,*) num_steps
  end if

! Output start message

  write(*,'(A)') "Calculating PI using:"
  write(*,'(A,1I16,A)') "                  ",num_steps, " slices"
  write(*,'(A,1I16,A)') "                                  1 gpu"

! Initialise time counter and sum: set step size

  start = omp_get_wtime()
  s = 0d0
  step = 1.0d0 / num_steps

! Specify that loops within this region should have kernels built for GPU

!$ACC KERNELS
  do i = 1, num_steps
    x = (i - 0.5d0) * step
    s = s + 4.0d0 / (1.0d0 + x*x)
  end do
!$ACC END KERNELS

! Evaluate PI from the final sum value, and stop the clock

  mypi = s * step
  stop = omp_get_wtime()

! output value of PI and time taken

  write(*,'(A,1F12.10,A)') "Obtained value of PI: ", mypi
  write(*,'(A,1F12.5,A)') "Time taken:           ",(stop-start), " seconds"

end program pi

