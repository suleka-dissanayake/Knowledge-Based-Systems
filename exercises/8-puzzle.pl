% Initial state and goal state

start([1,2,3,4,0,6,7,5,8]).
goal([1,2,3,4,5,6,7,8,0]).

% Move empty space right

move([A,B,C,D,0,F,G,H,I],
     [A,B,C,D,F,0,G,H,I]).

% Move empty space left

move([A,B,C,0,E,F,G,H,I],
     [A,B,C,E,0,F,G,H,I]).

% Move empty space up

move([A,B,C,D,0,F,G,H,I],
     [A,0,C,D,B,F,G,H,I]).

% Move empty space down

move([A,0,C,D,B,F,G,H,I],
     [A,B,C,D,0,F,G,H,I]).

solve :-
    start(S),
    path(S,[S]).

path(S,_) :-
    goal(S),
    write('Goal reached!').

path(S,Visited) :-
    move(S,Next),
    \+ member(Next,Visited),
    path(Next,[Next|Visited]).