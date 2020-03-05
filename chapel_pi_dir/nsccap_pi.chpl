/* 
   Example provided by Peter Kjellström (@nsccap on Twitter): 

   https://twitter.com/nsccap/status/1233424385471664128
*/

config const N = 1000000;
var pi = sqrt(6.0 * (+ reduce [ i in 1..N by - 1 ] 1.0/(i*i) ));
writeln(pi);

