#include <time.h>
#include <sys/time.h>

double my_wtime_1() {
    return ((double)clock()) / CLOCKS_PER_SEC;
}

double my_wtime_() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (double)tv.tv_sec + (double)tv.tv_usec / 1000000.0;
}


