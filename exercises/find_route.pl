road(colombo,kandy).
road(kandy,matale).
road(matale,badulla).
road(colombo,galle).
road(galle,matara).

route(X,Y,[X,Y]) :-
    road(X,Y).

route(X,Y,[X|Rest]) :-
    road(X,Z),
    route(Z,Y,Rest).

solve :-
    route(colombo,badulla,P),
    write(P).