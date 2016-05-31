imports System

Public Class Program
   Public Shared Sub Main()
      Dim numsteps as long
      Dim mystep, x, psum, mypi, mytime as double
      Dim mystart, mystop as DateTime
      Dim mydifference as TimeSpan

      Dim arguments as String() = Environment.GetCommandLineArgs()

      numsteps = 100000000

      if arguments.Length > 1 then
         numsteps = Convert.ToInt64(arguments(1))
      end if

      Console.WriteLine("Calculating PI using:")
      Console.WriteLine("  " & numsteps.ToString & " slices")
      Console.WriteLine("  1 processes")

      mystart = DateTime.Now

      psum = 0.0
      mystep = 1.0/numsteps

      for i as long = 1 to numsteps
         x = (i - 0.5) * mystep
         psum = psum + (4.0/(1.0 + (x * x)))
      next i

      mypi = psum * mystep

      mystop = DateTime.Now
      mydifference = mystop.Subtract(mystart)

      mytime = mydifference.TotalSeconds

      Console.WriteLine("Obtained value of PI: " & mypi)
      Console.WriteLine("Time taken: " & mytime & " seconds")

   End Sub
End Class



