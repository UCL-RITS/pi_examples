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

	public static double calc(long numsteps, int threads) {
		calcpi[] calcs = new calcpi[threads];
		Thread[] t;
		t = new Thread[threads];

		// Decomposition - simple - at most threads - 1 iterations imbalance.
		long perthread = numsteps/threads;
		long leftover = numsteps - (threads * perthread);
		double mypi = 0d;

		for (int i = 0; i < threads; i++) {
			long lmin = i*perthread;
			long lmax = ((i+1) * perthread) -1;
			if (i == (threads - 1)) {
				lmax = lmax + leftover;
			}
			calcs[i] = new calcpi(lmin, lmax, numsteps);
			// calcs[i].setDebug();
			t[i] = new Thread(calcs[i], "thread: " + i);
			t[i].start();

		}

		for (int i = 0; i < threads; i++) {
			try {
				t[i].join();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		for (int i = 0; i < threads; i++) {
			mypi = mypi + calcs[i].getAnswer();
		}

		return mypi;
	}
}
