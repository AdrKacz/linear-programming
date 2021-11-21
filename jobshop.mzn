int: size;
array [1..size] of string: tasks;
array [1..size] of int: releases;
array [1..size] of int: durations;
array [1..size] of int: dues;
int: total = sum(i in 1..size)(durations[i]);

array [1..size] of var int: starts;
var int: past = sum(i in 1..size)(max(starts[i] + durations[i] - dues[i], 0));


constraint forall(i in 1..size)(starts[i] >= releases[i]);
constraint forall(i, j in 1..size where i < j)(starts[i] + durations[i] <= starts[j] \/ starts[j] + durations[j] <= starts[i]);

solve minimize past;

output["TOTAL PAST = ", show(past), "\n"]
++ ["Task\t" ++ "Release\t" ++ "Duration\t" ++ "Due\t" ++ "Start\t" ++ "Past\n"]
++ [tasks[i] ++ "\t" ++ show(releases[i]) ++ "\t" ++ show(durations[i]) ++ "\t" ++ show(dues[i]) ++ "\t" ++ show(starts[i]) ++ "\t" ++ show(max(starts[i] + durations[i] - dues[i], 0)) ++ "\n" | i in 1..size];

% DATA
size = 7;
tasks = ["A", "B", "C", "D", "E", "F", "G"];
releases = [2, 5, 4, 0, 0, 8, 9];
durations = [5, 6, 8, 4, 2, 3, 2];
dues = [10, 21, 15, 10, 5, 15, 22];