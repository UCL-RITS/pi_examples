" 
  Implementation of the Pi example in Smalltalk.
  Targetted at GNU Smalltalk.

  With the exception of the argument parsing code, also works in Squeak.

  Invoke with:

    gst -g pi.st -a <n>

  (for some <n>)

  Dr Owain Kenway
"

| n totalsum step x mypi start stop time |

n := 1000000. 

" 
  This is GNU Smalltalk specific - not sure there's any concept of command
  line arguments in Squeak.
"
(Smalltalk version startsWith: 'GNU') 
   ifTrue: [
      (Smalltalk arguments size > 0) 
         ifTrue: [ n := (Smalltalk arguments at: 1) asInteger ].
   ].

Transcript show: 'Calculating PI using'; cr.
Transcript show: '  '; show: (n asString); show: ' slices'; cr.

start := Time millisecondClockValue.

totalsum := 0.0.
step := 1/n.

1 to: n do: [:i | 
  x := (i - 0.5) * step.
  totalsum := totalsum + (4.0/(1.0 + (x*x))). 
]. 

mypi := totalsum * step.

stop := Time millisecondClockValue.
time := (stop - start)/1000.0.

Transcript show: 'Obtained value of PI: '; show: (mypi asString); cr.
Transcript show: 'Time taken: '; show: (time asString); show: ' seconds'; cr.
