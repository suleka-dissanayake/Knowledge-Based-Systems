goal(state(X,Y)) :- X=:=2 ; Y=:=2.

move(state(X,Y),state(4,Y),'Fill 4') :- X<4.
move(state(X,Y),state(X,3),'Fill 3') :- Y<3.
move(state(X,Y),state(0,Y),'Empty 4') :- X>0.
move(state(X,Y),state(X,0),'Empty 3') :- Y>0.

move(state(X,Y),state(4,Z),'Pour 3-4') :-
    X+Y>=4, Y>0, Z is Y-(4-X).

move(state(X,Y),state(Z,3),'Pour 4-3') :-
    X+Y>=3, X>0, Z is X-(3-Y).

solve(S,_,[S]) :- goal(S).

solve(S,V,[S|P]) :-
    move(S,N,_),
    \+ member(N,V),
    solve(N,[S|V],P).

run :-
    solve(state(0,0),[],P),
    write(P).