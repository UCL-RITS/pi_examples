       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CalculatePi
       AUTHOR.  Ian Kirker.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Alternate Format:
      * 01 NumberOfSteps   PIC 9(18) VALUE 10000000.
       01 NumberOfSteps   USAGE IS BINARY-LONG UNSIGNED VALUE 10000000.
       01 StepNumber      USAGE IS BINARY-LONG UNSIGNED VALUE 0.
       01 TotalSum        USAGE IS FLOAT-LONG VALUE 0.
       01 Pi              USAGE IS FLOAT-LONG.
       01 StepSize        USAGE IS FLOAT-LONG.
       01 X               USAGE IS FLOAT-LONG.
       01 ThisSlice       USAGE IS FLOAT-LONG.



       PROCEDURE DIVISION.
       Begin.
           DISPLAY "Calculating PI with:"
           DISPLAY "  " NumberOfSteps " slices"
           DISPLAY "  1 process"
           COMPUTE StepSize ROUNDED = 1 / NumberOfSteps
           
           PERFORM VARYING StepNumber FROM 0 BY 1 
             UNTIL StepNumber >= NumberOfSteps 
             COMPUTE X ROUNDED = (StepNumber - 0.5) * StepSize
             COMPUTE ThisSlice ROUNDED = (4 / (1 + X*X))
             ADD ThisSlice to TotalSum
           END-PERFORM
           COMPUTE Pi ROUNDED = TotalSum * StepSize
           DISPLAY "Obtained value of Pi: " Pi
           DISPLAY "No time data obtained"
           STOP RUN.

