// This is the C# wrapper.  All this does is parse the command line 
// arguments and pass them to code.run().

// We need this almost entirely because of the "using System" line 
// which is required in C# to access the String class and quite hard to
// make do nothing in Java.

using System;

class Program {

    public static void Main(String[] argv) {
        long numsteps = 500000000;

        if (argv.Length > 0) {
            numsteps = Convert.ToInt64(argv[0]);
        }

        code.run(numsteps);

    }
}
