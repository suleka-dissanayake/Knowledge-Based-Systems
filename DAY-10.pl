% opposite river banks
opposite(left, right).
opposite(right, left).

% safety conditions
safety(state(F,W,G,C)) :-
	(G\=W;F=G),
	(G\=C;F=G).
	
% move1: farmer with goat
move(state(L,L,L,L),goat,state2) :- opposite().