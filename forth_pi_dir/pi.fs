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
  100000000 n !
  0e totalsum f!
  1e n @ s>f f/ step f!

  ." Calculating PI using: " CR ."   " n @ . ." slices" CR

  utime drop start ! 

  n @ 0 do      
    I s>f 0.5e f- step f@ f* x f!
    x f@ fdup f* 1e f+ x2 f! 
    4e x2 f@ f/ totalsum f@ f+ totalsum f!
  loop 

  totalsum f@ step F@ F*  mypi f! 

  utime drop stop !
  stop @ s>f start @ s>f f- 1000000e f/ time f! 

  ." Obtained value of PI: " mypi f@ f. CR
  ." Time taken:  " time f@ f. ." seconds" CR
  ;

( Run PICALC word and then exit )
PICALC
BYE
