#include <iostream>
#include <cstdlib>
#include <limits>

#include <cuda.h>

#include "timer.hpp"

using namespace std;

__global__ void calcpi(int threads, int n, double *results) {
   int rank = threadIdx.x;
   results[rank] = 0.0;
   double step = 1.0/n;
   double x = 0.0;

   int lower = rank * n/threads;
   int upper = (rank + 1) * n/threads;

   for (long i = lower; i < upper; i++) {
      x    = (i + 0.5) * step;
      results[rank] += 4.0 / (1.0 + x*x);
   }
}

int main( int argc, char **argv ) {
   long num_steps = 100000;
   double result;
   int threads = 100; // threads needs to dived num_steps!

   cout.precision(numeric_limits<double>::digits10+2);
   
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }
   if (argc > 2) {
      threads = atol(argv[2]);
   }

   double step, pi;
   Timer timer;
   
   cout << "Calculating PI using:" << endl <<
           "  " << num_steps << " slices" << endl <<
           "  " << threads << " CUDA threads" << endl;
   
   timer.start();
   
   double *sum, *d_sum;
   size_t size = threads*sizeof(double);
   step = 1.0 / num_steps;
   sum = (double*)malloc(size);

   cudaMalloc((void**)&d_sum, size);
   calcpi<<<1,threads>>>(threads, num_steps, d_sum);
   cudaMemcpy(sum, d_sum, size, cudaMemcpyDeviceToHost);
   cudaFree(d_sum);

   result = 0.0;

   for (int i=0; i<threads; i++) {
      result +=sum[i];
   }
   pi = result * step;

   timer.stop();

   cout << "Obtained value for PI: " << pi << endl <<
           "Time taken: " << timer.duration() << " seconds" << endl;

   return 0;
}

