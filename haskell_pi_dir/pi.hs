-- Haskell implementation of the pi example. 
-- Note that the way this is implemented is horribly memory consuming.

import System.Environment
import System.CPUTime

-- Need this to convert floats to doubles.
-- It's GHC-specific and non-portable.
import GHC.Float

-- Set up some functions
y(x) = 1/(1+(x*x))

-- Main function
main = do

-- Get arguments
  argv <- getArgs
  let m = if (length argv >= 1) then read(head argv) :: Integer else 5000000

  putStrLn("Calculating PI with " ++ (show m) ++ " slices")

  start <- getCPUTime

-- Do our integration
  let n = float2Double(fromIntegral m)
  let slice(x) = y(x)/n
  let steps = map (/ n)[1..n]
  let ssteps = map slice steps
  let mypi = 4 * sum ssteps
  putStrLn("Obtained value of PI: " ++ (show mypi))

-- Note we have to time here
  stop <- getCPUTime
  let runtime = (fromIntegral (stop - start)) / (10^12)
  putStrLn("Time taken: " ++ (show runtime) ++ " seconds")
