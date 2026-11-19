opposite(left, right).
opposite(right, left).

safe(state(F, W, G, C)) :-
    (G \= W ; F = G),
    (G \= C ; F = G).

move(state(F, W, F, C), goat, state(F2, W, F2, C)) :- opposite(F, F2).
move(state(F, F, G, C), wolf, state(F2, F2, G, C)) :- opposite(F, F2).
move(state(F, W, G, F), cabbage, state(F2, W, G, F2)) :- opposite(F, F2).
move(state(F, W, G, C), alone, state(F2, W, G, C)) :- opposite(F, F2).

solve(state(right, right, right, right), _, []).

solve(State, Visited, [Action|Actions]) :-
    move(State, Action, NextState),
    safe(NextState),
    \+ member(NextState, Visited),
    solve(NextState, [NextState|Visited], Actions).

run :-
    Start = state(left, left, left, left),
    solve(Start, [Start], Plan),
    write('Plan: '), write(Plan), nl.