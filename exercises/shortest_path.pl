edge(a,b).
edge(a,c).
edge(b,d).
edge(c,d).
edge(d,e).

bfs(Start,Goal,Path) :-
    bfs([[Start]],Goal,Rev),
    reverse(Rev,Path).

bfs([[Goal|Rest]|_],Goal,[Goal|Rest]).

bfs([[X|Rest]|Queue],Goal,Path) :-
    findall([Y,X|Rest],
       (edge(X,Y), \+ member(Y,[X|Rest])),
       New),
    append(Queue,New,Q1),
    bfs(Q1,Goal,Path).

solve :-
    bfs(a,e,P),
    write(P).