import std.stdio, std.datetime, std.conv;

void main(string[] args) {
  long i, num_steps = 1000000000;
  double step, x, sum, pi, start, stop;
  double finish;
  StopWatch sw;

  if (args.length > 1) {
    num_steps = to!long(args[1]);
  }

  writeln("Calculating PI using:");
  writeln("  ", num_steps, " slices");
  writeln("  1 process");

  sw.start();
 
  sum = 0.0;
  step = 1.0/num_steps;
  
  for (i=0; i<num_steps; i++) {
    x = (i + 0.5) * step;
    sum += 4.0/(1.0 + (x*x));
  }

  pi = sum * step;
 
  finish = (sw.peek().msecs/1000.0);

  writeln("Obtained value for PI: ", pi);
  writeln("Time taken: ", finish, " seconds");
}
