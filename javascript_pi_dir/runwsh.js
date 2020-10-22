function calcpi(n) {
  WScript.echo("Calculating Pi using:\n  ", n, "slices");

  var start = new Date().getTime();

  var psum = 0.0;
  var step = 1.0/n;

  for (var i = 0; i < n; i++) {
    var x = (i + 0.5) * step;
    psum = psum + (4/(1 + (x*x)));
  }

  var mypi = psum * step;

  var stop = new Date().getTime();
  var t = (stop - start)/1000.0;

  WScript.echo("Obtained value of PI: ", mypi);
  WScript.echo("Time taken: ", t, " seconds");
}

var n = 100000000;
if (WScript.arguments.length > 0) {
  n = parseInt(WScript.arguments(0));
}
calcpi(n);
