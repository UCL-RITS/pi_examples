#include "mpi.h"
#include <stdio.h>
#include <math.h>

int main( int argc, char **argv ) {
  const long int num_steps = 1000000000;
  double step, x, sum, total_sum, pi, start, stop, min_start, max_stop;
  int this_proc, num_procs, remainder;
  long int my_slice[2];
  int i;

  MPI_Init(&argc,&argv);
  MPI_Comm_size(MPI_COMM_WORLD,&num_procs);
  MPI_Comm_rank(MPI_COMM_WORLD,&this_proc);
  
  if (this_proc == 0){
    printf("Calculating PI using %d processes...\n", num_procs);
  }
  MPI_Barrier(MPI_COMM_WORLD);

  start = MPI_Wtime();
  sum = 0.0;
  step = (double) 1 / num_steps;

  my_slice[0] = this_proc * num_steps / num_procs;
  my_slice[1] = (this_proc + 1) * num_steps / num_procs - 1;

  /*
  remainder = num_steps % num_procs;
  
  if (this_proc < remainder) {
    my_slice[0] += this_proc;
    my_slice[1] += this_proc + 1;
  }
  */
  printf("Proc %d says hello, is going to calculate slice %ld-%ld\n", this_proc, my_slice[0], my_slice[1]);
  for(i=my_slice[0]; i<my_slice[1];i++) {
    x = (i - 0.5) * step;
    sum += (double) 4 / (1 + x*x);
  }

  MPI_Reduce(&sum, &total_sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

  pi = total_sum * step;
  stop = MPI_Wtime();

  MPI_Barrier(MPI_COMM_WORLD);

  MPI_Reduce(&start, &min_start, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);
  MPI_Reduce(&stop,  &max_stop,  1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

  if (this_proc == 0) {
    printf("The value of PI is %.15g\n", pi);
    printf("The time to calculate PI was %g seconds\n", max_stop - min_start);
  }

  MPI_Finalize();

  return 0;
}


