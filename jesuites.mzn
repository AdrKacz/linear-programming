set of int: weeks = 1..7;
set of int: tasks = 1..4;
set of int: volonteers = 1..7;


array [weeks, tasks, volonteers] of var bool: cube;

% 1 for the trash, 2 for each remaining tasks
constraint forall(w in weeks)(
forall(t in tasks)(
if t == 4 then sum(cube[w, t, volonteers]) = 1 else sum(cube[w, t, volonteers]) = 2 endif
));

/* This is not needed, its automatically implied by next contraints
% Each has to do each task twice
constraint forall(v in volonteers)(
forall(t in tasks)(
forall(w1, w2 in weeks where w1 != w2)(
if t == 4 then cube[w1, t, v] + cube[w2, t, v] >= 1 else cube[w1, t, v] + cube[w2, t, v] >= 1 endif
)));
*/

% All team different
constraint forall(w1, w2 in weeks where w1 != w2)(
forall(t1, t2 in tasks)(
cube[w1, t1, volonteers] != cube[w2, t2, volonteers]
));

% 1 task per week
constraint forall(w in weeks)(
forall(v in volonteers)(
sum(cube[w, tasks, v]) = 1
));



solve satisfy;
output ["\nSemaine: " ++ show(w) ++ "\n" 
++ "   Volonteer: " ++ join("\t", [show(v) | v in volonteers]) ++ "\n"
++ "   Kitchen:   " ++ join("\t", [show(cube[w, 1, v]) | v in volonteers]) ++ "\n"
++ "   Bathroom:  " ++ join("\t", [show(cube[w, 2, v]) | v in volonteers]) ++ "\n"
++ "   Common:    " ++ join("\t", [show(cube[w, 3, v]) | v in volonteers]) ++ "\n"
++ "   Trash:     " ++ join("\t", [show(cube[w, 4, v]) | v in volonteers]) ++ "\n"
| w in weeks];