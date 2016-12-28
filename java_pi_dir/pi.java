public class pi {
    public static void main(String[] argc) {
        long i, numsteps, start, stop, difference;
        double step, x, psum, mypi, time;

        numsteps = 500000000;

        if (argc.length > 0) {            
            numsteps = Integer.parseInt(argc[0]);
        }
        
        System.out.println("Calculating PI using:");
        System.out.println("  " + numsteps + " slices");
        System.out.println("  1 processes");

        start = System.currentTimeMillis();

        psum = 0.0d;
        step = 1d/(double)numsteps;
        
        for (i = 0; i < numsteps; i++) {
            x = ((double)i + 0.5d) * step;
            psum = psum + 4d/(1d + (x * x));
        } 
        
        mypi = psum * step;
        
        stop = System.currentTimeMillis();
        difference = stop - start;
        time = (double)(difference)/1000d;
        
        System.out.println("Obtained value of PI: " + mypi);
        System.out.println("Time taken: " + time + " seconds");

    }
}