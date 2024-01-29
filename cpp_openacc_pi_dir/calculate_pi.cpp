#include <iostream>
#include <cstdlib>
#include <limits>
#include <chrono>

using namespace std;
using namespace std::chrono;

int main( int argc, char **argv ) {
   long i, num_steps = 1000000000;

   cout.precision(numeric_limits<double>::digits10+2);
   
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }

   double step, x, sum, pi;
   
   cout << "Calculating PI using:" << endl <<
           "  " << num_steps << " slices" << endl <<
           "  1 process" << endl;
   
   auto start = high_resolution_clock::now();
   
   sum = 0.0;
   step = 1.0 / num_steps;

#pragma acc kernels
   for (i=0;i<num_steps;i++) {
      x    = (i + 0.5) * step;
      sum += 4.0 / (1.0 + x*x);
   }

   pi = sum * step;

   auto stop = high_resolution_clock::now();
   auto duration_s = duration<double>(stop - start).count();

   cout << "Obtained value for PI: " << pi << endl <<
           "Time taken: " << duration_s << " seconds" << endl;

   return 0;
}

