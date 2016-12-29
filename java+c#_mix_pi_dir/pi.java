// This is the Java wrapper.  All this does is parse the command line 
// arguments and pass them to code.run().

// We need this almost entirely because of the "using System" line 
// which is required in C# to access the String class and quite hard to
// make do nothing in Java.

class pi {

    public static void main(String[] argv) {
        long numsteps = 500000000;

        if (argv.length > 0) {
            numsteps = Integer.parseInt(argv[0]);
        }

        code.run(numsteps);

    }
}
