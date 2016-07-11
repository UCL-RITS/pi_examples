-- Haskell implementation of the pi example. 
-- Note that the way this is implemented is horribly memory consuming.

import System.Environment
import System.CPUTime

-- Need this to convert floats to doubles.
-- It's GHC-specific and non-portable.
import GHC.Float

-- Set up some functions
y(x) = 1.0/(1.0+(x*x))
calcpi(n) = (4.0/n) * sum (map y (map (/ n) [0.5..(n-0.5)]))

-- Main function
main = do

-- Get arguments
  argv <- getArgs
  let m = if (length argv >= 1) then read(head argv) :: Integer else 5000000

  putStrLn("Calculating PI using:")
  putStrLn("  " ++ (show m) ++ " slices")

  start <- getCPUTime

-- Do our integration
  let n = float2Double(fromIntegral m)
  let mypi = calcpi(n)
  putStrLn("Obtained value of PI: " ++ (show mypi))

-- Note we have to time here
  stop <- getCPUTime
  let runtime = (fromIntegral (stop - start)) / (10^12)
  putStrLn("Time taken: " ++ (show runtime) ++ " seconds")
