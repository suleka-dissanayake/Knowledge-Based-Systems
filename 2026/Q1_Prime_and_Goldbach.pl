% IT3113 Practical - Question 1
% Q1(a): Check whether a number is prime.
% Q1(b): Find two prime numbers whose sum is an even number.

% A prime number is greater than 1 and has no divisor
% other than 1 and itself.

prime(N) :-
    integer(N),
    N > 1,
    \+ has_factor(N, 2).

has_factor(N, D) :-
    D * D =< N,
    ( N mod D =:= 0
    ;
      D1 is D + 1,
      has_factor(N, D1)
    ).

% Example queries:
% ?- prime(17).
% true.
%
% ?- prime(18).
% false.

% Q1(b): Goldbach
% Find prime A and B such that A + B = N.
% A is searched from 2 up to N/2.

goldbach(N, A+B) :-
    integer(N),
    N > 2,
    N mod 2 =:= 0,
    Half is N // 2,
    between(2, Half, A),
    B is N - A,
    prime(A),
    prime(B),
    !.

% Example queries:
% ?- goldbach(30, Solution).
% Solution = 7+23.
%
% ?- goldbach(17420000, Solution).
% Solution = 109+17419891.
