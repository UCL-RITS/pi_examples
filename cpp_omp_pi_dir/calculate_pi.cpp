#include <iostream>
#include <cstdlib>
#include <limits>
#include <omp.h>
#include "timer.hpp"

using namespace std;

int main( int argc, char **argv ) {
   long i, num_steps = 1000000000;
   int thread_count = omp_get_max_threads();

   cout.precision(numeric_limits<double>::digits10+2);
   
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }

   double step, x, sum, pi;
   Timer timer;
   
   cout << "Calculating PI using:" << endl <<
           "  " << num_steps << " slices" << endl <<
           "  1 process" << endl <<
           "  " << thread_count << " threads" << endl;
   
   timer.start();
   
   sum = 0.0;
   step = 1.0 / num_steps;

#pragma omp parallel for private(x) reduction(+:sum)
   for (i=0;i<num_steps;i++) {
      x    = (i + 0.5) * step;
      sum += 4.0 / (1.0 + x*x);
   }

   pi = sum * step;

   timer.stop();

   cout << "Obtained value for PI: " << pi << endl <<
           "Time taken: " << timer.duration() << " seconds" << endl;

   return 0;
}

