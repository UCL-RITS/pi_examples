% change number of steps by setting n before running.

if exist('n', 'var') == 0
  n = 1000000000;
end

nt = maxNumCompThreads;

disp(sprintf('Calculating PI with:\n  %d slices', n));
disp(sprintf('  %d thread(s)', nt));

total_sum = 0.0;
step = 1.0/n;

start = tic;

for i = 1:n
  x = (i - 0.5) * step;
  total_sum = total_sum + (4.0/(1.0 + (x * x)));
end

p = total_sum * step;

stop = toc(start);

disp(sprintf('Obtained value of PI: %g', p));
disp(sprintf('Time taken: %g seconds', stop));
