open Array (* For argv *)
open Sys   (* For time and argv *)
open Printf

let slice_count = 
  if (Array.length Sys.argv) > 1 
  then 
    int_of_string Sys.argv.(1) 
  else 
    1000000

let slice_width =
  1.0 /. (float slice_count)

let slice_area i :(float)=
  let i = float i in
  let x = (i +. 0.5) *. slice_width in
  (4.0 /. (1.0 +. (x *. x)))

let rec calculate_pi (slice_number:int) (acc:float) : (float) =
  if slice_number >= slice_count
  then 
    acc /. (float slice_count)
  else 
    (calculate_pi (slice_number + 1) (acc +. (slice_area slice_number)))
  
let () = 
  let _ = Printf.printf "Calculating pi using:\n  %d slices\n  1 process\n" slice_count in
  let start_time = Sys.time() in
  let pi = (calculate_pi 0 0.0) in
  let end_time = Sys.time() in
  let _ = Printf.printf "Obtained value for PI: %.16g\n" pi in
  Printf.printf "Time taken: %.16g seconds\n" (end_time -. start_time)



