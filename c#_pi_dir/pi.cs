using System;
using System.Threading.Tasks;

class Program {

   static bool DEBUG;

   static void DebugMessage(String message) {
      if (DEBUG) {
         Console.Error.WriteLine(">>> DEBUG: " + message);
      }
   }

   static void WarningMessage(String message) {
      Console.Error.WriteLine(">>> WARNING: " + message);
   }

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
      DEBUG = false;

      string? PI_DEBUG = Environment.GetEnvironmentVariable("PI_DEBUG");
      if (PI_DEBUG != null) {
         if (PI_DEBUG.Trim().ToLower().Equals("true") || PI_DEBUG.Trim().Equals("1")) {
            DEBUG = true;
         } else if (PI_DEBUG.Trim().ToLower().Equals("false") || PI_DEBUG.Trim().Equals("0")) {
            DEBUG = false;
         } else {
            WarningMessage("Ignoring invalid value of PI_DEBUG: " + PI_DEBUG);
         }
      }

      if (argv.Length > 0) {
         numsteps = Convert.ToInt64(argv[0]);
      }

      string? OMP_NUM_THREADS = Environment.GetEnvironmentVariable("OMP_NUM_THREADS");
      if (OMP_NUM_THREADS != null) {
         DebugMessage("OMP_NUM_THREADS detected: " + OMP_NUM_THREADS);
         try {
            numthreads = Convert.ToInt32(OMP_NUM_THREADS);
            DebugMessage(" => setting threads to: " + numthreads);
         } catch {
            WarningMessage("Ignoring invalid value of OMP_NUM_THREADS: " + OMP_NUM_THREADS);
         }
         
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
         DebugMessage(j + ": " + sta + " => " + sto + " == " + psub);

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
