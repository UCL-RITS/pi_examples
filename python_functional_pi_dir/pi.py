def y(x):
    return 1.0/(1.0 + (x**2))

def calcpi(n):
    return (4.0/n) * sum(map(y, [(x+0.5)/n for x in range(n)]))

if __name__=='__main__':
    import sys
    import time

    num_steps = 10000000

    if len(sys.argv) > 1:
        num_steps = int(sys.argv[1])

    print('Calculating PI with:\n  ' + str(num_steps) + ' slices')
    start =  time.time()
    p = calcpi(num_steps)
    t = time.time() - start
    print('Obtained value of PI: ' + str(p))
    print('Time taken:           ' + str(t) + ' seconds')