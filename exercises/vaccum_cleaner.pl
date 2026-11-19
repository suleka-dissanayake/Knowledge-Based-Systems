% State: (Location, RoomA, RoomB)

move((a,dirty,B), (a,clean,B)).
move((b,A,dirty), (b,A,clean)).

move((a,A,B), (b,A,B)).
move((b,A,B), (a,A,B)).

goal((_,clean,clean)).

solve :-
    path((a,dirty,dirty), [(a,dirty,dirty)]).

path(S,_) :-
    goal(S),
    write('All rooms cleaned!').

path(S,Visited) :-
    move(S,Next),
    \+ member(Next,Visited),
    path(Next,[Next|Visited]).