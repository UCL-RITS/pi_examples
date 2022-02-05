package calcpi

class calc_thread(val n: Long,val begin: Long,val finish: Long) extends Runnable {

    var psum = 0.0d
    val step = 1d/n

    override def run() = {
        for (i <- begin to finish) {
            var x = (i - 0.5d) * step
            psum = psum + 4d/(1d + (x * x))
        } 
        
        psum = psum * step
    }
}

object pi {

    def estimate_pi(n: Long, threads: Int): Double = {

        var thread_array = Array.ofDim[Thread](threads)
        var calc_array = Array.ofDim[calc_thread](threads)
        val perthread = n/threads
        val leftover = n - (threads * perthread)

        for (i <- 1 to threads) {
           var begin = (i - 1) * perthread
           var finish = (i * perthread) - 1
           if (i == threads) {
               finish = finish + leftover
           }
           calc_array(i-1) = new calc_thread(n, begin, finish)
           thread_array(i-1) = new Thread(calc_array(i-1))
           thread_array(i-1).start()
        }

        var estimate = 0.0d
        for (i <- 1 to threads) {
           thread_array(i-1).join()
        }
        for (i <- 1 to threads) {
           estimate = estimate + calc_array(i-1).psum
        }
        estimate
        
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
        var threads = 1

        val major_version_arg_shift = two_or_three() - 2

        if (args.length > major_version_arg_shift) {
            n = args(major_version_arg_shift).toLong
        }

        // if 2: (2*major_version_arg_shift) + 1) == 1
        // if 3: (2*major_version_arg_shift) + 1) == 3
        if (args.length > (2*major_version_arg_shift) + 1) {
            threads = args(major_version_arg_shift + 1).toInt
        }

        println("Calculating PI using:")
        println("  " + n + " slices")
        println("  " + threads + " thread(s)")

        val start = System.currentTimeMillis();

        var mypi = estimate_pi(n, threads)
        
        val stop = System.currentTimeMillis();
        val difference = stop - start;
        val time = difference/1000.0d;
        
        println("Obtained value of PI: " + mypi);
        println("Time taken: " + time + " seconds");
    }
}
