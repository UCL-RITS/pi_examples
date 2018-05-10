# Common LISP implementation

This directory contains a common LISP implementation, tested against CLISP, GCL, ECL and SBCL.

## Running

To run with the "fastest" of those four implementations available on your system, run `run.sh <n>` for some number of slices, `n`.

E.g:

```none
$ ./run.sh 
Calculating PI using
  5000000 slices
  1 process
Obtained value of PI: 3.141592453589577d0
Time taken: 0.306 seconds
$
```

To run with a specific implementation, run:

| Implementation | Command                 |
|----------------|-------------------------|
| CLISP          | PI_ARG=\<n\> make clisp |
| SBCL           | PI_ARG=\<n\> make sbcl  |
| ECL            | PI_ARG=\<n\> make ecl   |
| GCL            | PI_ARG=\<n\> make gcl   |

E.g. for CLISP:

```none
$ PI_ARG=100000 make clisp
PI_ARG=100000 make -f Makefile.clisp run
make[1]: Entering directory '/home/uccaoke/Source/pi_examples/clisp_pi_dir'
clisp  -c pi.cl
  i i i i i i i       ooooo    o        ooooooo   ooooo   ooooo
  I I I I I I I      8     8   8           8     8     o  8    8
  I  \ `+' /  I      8         8           8     8        8    8
   \  `-+-'  /       8         8           8      ooooo   8oooo
    `-__|__-'        8         8           8           8  8
        |            8     o   8           8     o     8  8
  ------+------       ooooo    8oooooo  ooo8ooo   ooooo   8

Welcome to GNU CLISP 2.49 (2010-07-07) <http://clisp.cons.org/>

Copyright (c) Bruno Haible, Michael Stoll 1992, 1993
Copyright (c) Bruno Haible, Marcus Daniels 1994-1997
Copyright (c) Bruno Haible, Pierpaolo Bernardi, Sam Steingold 1998
Copyright (c) Bruno Haible, Sam Steingold 1999-2000
Copyright (c) Sam Steingold, Bruno Haible 2001-2010

Type :h and hit Enter for context help.

;; Compiling file /home/uccaoke/Source/pi_examples/clisp_pi_dir/pi.cl ...
;; Wrote file /home/uccaoke/Source/pi_examples/clisp_pi_dir/pi.fas
0 errors, 0 warnings
Bye.
Calculating PI using
  100000 slices
  1 process
Obtained value of PI: 3.1415826535731526d0
Time taken: 0.044071 seconds
make[1]: Leaving directory '/home/uccaoke/Source/pi_examples/clisp_pi_dir'
$
```

**NOTE:** Between running CLISP and ECL versions you should issue a `make clean` to remove the `pi.fas` for the old version as they are not compatible.

## Performance

The relative performance of the implementations was determined by running with the default 5M slices:

![Graph of measured performance](https://pbs.twimg.com/media/DIEVjR9WAAAVnuv.png)