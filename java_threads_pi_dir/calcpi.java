public class calcpi implements Runnable {
	private long min;
	private long max;
	private long n;
	private double answer;
	private boolean debug;

	public calcpi(long min, long max, long n) {
		this.min = min;
		this.max = max;
		this.n = n;
		this.answer = 0d;
		this.debug = false;
	}

	public void setDebug() {
		this.debug = true;
	}

	public double getAnswer() {
		return this.answer;
	}

	public void run() {
		double x;
		double step = 1d/(double)n;
		double psum = 0d;
		if (this.debug) {
			System.out.println("Calculating iterations from " + this.min + " to " + this.max);
		}
		for (long i = this.min; i < this.max; i++) {
			x = ((double)i + 0.5d) * step;
			psum = psum + 4d/(1d + (x * x));
		}
		this.answer = psum * step;
	}
}
