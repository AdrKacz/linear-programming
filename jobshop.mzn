int: size;
array [1..size] of int: releases;
array [1..size] of int: durations;
array [1..size] of int: dues;
int: total = sum(i in 1..size)(durations[i]);

array [1..size] of var int: starts;
var int: past = sum(i in 1..size)(max(starts[i] + durations[i] - dues[i], 0));

constraint

/*
int: size;

array [1..size, 1..size] of int: durations;
int: total = sum(i, j in 1..size)(durations[i,j]);
array [1..size, 1..size] of var 0..total: start;
var 0..total: end;

predicate no_overlap(var int: start1, int: duration1, var int: start2, int: duration2) = 
  start1 + duration1 <= start2 \/ start2 + duration2 <= start1;
  
constraint forall(i in 1..size)(
  forall(j in 1..size - 1)(
    start[i, j] + durations[i, j] <= start[i, j + 1])
  /\
  start[i, size] + durations[i, size] <= end
  /\
  forall(j, k in 1..size where j < k)(
    no_overlap(start[j, i], durations[j, i], start[k, i], durations[k, i]))
);

solve minimize end;

% DATA
size = 2;
durations = [|
2, 5|
3, 4|
|];
*/