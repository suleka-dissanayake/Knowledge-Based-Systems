place(door).
place(window).
place(middle).

% move(CurrentState, Action, NextState)

move(state(middle, onbox, middle, hasnot), grasp, state(middle, onbox, middle, has)).

move(state(P, onfloor, P, H), climb, state(P, onbox, P, H)).

move(state(P1, onfloor, P1, H),
     push(P1, P2),
     state(P2, onfloor, P2, H)) :-
    place(P2), P1 \= P2.

% move4: walk - monkey walks from P1 to P2 on the floor
% (the block stays where it is).
move(state(P1, onfloor, B, H),
     walk(P1, P2),
     state(P2, onfloor, B, H)) :-
    place(P2), P1 \= P2.

% ---- goal condition ----
% Base case: stop when the monkey has the banana (position, level
% and block position do not matter, so they are anonymous variables).
solve(state(_, _, _, has), _, []).

% Recursive case:
%   1. pick a legal move from the current state,
%   2. skip states already visited (prevents infinite loops),
%   3. keep solving from the new state.
% Prolog BACKTRACKS automatically if a branch fails.
solve(State, Visited, [Action|Actions]) :-
    move(State, Action, NextState),
    \+ member(NextState, Visited),
    solve(NextState, [NextState|Visited], Actions).

% ---- helper to run the problem ----
% Query:  ?- run.      or      ?- solve(state(door,onfloor,window,hasnot),
%                                  [state(door,onfloor,window,hasnot)], Plan).
% Expected plan: [walk(door,window), push(window,middle), climb, grasp]
% (Press ';' to see other possible plans through backtracking.)
run :-
    Start = state(door, onfloor, window, hasnot),
    solve(Start, [Start], Plan),
    write('Plan: '), write(Plan), nl.
