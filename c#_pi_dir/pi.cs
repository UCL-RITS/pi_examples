using System;
using System.Threading.Tasks;

class Program {
   static void Main(String[] argv) {

      long numsteps;
      int numthreads;
      double step, psum, mypi, time;
      DateTime start, stop;
      TimeSpan difference;
      ParallelOptions options;
      object z = new object();

      numsteps = 100000000;
      numthreads = 1;

      if (argv.Length > 0) {
         numsteps = Convert.ToInt64(argv[0]);
      }

      string? OMP_NUM_THREADS = Environment.GetEnvironmentVariable("OMP_NUM_THREADS");
      if (OMP_NUM_THREADS != null) {
         Console.WriteLine("OMP_NUM_THREADS detected: " + OMP_NUM_THREADS);
         numthreads = Convert.ToInt32(OMP_NUM_THREADS);
         Console.WriteLine(" => setting threads to: " + numthreads);
      }

      if (argv.Length > 1) {
         numthreads = Convert.ToInt32(argv[1]);
      }

      options = new ParallelOptions{MaxDegreeOfParallelism = numthreads};

      Console.WriteLine("Calculating PI using:");
      Console.WriteLine("  " + numsteps + " slices");
      Console.WriteLine("  " + numthreads + " thread(s)");

      start = DateTime.Now;

      psum = 0d;
      step = 1d/(double)numsteps;

      Parallel.For<double>(0, numthreads, options, () => 0d, (j, loop, psub) => {
         // Do decomposition
         // Note: to make variables explicitly local we need to declare them inside.
         long sta = j * (numsteps/numthreads);
         long sto = ((j + 1) * (numsteps/numthreads)) - 1;
         if (j == numthreads - 1) {
            sto = numsteps -1;
         }
         double x = 0d;

         for (long i = sta; i <= sto; i++){
            x = ((double)i + 0.5d) * step;
            psub+= 4d/(1d + (x * x));
         }
         Console.WriteLine(j + ": " + sta + " => " + sto + " == " + psub);

         return psub;
      }, // Do reduction horribly.
         (y) => {lock (z) {psum += y;}}
      );

      mypi = psum * step;

      stop = DateTime.Now;
      difference = stop.Subtract(start);

      time = difference.TotalSeconds;

      Console.WriteLine("Obtained value of PI: " + mypi);
      Console.WriteLine("Time taken: " + time + " seconds");

   }


}
