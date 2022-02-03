package calcpi

object pi extends App {
    var n = 500000000

    if (args.length == 1) {
        n = Integer.parseInt(args(0))
    }

    println("Calculating PI using:")
    println("  " + n + " slices")
    println("  1 processes")

    val start = System.currentTimeMillis();

    var psum = 0.0d;
    val step = 1d/n;
        
    for (i <-  1 to n) {
        var x = (i - 0.5d) * step
        psum = psum + 4d/(1d + (x * x))
    } 
        
    var mypi = psum * step;
        
    val stop = System.currentTimeMillis();
    val difference = stop - start;
    val time = difference/1000.0d;
        
    println("Obtained value of PI: " + mypi);
    println("Time taken: " + time + " seconds");
}
