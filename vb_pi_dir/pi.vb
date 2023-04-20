imports System
imports System.Threading.Tasks

Public Class Program

   ' Globally turn on and off debugging.
   Dim Shared DEBUG as long

   ' Helper that prints messages if debugging is enabled.
   Shared Sub DebugMessage(message)
      if (DEBUG) then
         Console.Error.WriteLine(">>> DEBUG: " & message)
      end if 
   End sub

   ' Helper that prints warning messages.
   Shared Sub WarningMessage(message)
      Console.Error.WriteLine(">>> WARNING: " & message)
   End sub

   Public Shared Sub Main()
      Dim numsteps as long
      Dim numthreads as integer
      Dim mystep, mypi, mytime as double
      Dim mystart, mystop as DateTime
      Dim mydifference as TimeSpan
      Dim options as new ParallelOptions

      Dim arguments as String() = Environment.GetCommandLineArgs()
      Dim PI_DEBUG as String = Environment.GetEnvironmentVariable("PI_DEBUG")
      Dim OMP_NUM_THREADS as String = Environment.GetEnvironmentVariable("OMP_NUM_THREADS")

      ' Defaults
      numsteps = 100000000
      numthreads = 1
      DEBUG = false 

      ' Set DEBUG based on environment variable PI_DEBUG.
      if not String.IsNullOrEmpty(PI_DEBUG) then
         if (PI_DEBUG.Trim().ToLower().Equals("true") or PI_DEBUG.Trim().Equals("1")) then
            DEBUG = true
         else if (PI_DEBUG.Trim().ToLower().Equals("false") or PI_DEBUG.Trim().Equals("0")) then
            DEBUG = false
         else
            WarningMessage("Ignoring invalid value of PI_DEBUG: " & PI_DEBUG)
         end if
      end if

      ' Set numsteps based on first argument.
      if arguments.Length > 1 then
         try 
            numsteps = Convert.ToInt64(arguments(1))
         catch
            WarningMessage("Ignoring invalid value of first argument: " & arguments(1))
         end try
      end if

      ' Set number of threads based on environment variable OMP_NUM_THREADS.
      if not String.IsNullOrEmpty(OMP_NUM_THREADS) then
         DebugMessage("OMP_NUM_THREADS detected: " & OMP_NUM_THREADS)
         try 
            numthreads = Convert.ToInt32(OMP_NUM_THREADS)
            DebugMessage(" => setting threads to: " & numthreads)
         catch
            WarningMessage("Ignoring invalid value of OMP_NUM_THREADS: " & OMP_NUM_THREADS)
         end try
      end if

      ' If there is a second argument override number of threads.
      if arguments.Length > 2 then
         try 
            numthreads = Convert.ToInt32(arguments(2))
         catch
            WarningMessage("Ignoring invalid value of second argument: " & arguments(2))
         end try
      end if
      
      ' Set number of threads in a ParallelOptions object.
      options.MaxDegreeOfParallelism = numthreads

      Console.WriteLine("Calculating PI using:")
      Console.WriteLine("  " & numsteps.ToString & " slices")
      Console.WriteLine("  " & numthreads.ToString & " thread(s)")

      mystart = DateTime.Now

      Dim parallelsum(numthreads - 1) as integer

      mystep = 1.0/numsteps

      Parallel.For (0, numthreads, options, Sub(j)
         ' Work out decomposition
         Dim lower as long
         Dim upper as long

         Dim x as double
         Dim subtotal as double

         lower = j * (numsteps/numthreads)
         upper = (j + 1) * (numsteps/numthreads)

         ' Loop
         for i as long = lower to upper
            x = (i - 0.5) * mystep
            subtotal = subtotal + (4.0/(1.0 + (x * x)))
         next i
         DebugMessage(j.ToString & ": " & lower.toString & " => " & upper.ToString & " == " & subtotal.ToString)
         parallelsum(j) = subtotal
      End Sub)

      mypi = parallelsum.Sum * mystep

      mystop = DateTime.Now
      mydifference = mystop.Subtract(mystart)

      mytime = mydifference.TotalSeconds

      Console.WriteLine("Obtained value of PI: " & mypi)
      Console.WriteLine("Time taken: " & mytime & " seconds")

   End Sub
End Class



