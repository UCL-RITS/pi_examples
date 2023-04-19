using System;
using System.Threading.Tasks;

class Program {

   // Global to turn debug output on and off.
   static bool DEBUG;

   // Helper that prints debug messages if DEBUG.
   static void DebugMessage(String message) {
      if (DEBUG) {
         Console.Error.WriteLine(">>> DEBUG: " + message);
      }
   }

   // Helper that prints warning messages.
   static void WarningMessage(String message) {
      Console.Error.WriteLine(">>> WARNING: " + message);
   }

   static void Main(String[] argv) {

      long numsteps;
      int numthreads;
      double step, mypi, time;
      DateTime start, stop;
      TimeSpan difference;
      ParallelOptions options;

      // Defaults
      numsteps = 100000000;
      numthreads = 1;
      DEBUG = false;

      // Based value of DEBUG on environment variable PI_DEBUG.
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

      // Base number of steps on argument 0.
      if (argv.Length > 0) {
         try {
            numsteps = Convert.ToInt64(argv[0]);
         } catch {
            WarningMessage("Ignoring invalid value of first argument: " + argv[0]);
         }
      }

      // If OMP_NUM_THREADS is set use as number of threads.
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

      // If there is a second argument, set number of threads to that, overriding OMP_NUM_THREADS if set.
      if (argv.Length > 1) {
         try {
            numthreads = Convert.ToInt32(argv[1]);
         } catch {
            WarningMessage("Ignoring invalid value of second argument: " + argv[1]);
         }
      }

      // Create a parallel option set that sets the maximum number of current threads.
      options = new ParallelOptions{MaxDegreeOfParallelism = numthreads};

      Console.WriteLine("Calculating PI using:");
      Console.WriteLine("  " + numsteps + " slices");
      Console.WriteLine("  " + numthreads + " thread(s)");

      start = DateTime.Now;

      // Array to store the output of the chunks.
      double[] parallelsum = new double[numthreads];

      step = 1d/(double)numsteps;

      // Actual parallel loop.
      Parallel.For(0, numthreads, options, j => {
         // Do decomposition
         // Note: to make variables explicitly local we need to declare them inside.
         long lower = j * (numsteps/numthreads);
         long upper = ((j + 1) * (numsteps/numthreads)) - 1;
         if (j == numthreads - 1) {
            upper = numsteps -1;
         }
         double x = 0d;
         double subtotal = 0;

         for (long i = lower; i <= upper; i++){
            x = ((double)i + 0.5d) * step;
            subtotal += 4d/(1d + (x * x));
         }
         DebugMessage(j + ": " + lower + " => " + upper + " == " + subtotal);
         parallelsum[j] = subtotal;
      });

      mypi = parallelsum.Sum() * step;

      stop = DateTime.Now;
      difference = stop.Subtract(start);

      time = difference.TotalSeconds;

      Console.WriteLine("Obtained value of PI: " + mypi);
      Console.WriteLine("Time taken: " + time + " seconds");
   }
}
