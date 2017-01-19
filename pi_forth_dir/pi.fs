( Pi example in forth          )
( Developed/tested with GForth )
( Dr Owain Kenway              )

VARIABLE n           ( number of slices     )
VARIABLE totalsum    ( total sum of slices  )
VARIABLE step        ( size of slice        )
VARIABLE x           ( intermediate value 1 )
VARIABLE x2          ( intermediate value 2 )
VARIABLE mypi        ( estimate of pi       )


: PICALC ( Calculates pi as per other examples ) 
  100000000 n !
  0e totalsum f!
  1e n @ s>f f/ step f!

  ." Calculating PI using: " n @ . ." slices" CR

  n @ 0 do      
    I s>f 0.5e f- step f@ f* x f!
    x f@ fdup f* 1e f+ x2 f! 
    4e x2 f@ f/ totalsum f@ f+ totalsum f!
  loop 

  totalsum f@ step F@ F*  mypi f! 

  ." Obtained value of PI: " mypi f@ f. CR
  ." No time date obtained " CR
  ;

( Run PICALC word and then exit )
PICALC
BYE
