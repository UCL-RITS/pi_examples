#!/usr/bin/env perl6

sub calcpi( UInt $n --> Num ) {
   my Num $total_sum = 0e0;
   my Num $step = 1e0/$n;

   loop (my $i = 0; $i < $n; $i++) {
      my Num $x = ($i + 0e5) * $step;
      $total_sum += 4e0 / (1e0 + ($x * $x));
   }

   return $total_sum * $step;
}

sub MAIN (UInt $n = 10000000) {
   say "Calculating PI with \n  $n slices\n  1 process";
  
   my DateTime $start = DateTime.now;  
   my Num $mypi = calcpi($n);
   my $duration = DateTime.now - $start;

   say "Obtained value of PI: $mypi";
   say "Time taken: $duration seconds";
}
