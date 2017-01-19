( Pi example in forth          )
( Developed/tested with GForth )
( Dr Owain Kenway              )

VARIABLE n           ( number of slices     )
VARIABLE totalsum    ( total sum of slices  )
VARIABLE step        ( size of slice        )
VARIABLE x           ( intermediate value 1 )
VARIABLE x2          ( intermediate value 2 )
VARIABLE mypi        ( estimate of pi       )
VARIABLE start       ( start time [us]      ) 
VARIABLE stop        ( finish time [us]     )
VARIABLE time        ( elapsed time [s]     )

: PICALC ( Calculates pi as per other examples ) 

( If there's a value at the top of the stack set that to n otherwise )
( set n to some default value. )
  depth 1 >= if 
    n ! 
  else 
    100000000  n ! 
  then

  0e totalsum f!
  1e n @ s>f f/ step f!

  ." Calculating PI using: " CR ."   " n @ . ." slices" CR

( Get current time in microseconds. )
  utime DROP start ! 

  n @ 0 DO      
    I s>f 0.5e f+ step f@ f* x f!           ( x = [i + 0.5] * step )
    x f@ FDUP f* 1e f+ x2 f!                ( x2 = x^2 + 1         )
    4e x2 f@ f/ totalsum f@ f+ totalsum f!  ( totalsum += 4/x2     )
  LOOP 

  totalsum f@ step f@ f* mypi f! 

( Get current time in microseconds. )
  utime DROP stop !
  stop @ s>f start @ s>f f- 1000000e f/ time f! 

  ." Obtained value of PI: " mypi f@ f. CR
  ." Time taken:  " time f@ f. ." seconds" CR
  ;

( Run PICALC word and then exit )
PICALC
BYE
