colour(red).
colour(blue).
colour(green).


adjacent(n, nw).
adjacent(n, nc).
adjacent(n, e).

adjacent(nw, nc).
adjacent(nw, c).
adjacent(nw, sa).
adjacent(nw, w).

adjacent(nc, c).
adjacent(nc, e).

adjacent(w, sa).
adjacent(w, s).

adjacent(s, sa).
adjacent(s, u).
adjacent(s, e).

adjacent(sa, u).
adjacent(sa, c).

adjacent(u, c).
adjacent(u, e).

adjacent(c, e).

% Two adjacent provinces must have different colours.

different(X, Y) :-
    X \= Y.

% Assign colours to all nine provinces.

map_colouring(N, NW, NC, W, C, E, U, SA, S) :-
    colour(N),
    colour(NW),
    colour(NC),
    colour(W),
    colour(C),
    colour(E),
    colour(U),
    colour(SA),
    colour(S),

    different(N, NW),
    different(N, NC),
    different(N, E),

    different(NW, NC),
    different(NW, C),
    different(NW, SA),
    different(NW, W),

    different(NC, C),
    different(NC, E),

    different(W, SA),
    different(W, S),

    different(S, SA),
    different(S, U),
    different(S, E),

    different(SA, U),
    different(SA, C),

    different(U, C),
    different(U, E),

    different(C, E).

% Query:
% ?- map_colouring(N,NW,NC,W,C,E,U,SA,S).
% Press ; to see more valid colourings.
