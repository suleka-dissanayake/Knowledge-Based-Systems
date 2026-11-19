% IT3113 Practical - Question 1
% Employee facts, salary, annual leave and bonus calculations.

% Q1(a): Table 1 - Employee details
% employee(Name, Department, Position, TakenAnnualLeave).

employee(john, hr, director, 25).
employee(denis, finance, general_manager, 21).
employee(fleming, marketing, manager, 15).
employee(bozena, finance, director, 6).
employee(zofia, hr, manager, 13).
employee(urban, it, network_engineer, 12).
employee(pilar, admin, secretary, 5).
employee(kura, admin, manager, 10).
employee(jasmine, it, intern, 9).
employee(george, marketing, intern, 7).

% Q1(a): Table 2 - Salary and allocated annual leave
% job(Position, Salary, AllocatedAnnualLeave).

job(director, 90000, 54).
job(general_manager, 80000, 54).
job(manager, 65000, 45).
job(secretary, 50000, 24).
job(network_engineer, 60000, 36).
job(intern, 30000, 24).

% Q1(b)(i): Print positions and departments for employees.

print_details([]).
print_details([Name|Rest]) :-
    employee(Name, Department, Position, _),
    write(Name), write(' - '),
    write(Department), write(' - '),
    write(Position), nl,
    print_details(Rest).

% Example:
% ?- print_details([john,denis,zofia]).

% Q1(b)(ii): Print salaries for employees.

print_salary([]).
print_salary([Name|Rest]) :-
    employee(Name, _, Position, _),
    job(Position, Salary, _),
    write(Name), write(' - Rs. '),
    write(Salary), nl,
    print_salary(Rest).

% Example:
% ?- print_salary([john,denis,fleming]).

% Q1(b)(iii): Calculate remaining annual leave.

remaining_leave(Name, Remaining) :-
    employee(Name, _, Position, Taken),
    job(Position, _, Allocated),
    Remaining is Allocated - Taken.

% Example:
% ?- remaining_leave(john, X).

% Q1(c)(i): Bonus percentage rules from Table 3.

bonus_percent(Days, 60) :-
    Days > 30.

bonus_percent(Days, 50) :-
    Days >= 26,
    Days =< 30.

bonus_percent(Days, 40) :-
    Days >= 21,
    Days =< 25.

bonus_percent(Days, 0) :-
    Days < 20.

% Note: Table 3 does not specify the bonus for exactly 20 days.

% Q1(c)(ii): Print bonus amount for a list of employees.

print_bonus([]).
print_bonus([Name|Rest]) :-
    employee(Name, _, Position, Taken),
    job(Position, Salary, Allocated),
    Remaining is Allocated - Taken,
    bonus_percent(Remaining, Percent),
    Bonus is Salary * Percent / 100,
    write(Name), write(' - Rs. '),
    write(Bonus), nl,
    print_bonus(Rest).

% Example:
% ?- print_bonus([john,denis,fleming]).

% Q1(c)(iii): Find the employee with the largest bonus.

get_bonus(Name, Bonus) :-
    employee(Name, _, Position, Taken),
    job(Position, Salary, Allocated),
    Remaining is Allocated - Taken,
    bonus_percent(Remaining, Percent),
    Bonus is Salary * Percent / 100.

largest_bonus([Name], Name, Bonus) :-
    get_bonus(Name, Bonus).

largest_bonus([Name|Rest], BestName, BestBonus) :-
    get_bonus(Name, Bonus),
    largest_bonus(Rest, OtherName, OtherBonus),
    ( Bonus >= OtherBonus ->
        BestName = Name,
        BestBonus = Bonus
    ;
        BestName = OtherName,
        BestBonus = OtherBonus
    ).

% Example:
% ?- largest_bonus([john,denis,fleming,bozena,zofia], Name, Bonus).