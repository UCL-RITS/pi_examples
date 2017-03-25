; Here we do the main work of the Pi example
pro calcpi, n
  print, "Calculating Pi using:"
  print, n, format='("                     ", 1I16, " slices")'

; Get UNIX time in seconds (float)
  start = systime(/seconds)

  s = 0.0d
  step = 1.0d/n

  for i = 1, n do begin
    x = (i - 0.5d) * step
    s = s + 4.0d/(1.0d + (x*x))
  endfor

; Get UNIX time in seconds (float)
  finish = systime(/seconds)

  mypi = s * step
  time = finish - start
  print, mypi, format='("Obtained value of PI:    ",1F12.10)'
  print, time, format='("Time taken:              ", 1F12.5, " seconds")'
end
