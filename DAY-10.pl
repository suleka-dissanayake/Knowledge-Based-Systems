% opposite river banks
opposite(left, right).
opposite(right, left).

% safety conditions
safety(state(F,W,G,C)) :-
	(G\=W;F=G),
	(G\=C;F=G).
	
% move1: farmer with goat
move(state(F,W,F,C),goat,state(F2,W,F2,C)) :- opposite(F,F2).

% move2: farmer with goat
move(state(F,F,G,C),wolf,state(F2,F2,G,C)) :- opposite(F,F2).

% move3: farmer with cabbage