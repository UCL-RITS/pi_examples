class pi {

    public static void main(String[] argv) {
        long i, start, stop, difference;
        double step, x, psum, mypi, time;

        long numsteps = 500000000;

        if (argv.length > 0) {
            numsteps = Integer.parseInt(argv[0]);
        }

        println("Calculating PI using:");
        println("  " + numsteps + " slices");
        println("  1 processes");

        start = (long)System.currentTimeMillis();

        psum = 0.0d;
        step = 1d/(double)numsteps;
        
        for (i = 0; i < numsteps; i++) {
            x = ((double)i + 0.5d) * step;
            psum = psum + 4d/(1d + (x * x));
        } 
        
        mypi = psum * step;
        
        stop = (long)System.currentTimeMillis();
        difference = stop - start;
        time = (double)(difference)/1000d;
        
        println("Obtained value of PI: " + mypi);
        println("Time taken: " + time + " seconds");

    }
}
