% opposite river banks
opposite(left, right).
opposite(right, left).

% safety conditions
safety(state(F,W,G,C)) :-
	(G\=W;F=G),
	(G\=C;F=G).
	
% move1: farmer with goat
move(state(F,W,F,C),goat,state(F2,W,F2,C)) :- opposite(F,F2).

% move2: farmer with wolf
move(state(F,F,G,C),wolf,state(F2,F2,G,C)) :- opposite(F,F2).

% move3: farmer with cabbage
move(state(F,W,G,F),cabbage,state(F2,W,G,F2)) :- opposite(F,F2).

% move4: farmer cross alone
move(state(F,W,G,C),alone,state(F2,W,G,C)) :- opposite(F,F2).

% goal condition
solve(State, Visited, [Action|Actions]) :- 
	move(State, Action, Nextstate), safe(NextState),
	\+ member(NextState, Visited),
	solve(NextState, [NextState|Visited], Actions).