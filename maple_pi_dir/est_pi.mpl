est_pi := proc(num_steps::integer)
   local step, s, x, mypi, i, start_time, stop_time:
   printf("  Estimating Pi using: %1d slices\n", num_steps):
   start_time := time[real]():
   step := 1.0/num_steps:
   s:=0:
   for i from 1 to num_steps do 
      x:=(i-0.5)*step: 
      s:=s+(4.0/(1.0 + x*x)):  
   end do:
   mypi:=s*step:
   stop_time := time[real]():
   printf("Estimated value of Pi: %.16g\n", mypi):
   printf("      Elapsed time(s): %.16g\n", stop_time - start_time):
   printf("  Observed difference: %.16g\n", abs(Pi - mypi)):
   mypi;
end proc:

native_est_pi := proc(num_steps::integer)
   local step, mypi, k, start_time, stop_time:
   printf("  Estimating Pi using: %1d slices\n", num_steps):
   start_time := time[real]():
   mypi:=Re(sum((4/(1+(((k-0.5)/num_steps)^2))),k=1..num_steps)/num_steps):
   stop_time := time[real]():
   printf("Estimated value of Pi: %.16g\n", mypi):
   printf("      Elapsed time(s): %.16g\n", stop_time - start_time):
   printf("  Observed difference: %.16g\n", abs(Pi - mypi)):
   mypi;   
end proc: