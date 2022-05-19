use Time;

config const slices = 10000000000;
config const numTasks = here.maxTaskPar;
config const debug = false;

writeln("Estimating PI with:");
writeln("  ", slices, " slices");
writeln("  ", numTasks, " tasks per locale");
writeln("  ", numLocales, " locales");

var t: Timer;
t.start();
var workers = numTasks * numLocales;

var slice = 1.0/slices;
var s = 0.0;

coforall loc in Locales with(+ reduce s) {
        on loc {
                coforall tid in 0..#numTasks with (+ reduce s) {
                        var shadowid = ((here.id * numTasks) + tid);
                        var rlower = shadowid * (slices / workers);
                        var rupper = (shadowid + 1) * (slices / workers);
                        if (shadowid == (workers - 1)) then rupper = slices - 1;
                        if (debug) then writeln("locale: ", here.id, " task: ", tid, " Shadow ID: ", shadowid, " Range: ", rlower, ":", rupper);

                        for i in rlower..rupper {
                                var x = (i - 0.5) * slice;
                                s = s + 4.0/(1.0 + (x*x));
                        }
                }
        }
}

var mypi = s * slice;
t.stop();

writeln("Obtained value of PI: ", mypi);
writeln("Time taken: ", t.elapsed(), " seconds");
