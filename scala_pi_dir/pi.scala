package calcpi

object pi {

    def estimate_pi(n: Long): Double = {
        var psum = 0.0d;
        val step = 1d/n;

        // We can't loop over longs with for :(
        var i = 1L        
        while (i <= n) {
            var x = (i - 0.5d) * step
            psum = psum + 4d/(1d + (x * x))
            i = i + 1
        } 
        
        psum * step
        
    }

/*    
   Scala 3 is a menace.
   So it used to be (Scala 2.x) args would be just arguments, in order as 
   strings.

   so:

   scala calcpi.pi 10000 -> ["10000"]
   scala calcpi.pi       -> []

   In Scala 3(.1.1) for "reasons" the first argument is the name of the class 
   and each subsequent argument is /doubled/.

   so:

   scala calcpi.pi 10000     -> ["calcpi.pi","10000","10000"]
   scala calcpi.pi           -> ["calcpi.pi"]
   scala calcpi.pi 10000 red -> ["calcpi.pi","10000","red","10000","red"]

   As a bonus horror, Scala 3 reports its version as version 2.

Myriad [login12] scala_pi_dir :) > scala
Welcome to Scala 3.1.1 (17.0.2, Java OpenJDK 64-Bit Server VM).
Type in expressions for evaluation. Or try :help.
                                                                               
scala> util.Properties.versionString
val res0: String = version 2.13.6
                                                                               
scala> 

   This means our strategy has to be does this have the class for 
   dotty (Scala 3 compiler) properties?

*/
    def two_or_three(): Int = {
        if (util.Try(Class.forName("dotty.tools.dotc.config.Properties")).isSuccess) 3 else 2
    }

/*
   This is the portable way to do a main() between Scala 2 + 3 but not as 
   portable as sanity would demand.
 */
    def main(args: Array[String]) = {
        var n = 500000000L


        val major_version_arg_shift = two_or_three() - 2

        if (args.length > major_version_arg_shift) {
            n = args(major_version_arg_shift).toLong
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
