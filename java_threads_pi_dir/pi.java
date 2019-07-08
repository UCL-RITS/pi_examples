public class pi {
    public static void main(String[] argc) {
        long numsteps, start, stop, difference;
        double step, x, psum, mypi, time;
	int threads;
	Thread[] t;

	threads = 1;
	mypi = 0d;
        numsteps = 500000000;

        if (argc.length > 0) {            
            numsteps = Integer.parseInt(argc[0]);
        }

        if (argc.length > 1) {            
            threads = Integer.parseInt(argc[1]);
        }
        
        System.out.println("Calculating PI using:");
        System.out.println("  " + numsteps + " slices");
        System.out.println("  " + threads + " threads");

        start = System.currentTimeMillis();

	calcpi[] calcs = new calcpi[threads];
	t = new Thread[threads];

	// Decomposition - simple - at most threads - 1 iterations imbalance.
	long perthread = numsteps/threads;
	long leftover = numsteps - (threads * perthread);

	for (int i = 0; i < threads; i++) {
		long lmin = i*perthread;
		long lmax = ((i+1) * perthread) -1;
		if (i == (threads - 1)) {
			lmax = lmax + leftover;
		}
		calcs[i] = new calcpi(lmin, lmax, numsteps);
		// calcs[i].setDebug();
		t[i] = new Thread(calcs[i], "thread: " + i);
		t[i].start();

	}

	for (int i = 0; i < threads; i++) {
		try {
			t[i].join();
		} catch (Exception e) {
			System.out.println("oh no");
		}
	}
	for (int i = 0; i < threads; i++) {
		mypi = mypi + calcs[i].getAnswer();
	}

        
        stop = System.currentTimeMillis();
        difference = stop - start;
        time = (double)(difference)/1000d;
        
        System.out.println("Obtained value of PI: " + mypi);
        System.out.println("Time taken: " + time + " seconds");

    }
}
