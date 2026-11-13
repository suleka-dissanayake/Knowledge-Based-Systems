% ============================================================
% Problem 03: River Crossing (Farmer, Wolf, Goat, Cabbage)
% ============================================================
% STATE REPRESENTATION
%   state(F, W, G, C) where each argument is the bank
%   (left or right) of the Farmer, Wolf, Goat and Cabbage.
% Initial state : state(left, left, left, left)
% Goal state    : state(right, right, right, right)
% ============================================================

% ---- opposite river banks ----
opposite(left, right).
opposite(right, left).

% ---- safety conditions ----
% A state is safe if:
%   - the goat is not with the wolf, unless the farmer is there too
%   - the goat is not with the cabbage, unless the farmer is there too
safe(state(F, W, G, C)) :-
    (G \= W ; F = G),
    (G \= C ; F = G).

% ---- MOVES ----
% move(CurrentState, Action, NextState)
% The farmer always crosses, so F changes to its opposite bank F2.

% move1: farmer with goat (farmer and goat on the same bank F)
move(state(F, W, F, C), goat, state(F2, W, F2, C)) :- opposite(F, F2).

% move2: farmer with wolf (farmer and wolf on the same bank F)
move(state(F, F, G, C), wolf, state(F2, F2, G, C)) :- opposite(F, F2).

% move3: farmer with cabbage (farmer and cabbage on the same bank F)
move(state(F, W, G, F), cabbage, state(F2, W, G, F2)) :- opposite(F, F2).

% move4: farmer crosses alone
move(state(F, W, G, C), alone, state(F2, W, G, C)) :- opposite(F, F2).

% ---- goal condition ----
% Base case: everyone is on the right bank -> no more actions needed.
solve(state(right, right, right, right), _, []).

% Recursive case:
%   1. choose a move, 2. make sure the new state is safe,
%   3. make sure it was not visited before (avoids loops),
%   4. continue from the new state. Prolog backtracks on failure.
solve(State, Visited, [Action|Actions]) :-
    move(State, Action, NextState),
    safe(NextState),
    \+ member(NextState, Visited),
    solve(NextState, [NextState|Visited], Actions).

% ---- helper to run the problem ----
% ?- run.
% Expected (7 crossings): [goat, alone, wolf, goat, cabbage, alone, goat]
% (or the same with wolf and cabbage swapped; press ';' for more.)
run :-
    Start = state(left, left, left, left),
    solve(Start, [Start], Plan),
    write('Plan: '), write(Plan), nl.
