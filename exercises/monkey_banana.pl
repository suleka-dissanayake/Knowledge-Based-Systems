place(door).
place(window).
place(middle).

move(state(middle, onbox, middle, hasnot), grasp, state(middle, onbox, middle, has)).

move(state(P, onfloor, P, H), climb, state(P, onbox, P, H)).

move(state(P1, onfloor, P1, H), push(P1, P2), state(P2, onfloor, P2, H)) :-
    place(P2), P1 \= P2.

move(state(P1, onfloor, B, H), walk(P1, P2), state(P2, onfloor, B, H)) :-
    place(P2), P1 \= P2.

solve(state(_, _, _, has), _, []).

solve(State, Visited, [Action|Actions]) :-
    move(State, Action, NextState),
    \+ member(NextState, Visited),
    solve(NextState, [NextState|Visited], Actions).

run :-
    Start = state(door, onfloor, window, hasnot),
    solve(Start, [Start], Plan),
    write('Plan: '), write(Plan), nl.