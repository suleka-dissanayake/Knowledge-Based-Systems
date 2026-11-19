solve :-
    permutation([1,2,3,4], Q),
    safe(Q).

safe([]).

safe([Q|Rest]) :-
    safe(Rest),
    check(Q,Rest,1).

check(_,[],_).

check(Q,[R|Rest],D) :-
    Q-R =\= D,
    R-Q =\= D,
    D1 is D+1,
    check(Q,Rest,D1).