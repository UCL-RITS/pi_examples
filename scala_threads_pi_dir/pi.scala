package calcpi

class calc_thread(val n: Long,val begin: Long,val finish: Long) extends Runnable {

    var psum = 0.0d
    val step = 1d/n

    override def run() = {
        // We can't loop over longs with for :(
        var i = begin
        while (i <= finish) {
            var x = (i - 0.5d) * step
            psum = psum + 4d/(1d + (x * x))
            i = i + 1
        } 
        
        psum = psum * step
    }
}

object pi {

    def estimate_pi(n: Long, threads: Int, debug: Boolean): Double = {

        var thread_array = Array.ofDim[Thread](threads)
        var calc_array = Array.ofDim[calc_thread](threads)
        val perthread = n/threads
        val leftover = n - (threads * perthread)

        for (i <- 0 to (threads - 1)) {
           var begin = i * perthread
           var finish = ((i + 1) * perthread) - 1
           if (i == (threads - 1)) {
               finish = finish + leftover
           }
           if (debug) println("Thread " + i + ": Start: " + begin + " Finish: " + finish)
           calc_array(i) = new calc_thread(n, begin, finish)
           thread_array(i) = new Thread(calc_array(i))
           thread_array(i).start()
        }

        var estimate = 0.0d
        for (i <- 0 to (threads - 1)) {
           thread_array(i).join()
        }
        for (i <- 0 to (threads - 1)) {
           estimate = estimate + calc_array(i).psum
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
        var debug = false

        val major_version_arg_shift = two_or_three() - 2

        if (args.length > major_version_arg_shift) {
            n = args(major_version_arg_shift).toLong
        }

        // if 2: (2*major_version_arg_shift) + 1) == 1
        // if 3: (2*major_version_arg_shift) + 1) == 3
        if (args.length > (2*major_version_arg_shift) + 1) {
            threads = args(major_version_arg_shift + 1).toInt
        }

        // if 2: (3*major_version_arg_shift) + 2) == 2
        // if 3: (3*major_version_arg_shift) + 2) == 5
        if (args.length > (3*major_version_arg_shift) + 2) {
            debug = args(major_version_arg_shift + 2).toBoolean
        }

        println("Calculating PI using:")
        println("  " + n + " slices")
        println("  " + threads + " thread(s)")

        val start = System.currentTimeMillis();

        var mypi = estimate_pi(n, threads, debug)
        
        val stop = System.currentTimeMillis();
        val difference = stop - start;
        val time = difference/1000.0d;
        
        println("Obtained value of PI: " + mypi);
        println("Time taken: " + time + " seconds");
    }
}
