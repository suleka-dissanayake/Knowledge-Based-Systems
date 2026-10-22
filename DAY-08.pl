guest(alice).
guest(bob).
guest(charlie).
guest(diana).

room(101, standard).
room(102, standard).
room(201, deluxe).
room(202, deluxe).

reserved(alice, 101).
reserved(bob, 201).
reserved(charlie, 102).
reserved(diana, 202).

has_service(wifi, 101).
has_service(wifi, 102).
has_service(wifi, 201).
has_service(ac, 201).
has_service(ac, 202).

room_premium(X) :- room_type(X, deluxe), has_service(X, 101).
room_comfortable(X) :- has_service(X, ac), has_service(X, wifi).
delux_reserve(G) :- room_type(R, deluxe), reserved(G,R), nl.

% guest(X).
% room_type(X, deluxe).
% reserved(bob, X).
% has_service(X, 101).
% room_type(R, deluxe), reserved(G,R), nl.