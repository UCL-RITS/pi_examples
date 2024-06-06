#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>

#include "zdnn.h"

int main( int argc, char **argv ) {
   long i, total_steps;
   int num_steps = 1;
   int num_steps_ = 150;
   int num_steps__ = 1000;
   int num_steps___ = 1000;
   double step, x, sum, pi, taken, setup, teardown, computation;
   clock_t start, stop, setup_chkpt, teardown_chkpt;  

   zdnn_tensor_desc pre_tfrmd_desc, tfrmd_desc;

   zdnn_ztensor range_t, x_t, sum_t, four_t, one_t, step_t;
   zdnn_status status;

   zdnn_data_types type = FP32;
   short element_size = 4; 

#ifdef STATIC_LIB
   zdnn_init();
#endif
 
   if (argc > 1) {
      num_steps = atol(argv[1]);
   }
   if (argc > 2) {
      num_steps_ = atol(argv[2]);
   }
   if (argc > 3) {
      num_steps__ = atol(argv[3]);
   }
   if (argc > 4) {
      num_steps___ = atol(argv[4]);
   }

   total_steps = (long)num_steps * (long)num_steps_ * (long)num_steps__ * (long)num_steps___;
   
   printf("Calculating PI using:\n"
          "  %ld slices (%d x %d x %d x %d) \n"
          "  1 process\n", total_steps, num_steps, num_steps_, num_steps__, num_steps___);
   
   start = clock();
   
   void *range_m = malloc(total_steps * element_size);
   void *x_m = malloc(total_steps * element_size);
   void *sum_m = malloc(total_steps * element_size);
   void *four_m = malloc(total_steps * element_size);
   void *one_m = malloc(total_steps * element_size);
   void *step_m = malloc(total_steps * element_size);

   sum = 0.0;
   step = 1.0 / total_steps;

   for (i=0;i<total_steps;i++) {
     ((float *)range_m)[i] = (float)(i + 0.5);
     ((float *)x_m)[i] = (float)(i + 0.5);
     ((float *)four_m)[i] = (float)(4.0);
     ((float *)one_m)[i] = (float)(1.0);
     ((float *)step_m)[i] = (float)(step);

   }

   zdnn_init_pre_transformed_desc(ZDNN_NHWC, type, &pre_tfrmd_desc, num_steps, num_steps_, num_steps__, num_steps___);

   status = zdnn_generate_transformed_desc(&pre_tfrmd_desc, &tfrmd_desc);

   status = zdnn_init_ztensor_with_malloc(&pre_tfrmd_desc, &tfrmd_desc, &range_t);
   status = zdnn_init_ztensor_with_malloc(&pre_tfrmd_desc, &tfrmd_desc, &x_t);
   status = zdnn_init_ztensor_with_malloc(&pre_tfrmd_desc, &tfrmd_desc, &sum_t); 
   status = zdnn_init_ztensor_with_malloc(&pre_tfrmd_desc, &tfrmd_desc, &four_t);
   status = zdnn_init_ztensor_with_malloc(&pre_tfrmd_desc, &tfrmd_desc, &one_t);
   status = zdnn_init_ztensor_with_malloc(&pre_tfrmd_desc, &tfrmd_desc, &step_t); 

   status = zdnn_transform_ztensor(&range_t, range_m);
   status = zdnn_transform_ztensor(&x_t, x_m);
   status = zdnn_transform_ztensor(&one_t, one_m);
   status = zdnn_transform_ztensor(&four_t, four_m);
   status = zdnn_transform_ztensor(&step_t, step_m);

   setup_chkpt = clock();

   status = zdnn_mul(&step_t, &range_t, &x_t);
   status = zdnn_mul(&x_t, &x_t, &x_t);

   status = zdnn_add(&one_t, &x_t, &range_t);
   status = zdnn_div(&four_t, &range_t, &sum_t);

   assert(status == ZDNN_OK);

   status = zdnn_transform_origtensor(&sum_t, sum_m);

   for (i=0;i<total_steps;i++){
     sum = sum + ((float *)sum_m)[i];
   }

   pi = sum * step;

   teardown_chkpt = clock();

   status = zdnn_free_ztensor_buffer(&range_t);
   status = zdnn_free_ztensor_buffer(&x_t);
   status = zdnn_free_ztensor_buffer(&sum_t);
   status = zdnn_free_ztensor_buffer(&one_t);
   status = zdnn_free_ztensor_buffer(&four_t);
   status = zdnn_free_ztensor_buffer(&step_t);

   free(range_m);
   free(x_m);
   free(sum_m);
   free(one_m);
   free(four_m);
   free(step_m);

   stop = clock();
   taken = ((double)(stop - start))/CLOCKS_PER_SEC;
   setup = ((double)(setup_chkpt - start))/CLOCKS_PER_SEC;
   computation = ((double)(teardown_chkpt - setup_chkpt))/CLOCKS_PER_SEC;
   teardown = ((double)(stop - teardown_chkpt))/CLOCKS_PER_SEC;

   printf("Obtained value for PI: %.16g\n"
          "Time taken:            %.16g seconds\n", pi, taken);
   printf("Time breakdown: \n"
          "Setup:                 %.16g seconds\n"
          "Computation:           %.16g seconds\n"
          "Teardown:              %.16g seconds\n", setup, computation, teardown);

   return 0;
}
