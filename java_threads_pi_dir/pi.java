public class pi {
    public static void main(String[] argc) {
        long numsteps, start, stop, difference;
        double step, x, psum, mypi, time;
	int threads;
	Thread[] t;

	threads = 1;
        numsteps = 500000000;

        if (argc.length > 0) {            
            numsteps = Long.parseLong(argc[0]);
        }

        if (argc.length > 1) {            
            threads = Integer.parseInt(argc[1]);
        }
        
        System.out.println("Calculating PI using:");
        System.out.println("  " + numsteps + " slices");
        System.out.println("  " + threads + " threads");

        start = System.currentTimeMillis();

	mypi = calcpi.calc(numsteps, threads);
        
        stop = System.currentTimeMillis();
        difference = stop - start;
        time = (double)(difference)/1000d;
        
        System.out.println("Obtained value of PI: " + mypi);
        System.out.println("Time taken: " + time + " seconds");

    }
}
