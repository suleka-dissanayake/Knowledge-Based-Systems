connected(a, b).
connected(b, c).

route(X, Y) :- connected(X, Y).
route(X, Y) :- connected(X, Z), route(Z, Y).

% connected(a,b).
% connected(b,c).
% connected(a,c).