array [1..7] of int: requires;
set of int: week = 1..7;
set of int: maximum_set_of_employee = 1..40; % > 19 * 2 = 38

array [1..14, maximum_set_of_employee] of var bool: program;

var int: number_of_employee;

% Number of employee less than 40;
constraint number_of_employee >= 1 /\ number_of_employee <= 40;


% Each day should have the correct number of employee
constraint forall(w in week)(
sum(program[w, maximum_set_of_employee]) + sum(program[w + 7, maximum_set_of_employee]) >= requires[w]
);

% No work if no employee
constraint forall(e in maximum_set_of_employee where e > number_of_employee)(
sum(program[1..14, e]) = 0
);

% No more than five days a week
constraint forall(e in maximum_set_of_employee where e <= number_of_employee)(
sum(program[1..14, e]) = 5
);


% Work five consecutive days
constraint forall(e in maximum_set_of_employee where e <= number_of_employee)(
if program[1, e] == 1 then sum(program[1..5, e]) = 5
elseif program[2, e] == 1 then sum(program[2..6, e]) = 5
elseif program[3, e] == 1 then sum(program[3..7, e]) = 5
elseif program[4, e] == 1 then sum(program[4..8, e]) = 5
elseif program[5, e] == 1 then sum(program[5..9, e]) = 5
elseif program[6, e] == 1 then sum(program[6..10, e]) = 5
else sum(program[7..11, e]) = 5
endif
);

% Satisfy
solve minimize number_of_employee;

% Output
output [show(number_of_employee) ++ "\n"
++ "Monday\t" ++ join("\t", [show(program[1, e] \/ program[8, e]) | e in maximum_set_of_employee]) ++  "\n\n"
++ "Tuesday\t" ++ join("\t", [show(program[2, e] \/ program[9, e]) | e in maximum_set_of_employee]) ++ "\n\n"
++ "Wednesday\t" ++ join("\t", [show(program[3, e] \/ program[10, e]) | e in maximum_set_of_employee]) ++ "\n\n"
++ "Thursday\t" ++ join("\t", [show(program[4, e] \/ program[11, e]) | e in maximum_set_of_employee]) ++ "\n\n"
++ "Friday\t" ++ join("\t", [show(program[5, e] \/ program[12, e]) | e in maximum_set_of_employee]) ++ "\n\n"
++ "Saturday\t" ++ join("\t", [show(program[6, e] \/ program[13, e]) | e in maximum_set_of_employee]) ++ "\n\n"
++ "Sunday\t" ++ join("\t", [show(program[7, e] \/ program[14, e]) | e in maximum_set_of_employee]) ++ "\n\n"
];




% DATA
requires = [14, 13, 15, 16, 19, 18, 11];