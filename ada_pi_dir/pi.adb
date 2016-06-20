with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Command_Line; use Ada.Command_line;

procedure Pi is
  n, i : Long_Integer;
  sum, x, slice, mp, rt : Long_Float; 
  start, stop : Time;

begin
  n:=1000000000;

-- Parsing arguments is relatively painless.
  if Argument_Count > 0 then
    n:=Long_Integer'Value(Argument(1));
  end if;

  Put_Line ("Calculating PI using:" & Long_Integer'Image(n) &  " slices");

  start:=Clock;

  sum:=0.0;
  slice:=1.0/Long_Float(n);

-- Doing loop this way because it's not clear how to use Long_Integer in a for
-- loop in Ada.
  i:=1;
  loop
    x:=(Long_Float(i) - 0.5)*slice;
    sum:=sum + (4.0/(1.0 + (x*x)));
    i:=i+1;
    exit when i>n;
  end loop;

  mp:=sum * slice;

  stop:=Clock;
  rt:=Long_Float(stop - start);

  Put_Line ("Obtained value of PI:" & Long_Float'Image(mp));
  Put_Line ("Time taken:" & Long_Float'Image(rt) & " seconds");
end Pi;
