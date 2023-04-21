#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#include <pthread.h>

typedef struct chunk {
	long num_steps;
	int num_threads;
	int thread_num;
	double value;
} chunk;

int DEBUG = 0;

void* piThread(void *arg) {
	chunk *mydata = (chunk *)arg;
	double x;
	long i;
	long num_steps = mydata->num_steps;
	int num_threads = mydata->num_threads;
	int thread_num = mydata->thread_num;
	double local_sum = 0.0;	
	double step = 1.0 / num_steps;

	long lower = thread_num * (num_steps/num_threads);
	long upper = (thread_num + 1) * (num_steps/num_threads);

	if (thread_num == (num_threads - 1)) {
		upper = num_steps;
	}

	if (DEBUG) {
		fprintf(stderr, ">>> DEBUG: %i : %ld -> %ld\n", thread_num, lower, upper);
	}

	for (i=lower;i<upper;i++) {
		x = (i + 0.5) *	step;
		local_sum += 4.0/(1.0 + x*x);
	}

	mydata->value=local_sum;
	pthread_exit(NULL);
}

int main(int argc, char **argv) {
	long num_steps = 1000000000;
	int num_threads = 1;
	double sum, pi, taken, step;
	struct timeval start, stop;
	int i;
	const char* OMP_NUM_THREADS = getenv("OMP_NUM_THREADS");
	const char* PI_DEBUG = getenv("PI_DEBUG");

	if (OMP_NUM_THREADS!=NULL) {
		num_threads = atoi(OMP_NUM_THREADS);
	}

	if (PI_DEBUG!=NULL) {
		DEBUG = atoi(PI_DEBUG);
	}

	if (argc > 1) {
		num_steps = atol(argv[1]);
	}

	if (argc > 2) {
		num_threads = atoi(argv[2]);
	}

	printf("Calculating PI using:\n"
	       "  %ld slices\n"
	       "  %i threads\n", num_steps, num_threads);

	gettimeofday(&start, NULL);

	pthread_t threads[num_threads];	
	chunk chunks[num_threads];
	sum = 0.0;
	step = 1.0/num_steps;
	for (i = 0; i < num_threads; i++) {
		chunks[i].num_steps = num_steps;
		chunks[i].num_threads = num_threads;
		chunks[i].thread_num = i;
		pthread_create(&threads[i], NULL, piThread, (void *)&chunks[i]);
	} 

	for (i = 0; i < num_threads; i++) {
		pthread_join(threads[i], NULL);
		sum += chunks[i].value;
	} 
	
	pi = sum * step;
	gettimeofday(&stop, NULL);
	
	taken = ((double)(stop.tv_sec - start.tv_sec) + ((double)(stop.tv_usec - start.tv_usec))/(1000000.0));
	printf("Obtained value for PI: %.16g\n"
	       "Time taken:            %.16g seconds\n", pi, taken);

	return 0;
}

