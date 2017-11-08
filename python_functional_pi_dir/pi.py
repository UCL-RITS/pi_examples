def y(x):
    return 1.0/(1.0 + (x**2))

def calcpi(n, r):
    return (4.0/n) * sum(map(y, r))

# Use a generator to save memory (lists are huge!).
def gen_x(n):
    for i in range(n):
        yield (i + 0.5)/n

# In lieu of a main.
if __name__=='__main__':
    import sys
    import time

    num_steps = 5000000

    if len(sys.argv) > 1:
        num_steps = int(sys.argv[1])

    print('Calculating PI with:\n  ' + str(num_steps) + ' slices')
    start =  time.time()
    gen = gen_x(num_steps)
    p = calcpi(num_steps, gen)
    t = time.time() - start
    print('Obtained value of PI: ' + str(p))
    print('Time taken:           ' + str(t) + ' seconds')