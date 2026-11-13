% ============================================================
% Problem 01: Monkey and Banana
% ============================================================
% STATE REPRESENTATION
%   state(MonkeyPos, MonkeyLevel, BlockPos, HasBanana)
%     MonkeyPos   : door | window | middle   (horizontal position)
%     MonkeyLevel : onfloor | onbox          (vertical position)
%     BlockPos    : door | window | middle   (where the block is)
%     HasBanana   : hasnot | has
% Initial state : state(door, onfloor, window, hasnot)
% Goal state    : HasBanana = has
% ============================================================

% ---- possible places in the room ----
place(door).
place(window).
place(middle).

% ---- ACTIONS (state transitions) ----
% move(CurrentState, Action, NextState)

% move1: grasp - monkey on the block, block in the middle,
% monkey does not yet have the banana -> now it has it.
move(state(middle, onbox, middle, hasnot),
     grasp,
     state(middle, onbox, middle, has)).

% move2: climb - monkey and block are at the same place (P) and
% the monkey is on the floor -> monkey climbs on top of the block.
move(state(P, onfloor, P, H),
     climb,
     state(P, onbox, P, H)).

% move3: push - monkey and block are at the same place (P1) and the
% monkey is on the floor -> monkey drags the block (and itself) to P2.
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
