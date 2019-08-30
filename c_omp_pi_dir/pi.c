#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main( int argc, char **argv ) {
   long i, num_steps = 1000000000;
   double step, x, sum, pi, taken;
   double start, stop;  
   int num_threads = omp_get_max_threads();
 
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }
   
   printf("Calculating PI using:\n"
          "  %ld slices\n"
          "  %d thread(s)\n", num_steps, num_threads);
   
   start = omp_get_wtime();
   
   sum = 0.0;
   step = 1.0 / num_steps;

#pragma omp parallel for private(x) reduction(+:sum)
   for (i=0;i<num_steps;i++) {
      x    = (i + 0.5) * step;
      sum += 4.0 / (1.0 + x*x);
   }

   pi = sum * step;

   stop = omp_get_wtime();
   taken = ((double)(stop - start));

   printf("Obtained value for PI: %.16g\n"
          "Time taken:            %.16g seconds\n", pi, taken);

   return 0;
}

