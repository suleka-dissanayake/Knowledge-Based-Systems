connected(a, b).
connected(b, c).

route(X, Y, [X, Y]) :- connected(X, Y).
route(X, Y, [X|Rest]) :- connected(X, Z), route(Z, Y, Rest).

% connected(a,b).
% connected(b,c).
% connected(a,c).