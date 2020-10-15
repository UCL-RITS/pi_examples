! This version of the code works around a weird loop counter bug in OpenACC
! where loops where the counter is a 64 bit int > 32bit max int on *some* 
! targets (e.g. multicore) get cropped at the 32 bit boundary.

program pi_big

  use ISO_FORTRAN_ENV
  use openacc

  implicit none
  
  double precision              :: step, x, s, mypi, start, stop, omp_get_wtime
  integer(kind=int64)           :: num_steps, i, j, imax, jmax
  character(len=:), allocatable :: a, b
  integer                       :: argl, bargl
  integer(kind=acc_device_kind) :: devices

  imax = 100000000

  jmax = 1

! Get command line args (Fortran 2003 standard)
  if (command_argument_count() > 0) then
     call get_command_argument(1, length=argl)
     allocate(character(argl) :: a)
     call get_command_argument(1, a)
     read(a,*) imax
     if (imax > 2147483647) then
       write(*,*) "base num_steps > max_int -> this can cause undefined behavior on some OpenACC "
       write(*,*) "targets e.g. multicore"
     end if
  end if
  
  if (command_argument_count() > 1) then
     call get_command_argument(2, length=bargl)
     allocate(character(bargl) :: b)
     call get_command_argument(2, b)
     read(b,*) jmax
     if (jmax > 2147483647) then
       write(*,*) "multiplicative num_steps > max_int -> this can cause undefined behavior on some"
       write(*,*) "OpenACC targets e.g. multicore"
     end if
  end if
  
  num_steps = imax * jmax

! Get 

! Output start message

  devices = acc_get_num_devices(acc_device_not_host)

  write(*,'(A)') "Calculating PI using:"
  write(*,'(A,1I16,A)') "                  ",num_steps, " slices"
  if (devices > 0) then
    write(*,'(A,1I16,A)') "                  ",1," gpu"
  else
    write(*,'(A,1I16,A)') "                  ",1," cpu core"
  end if
! Initialise time counter and sum: set step size

  start = omp_get_wtime()
  s = 0d0
  step = 1.0d0 / num_steps

! Specify that loops within this region should have kernels built for GPU

!$ACC PARALLEL
!$ACC LOOP PRIVATE(x,i,j,s) REDUCTION(+:s)
  do i = 1, imax
    do j = 1, jmax
      x = (((jmax * ( i - 1)) + j) - 0.5d0) * step
      s = s + 4.0d0 / (1.0d0 + x*x)
    end do
  end do
!$ACC END LOOP
!$ACC END PARALLEL

! Evaluate PI from the final sum value, and stop the clock

  mypi = s * step
  stop = omp_get_wtime()

! output value of PI and time taken

  write(*,'(A,1F12.10,A)') "Obtained value of PI: ", mypi
  write(*,'(A,1F12.5,A)') "Time taken:           ",(stop-start), " seconds"

end program pi_big

