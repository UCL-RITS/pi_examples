package calcpi

object pi {

    def estimate_pi(n: Int): Double = {
        var psum = 0.0d;
        val step = 1d/n;
        
        for (i <-  1 to n) {
            var x = (i - 0.5d) * step
            psum = psum + 4d/(1d + (x * x))
        } 
        
        psum * step
        
    }

    def main(args: Array[String]) = {
        var n = 500000000

        if (args.length >= 1) {
            n = Integer.parseInt(args(args.length-1))
        }

        println("Calculating PI using:")
        println("  " + n + " slices")
        println("  1 processes")

        val start = System.currentTimeMillis();

        
        var mypi = estimate_pi(n)
        
        val stop = System.currentTimeMillis();
        val difference = stop - start;
        val time = difference/1000.0d;
        
        println("Obtained value of PI: " + mypi);
        println("Time taken: " + time + " seconds");
  }
}
