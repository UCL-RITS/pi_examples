% This version uses arrays rather than loops.
% This is memory expensive but amenable to the GPU tools in MATLAB.

% change number of steps by setting n before running.

if exist('n', 'var') == 0
  n = 1000;
end

D = gpuDevice;
nt = D.Name;

disp(sprintf('Calculating PI with:\n  %d slices', n));
disp(sprintf('  GPU: %s', nt));

alloc = tic;
l = ones([1,n],'gpuArray');
i = gpuArray(0:1:n-1);
stopalloc = toc(alloc);

start = tic;

s = (4* l)./(l + (((i + 0.5)./n).^2));
p = sum(s)/n;

stop = toc(start);

disp(sprintf('Obtained value of PI: %g', p));
disp(sprintf('Allocation time taken: %g seconds', stopalloc));
disp(sprintf('Loop time taken: %g seconds', stop));
disp(sprintf('Total time taken: %g seconds', stop + stopalloc));
