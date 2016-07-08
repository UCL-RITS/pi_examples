open System

let y(x) = 1.0/(1.0+(x*x))
let calcpi(n) = (4.0/n) * Seq.sum (Seq.map y ((seq { for i in 1.0..n -> i/n})))

[<EntryPoint>]
let Main args =
  let m = if args.Length > 0 then int args.[0] else 100000000
  let n = double m
  printfn "Calculating PI using:"
  printfn "  %i slices" m 
  let start = DateTime.Now
  let p = calcpi(n)
  printfn "Obtained value of PI: %f" p
  let stop = DateTime.Now
  let difference = stop.Subtract(start)
  let time = difference.TotalSeconds
  printfn "Total time taken: %f seconds" time
  0
