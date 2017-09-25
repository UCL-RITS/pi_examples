<?php
  $num_steps = 50000000;

  if (count($argv) > 1) {
    $num_steps = $argv[1];
  }

  echo "Calculating PI using:\n  $num_steps slices\n";

  $start = microtime(true);

  $s = 0.0;
  $step = 1.0/$num_steps;
  

  for ($i = 1; $i <= $num_steps; $i++) {
    $x = ($i - 0.5) * $step;
    $s = $s + 4.0/(1.0 + ($x * $x));
  }

  $mypi = $s * $step;

  $finish = microtime(true);
  $elapsed = $finish - $start;

  echo "Obtained value of PI: $mypi \n";
  echo "Time taken: $elapsed seconds\n";
?>
