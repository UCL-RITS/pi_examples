#include <iostream>
#include <cstdlib>
#include <limits>
#include "timer.hpp"

#include <functional>

#include <tbb/parallel_for.h>
#include <tbb/parallel_reduce.h>
#include <tbb/task_scheduler_init.h>

using namespace std;

int main( int argc, char **argv ) {
   long i, num_steps = 1000000000;
   int thread_count = tbb::task_scheduler_init::default_num_threads();

   cout.precision(numeric_limits<double>::digits10+2);
   
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }

   double step, pi;
   Timer timer;
   
   cout << "Calculating PI using:" << endl <<
           "  " << num_steps << " slices" << endl <<
           "  1 process" << endl <<
           "  " << thread_count << " threads" << endl;
   
   timer.start();
   
   step = 1.0 / num_steps;

   double sum = tbb::parallel_reduce(
      tbb::blocked_range<long>(0, num_steps),
      0.0,
      [=](tbb::blocked_range<long> j, double chunk) {
         for (i=0;i<num_steps;i++) {
            chunk += 4.0 / (1.0 + ((i + 0.5) * step)*((i + 0.5) * step));
         }
         return chunk;
      }, std::plus<double>());

   pi = sum * step;

   timer.stop();

   cout << "Obtained value for PI: " << pi << endl <<
           "Time taken: " << timer.duration() << " seconds" << endl;

   return 0;
}

