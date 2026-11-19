% IT3113 Practical - Question 2
% Farmer, wolf, goat and cabbage river crossing.
% State: state(Farmer,Wolf,Goat,Cabbage)
% Each person/item is on the left or right bank.

% Q2(a): Initial and goal states.

initial(state(left,left,left,left)).
goal(state(right,right,right,right)).

% Q2(b): Unsafe states.
% Wolf eats goat if they are together without farmer.
% Goat eats cabbage if they are together without farmer.

unsafe(state(F,W,G,C)) :-
    ( W = G, F \= W )
    ;
    ( G = C, F \= G ).

% Q2(c): Valid moves.
% Farmer crosses alone.

move(state(left,W,G,C), state(right,W,G,C)) :-
    safe(state(right,W,G,C)).

move(state(right,W,G,C), state(left,W,G,C)) :-
    safe(state(left,W,G,C)).

% Farmer takes the wolf.

move(state(left,left,G,C), state(right,right,G,C)) :-
    safe(state(right,right,G,C)).

move(state(right,right,G,C), state(left,left,G,C)) :-
    safe(state(left,left,G,C)).

% Farmer takes the goat.

move(state(left,W,left,C), state(right,W,right,C)) :-
    safe(state(right,W,right,C)).

move(state(right,W,right,C), state(left,W,left,C)) :-
    safe(state(left,W,left,C)).

% Farmer takes the cabbage.

move(state(left,W,G,left), state(right,W,G,right)) :-
    safe(state(right,W,G,right)).

move(state(right,W,G,right), state(left,W,G,left)) :-
    safe(state(left,W,G,left)).

safe(State) :-
    \+ unsafe(State).

% Q2(d): Depth First Search (DFS).

solve(Path) :-
    initial(Start),
    dfs(Start, [Start], ReversePath),
    reverse(ReversePath, Path).

dfs(State, Visited, Visited) :-
    goal(State).

dfs(State, Visited, Path) :-
    move(State, Next),
    \+ member(Next, Visited),
    dfs(Next, [Next|Visited], Path).

% Query:
% ?- solve(Path).
