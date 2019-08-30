#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main( int argc, char **argv ) {
   long i, num_steps = 1000000000;
   double step, x, sum, pi, taken;
   clock_t start, stop;  
 
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }
   
   printf("Calculating PI using:\n"
          "  %ld slices\n"
          "  1 process\n", num_steps);
   
   start = clock();
   
   sum = 0.0;
   step = 1.0 / num_steps;

   for (i=0;i<num_steps;i++) {
      x    = (i + 0.5) * step;
      sum += 4.0 / (1.0 + x*x);
   }

   pi = sum * step;

   stop = clock();
   taken = ((double)(stop - start))/CLOCKS_PER_SEC;

   printf("Obtained value for PI: %.16g\n"
          "Time taken:            %.16g seconds\n", pi, taken);

   return 0;
}

