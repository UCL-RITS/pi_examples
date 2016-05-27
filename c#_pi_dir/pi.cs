using System;

class Program {
   static void Main(String[] argv) {

      long i, numsteps;
      double step, x, psum, mypi, time;
      DateTime start, stop;
      TimeSpan difference;

      numsteps = 100000000;

      if (argv.Length > 0) {
         numsteps = Convert.ToInt64(argv[0]);
      }

      Console.WriteLine("Calculating PI using:");
      Console.WriteLine("  " + numsteps + " slices");
      Console.WriteLine("  1 processes");

      start = DateTime.Now;

      psum = 0d;
      step = 1d/(double)numsteps;

      for (i = 0; i < numsteps; i++) {
         x = ((double)i + 0.5d) * step;
         psum = psum + 4d/(1d + (x * x));
      } 

      mypi = psum * step;

      stop = DateTime.Now;
      difference = stop.Subtract(start);

      time = difference.TotalSeconds;

      Console.WriteLine("Obtained value of PI: " + mypi);
      Console.WriteLine("Time taken: " + time + " seconds");

   }


}
