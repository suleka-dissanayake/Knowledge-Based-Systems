hanoi(0, _, _, _, 0) :- !.

% ---- recursive case ----
hanoi(N, From, To, Aux, Moves) :-
    N > 0,
    N1 is N - 1,
    hanoi(N1, From, Aux, To, M1),   % step 1: N-1 disks to the auxiliary rod
    hanoi(N1, Aux, To, From, M2),   % step 3: N-1 disks onto the target rod
    Moves is M1 + M2 + 1.           % +1 is the move of the largest disk (step 2)

% ---- version that also PRINTS every move ----
% Counts and prints each move, e.g. "Move disk 1 from left to right".
hanoi_print(0, _, _, _) :- !.
hanoi_print(N, From, To, Aux) :-
    N > 0,
    N1 is N - 1,
    hanoi_print(N1, From, Aux, To),
    write('Move disk '), write(N),
    write(' from '), write(From),
    write(' to '), write(To), nl,
    hanoi_print(N1, Aux, To, From).

% ---- example queries ----
% ?- hanoi(3, left, right, mid, Moves).      % Moves = 7
% ?- hanoi(4, left, right, mid, Moves).      % Moves = 15
% ?- hanoi_print(3, left, right, mid).       % prints the 7 moves
