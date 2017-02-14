function calcpi(n) {
    console.log("Calculating Pi using:\n  ", n, "slices");

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

    console.log("Obtained value of PI: ", mypi);
    console.log("Time taken: ", t, " seconds")

    return(mypi);
}

// This allows node.js to see our function.
module.exports = {
    calcpi: function(n) {
        calcpi(n);
    }
}