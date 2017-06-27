// Initial Rust implementation.

fn main() {

    let mut num_steps: i64; 
    let step: f64; 
    let mut x: f64; 
    let mut s: f64; 
    let my_pi: f64;
    let arguments = std::env::args();

    num_steps = 100000;

// Arguments are an iterator which is a PITA.
    let mut index = 0;
    for argument in arguments {
        if index == 1 {
            num_steps = argument.parse::<i64>().unwrap();
        }
        index = index + 1;
    }

    print!("Calculating PI using:\n  ");
    print!("{} slices\n", num_steps.to_string());
    print!("  1 process\n");

    s = 0.0;
    step = 1.0/num_steps as f64;

    for i in 0..num_steps {
        x = ((i as f64) + 0.5)* step;
        s = s + (4.0/(1.0 + (x*x)));
    }

    my_pi = s * step;

    print!("Obtained value of PI: {}\n", my_pi);


}