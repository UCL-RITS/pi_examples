Program pi(output);

Uses sysutils;

{ Use am Int64 for numsteps because we want to use big numbers of steps. }
Var 
  step, x, sum, mypi, time, start, stop : Double;
  i, numsteps : Int64;

Begin
 
  numsteps := 1000000000;

{ Get numsteps from command line args. }
  if ParamCount > 0 then
    numsteps := StrToInt64(ParamStr(1));

  Writeln('Calculating PI using:');
  Writeln('  ', numsteps, ' slices');

{ Initialise time counter and sum. Set step size. }
  start := TimeStampToMSecs(DateTimeToTimeStamp(Now)); 

  sum := 0.0;
  step := 1.0/Double(numsteps);

  For i := 1 To numsteps Do
  
  Begin
    x := (Double(i) - 0.5) * step;
    sum := sum + 4.0/(1.0 + x*x);
  End;
  
{ Calculate pi from final value and stop clock. }
  mypi := sum * step;
  stop := TimeStampToMSecs(DateTimeToTimeStamp(Now)); 

{ Note: Highest resolution of this method is milliseconds.}
  time := (stop - start)/1000;

  Writeln('Obtained value of PI: ', FloatToStrf(mypi, fffixed, 2, 8));
  Writeln('Time taken: ', FloatToStrf(time, fffixed, 4, 4), ' seconds');

End.
