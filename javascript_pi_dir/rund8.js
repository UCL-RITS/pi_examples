/* 
 * Wrapper for running in d8.
 * Owain Kenway
 *
 * We need to define console.log because d8 lacks this.
 */
class console {
   static log() {
      var message = "";

// add all arguments to the function into a string.
      for (var i = 0; i < arguments.length; i++) {
         message = message.concat(arguments[i]);

// add a space onto numbers (to replicate console.log behavior).
         if (typeof(arguments[i]) != "string") {
            message = message.concat(" ");
         }
      }

// print the message.
      print(message);
   }
}

// Stop node.js module.exports breaking stuff.
class module {}

// load our pi code.
load('pi.js');

// if there are any arguments, run calcpi with the first one, otherwise default.
if (arguments.length > 0) {
   var n = parseInt(arguments[0]);
   calcpi(n);
} else {
   calcpi(10000000);
}
