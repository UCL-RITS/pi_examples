/*
 * This Wrapper pulls arguments in the node.js environment and passes them to calcpi.
 * Owain Kenway
 */
const pc = require('./pi.js');

// Get command-line arguments.
if (process.argv.length > 2) {
    var n = parseInt(process.argv[2]);
} else {
    var n = 10000000;
}

pc.calcpi(n);
