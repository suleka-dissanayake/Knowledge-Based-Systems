hanoi(0, _, _, _, 0) :- !.

hanoi(N, From, To, Aux, Moves) :-
    N > 0,
    N1 is N - 1,
    hanoi(N1, From, Aux, To, M1),
    hanoi(N1, Aux, To, From, M2),
    Moves is M1 + M2 + 1.

hanoi_print(0, _, _, _) :- !.
hanoi_print(N, From, To, Aux) :-
    N > 0,
    N1 is N - 1,
    hanoi_print(N1, From, Aux, To),
    write('Move disk '), write(N),
    write(' from '), write(From),
    write(' to '), write(To), nl,
    hanoi_print(N1, Aux, To, From).