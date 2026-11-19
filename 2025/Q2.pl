% IT3113 Practical - Question 2
% AI puzzle solutions: Rat in a 5x5 grid and family river crossing.

% ------------------------------------------------------------
% Q2(a): Rat in a 5x5 grid - shortest path using BFS
% Coordinates are (Row,Column). Start (0,0), goal (4,4).
% ------------------------------------------------------------

start((0,0)).
goal((4,4)).

% Blocked cells shown in Figure 1 on page 3.
blocked((0,2)).
blocked((1,4)).
blocked((2,1)).
blocked((2,3)).
blocked((3,2)).
blocked((4,0)).

% Possible moves: up, down, left and right.

rat_move((X,Y),(X1,Y)) :-
    X1 is X-1.

rat_move((X,Y),(X1,Y)) :-
    X1 is X+1.

rat_move((X,Y),(X,Y1)) :-
    Y1 is Y-1.

rat_move((X,Y),(X,Y1)) :-
    Y1 is Y+1.

% Check that a cell is inside the grid and not blocked.

valid((X,Y)) :-
    X >= 0, X < 5,
    Y >= 0, Y < 5,
    \+ blocked((X,Y)).

% Start BFS.

solve_rat(Path) :-
    start(S),
    bfs([[S]], Path).

bfs([[G|Rest]|_], Path) :-
    goal(G),
    reverse([G|Rest], Path).

bfs([Path|Queue], Solution) :-
    Path = [Current|_],
    findall([Next|Path],
        ( rat_move(Current, Next),
          valid(Next),
          \+ member(Next, Path)
        ),
        NewPaths),
    append(Queue, NewPaths, NewQueue),
    bfs(NewQueue, Solution).

% Query:
% ?- solve_rat(Path).


% ------------------------------------------------------------
% Q2(b): Family river crossing
% State: state(P1,P2,Son,Daughter,Boat).
% left/right indicate the river bank.
%
% Assumption for this simple model:
% The family members cross from left to right. The fisherman
% returns the empty boat from right to left between crossings.
% The boat carries either one adult or both children together.
% ------------------------------------------------------------

family_start(state(left,left,left,left,left)).
family_goal(state(right,right,right,right,left)).

% Parent 1 crosses from left to right.

family_move(state(left,B,S,D,left),
            state(right,B,S,D,right)).

% Parent 2 crosses from left to right.

family_move(state(A,left,S,D,left),
            state(A,right,S,D,right)).

% Both children cross together.

family_move(state(A,B,left,left,left),
            state(A,B,right,right,right)).

% Fisherman returns the empty boat.

family_move(state(A,B,S,D,right),
            state(A,B,S,D,left)).

% Find a sequence without repeating a state.

solve_family(Path) :-
    family_start(S),
    family_path(S, [S], ReversePath),
    reverse(ReversePath, Path).

family_path(State, Visited, Visited) :-
    family_goal(State).

family_path(State, Visited, Path) :-
    family_move(State, Next),
    \+ member(Next, Visited),
    family_path(Next, [Next|Visited], Path).

% Query:
% ?- solve_family(Path).
