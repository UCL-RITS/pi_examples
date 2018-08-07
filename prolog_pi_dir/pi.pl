chunk(I,N,S):-
	I > 0,
	Ix is I - 1,
	chunk(Ix, N, Sx),
	S is Sx + (4.0/ ((I - 0.5) * (1.0 / N) * (I - 0.5) * (1.0 / N) + 1.0)).
chunk(0,_N,0).

pi(N,P) :- chunk(N,N,X),
	P is X/N.
