; Pi example in GDL/IDL
; Owain Kenway

; Work out the number of slices from the command-line.
n = 50000000
args = command_line_args()

; Annoyingly size of args is always 1.  If arg[0] is "" it's empty.
if (args[0] ne "") then n = args[0]

; Call calcpi procedure with our determined number of slices.
; Keeping as a separate procedure so that it is compiled.
calcpi, n

; End of program
exit
