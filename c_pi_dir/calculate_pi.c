#include <stdio.h>
#include "pi_mytime.h"

int main( int argc, char **argv ) {
   long i, num_steps = 1000000000;
   
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }

   double step, x, sum, pi, start, stop;
   
   printf("Calculating PI using:\n"
          "  %ld slices\n"
          "  1 process\n", num_steps);
   
   start = my_wtime();
   
   sum = 0.0;
   step = 1.0 / num_steps;

   for (i=0;i<num_steps;i++) {
      x    = (i - 0.5) * step;
      sum += 4.0 / (1.0 + x*x);
   }

   pi = sum * step;

   stop = my_wtime();

   printf("Obtained value for PI: %.16g\n"
          "Time taken: %.16g seconds\n", pi, stop-start);

   return 0;
}

