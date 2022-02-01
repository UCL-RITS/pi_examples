// Initial Rust implementation.

use std::time::Instant;
use std::thread;
use std::sync::mpsc::channel;
use std::env;

fn main() {

    let mut num_steps: i64;
    let mut num_threads: i64;
    let step: f64; 
    let mut s: f64; 
    let my_pi: f64;
    let arguments = std::env::args();

    num_steps = 1000000000;

// Check OMP_NUM_THREADS.  If it doesn't exist, default to threads = 1.
    match env::var("OMP_NUM_THREADS") {
        Ok(val) => num_threads=val.parse::<i64>().unwrap(),
        Err(_) => num_threads = 1,
    }

// Arguments are an iterator which is a PITA.
    let mut index = 0;
    for argument in arguments {
        if index == 1 {
            num_steps = argument.parse::<i64>().unwrap();
        }

// Treat second argument as a number of threads that overrides OMP_NUM_THREADS.        
        if index == 2 {
            num_threads = argument.parse::<i64>().unwrap();
        }
        index = index + 1;
    }

    print!("Calculating PI using:\n");
    print!("  {} slices\n", num_steps.to_string());
    print!("  {} threads\n", num_threads.to_string());

    let start = Instant::now();

    let (transmit, receive) = channel();
 
    s = 0.0;
    step = 1.0/num_steps as f64;

    for rank in 0..num_threads {
        let transmit = transmit.clone();
        thread::spawn(move|| {
            let mut s = 0.0;
            let chunkstart = rank * num_steps / num_threads;
            let chunkend = (rank + 1) * num_steps / num_threads;
// Uncomment to check parallelisation:
//            print!("Thread: {} ", rank);
//            print!("Start: {} ", chunkstart);
//            print!("End: {} ", chunkend-1);
//            print!("Length: {}\n", chunkend - chunkstart);
            for i in chunkstart..chunkend {
                let x = ((i as f64) + 0.5)* step;
                s = s + (4.0/(1.0 + (x*x)));
            }
            transmit.send(s).unwrap();
        });
    }

// Gather results.
    for _ in 0..num_threads {
        let r = receive.recv().unwrap();
        s = s + r;
    }

    my_pi = s * step;

    let stop = Instant::now();

    print!("Obtained value of PI: {}\n", my_pi);
    print!("Time Elapsed: {}.", stop.duration_since(start).as_secs());
    print!("{} seconds\n", stop.duration_since(start).subsec_nanos());

}