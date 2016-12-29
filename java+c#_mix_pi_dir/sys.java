// This library provides wrappers to the methods we need from the .Net 
// library allowing us to make the same calls in code.mixed in both C#
// and in Java.  In this case we only need two - print a line, and get
// the current time in milliseconds.

public class sys {

    public static void println(String text) {
        System.out.println(text);
    }

    public static long time() {
        return (long)System.currentTimeMillis();
    }

}