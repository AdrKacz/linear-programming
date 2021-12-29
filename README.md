# linear-programming
Linear Programming Exercises, Centrale Lyon, MOD 4.4 Operational Research

# How to set up ?

```
git clone https://github.com/AdrKacz/linear-programming.git
cd linear-programming
pip -m venv
source bin/activate
pip install -r requirements.txt
```

# BIP (1) `./bip.py`

### *Usine* and *Entrepot*

Attribute | Benefits | Cost
-- | -- | --
*Usine Lyon* | 9 | 6
*Usine Grenoble* | 5 | 3
*Entrepot Lyon* | 6 | 5
*Entrepot Grenoble* | 4 | 2

## Variables

We define **4** variables in the set `{0, 1}`.

- `usine_lyon`, **1** if there is *usine* in *Lyon*, **0** otherwise.

- `usine_grenoble`, **1** if there is *usine* in *Grenoble*, **0** otherwise.

- `entrepot_lyon`, **1** if there is *entrepot* in *Lyon*, **0** otherwise.

- `entrepot_grenoble`, **1** if there is *entrepot* in *Grenoble*, **0** otherwise.

## Constraints

1. There is exactly **1** *entrepot*: `entrepot_lyon + entrepot_grenoble <= 1`.

2. If there is *entrepot*, there must be *usine* in the same place:
 - For *Lyon*, `entrepot_lyon <= usine_lyon`,

 - For *Grenoble*, `entrepot_grenoble <= usine_grenoble`.

3. You can spend at most **10 millions**, knowing the prices of each constructions : `usine_lyon * 6 + usine_grenoble * 3 + entrepot_lyon * 5 + entrepot_grenoble * 2 <= 10`.

## Optimise

You want to maximise the benefits, knowing the benefits of each construction: `Maximise usine_lyon * 9 + usine_grenoble * 5 + entrepot_lyon * 6 + entrepot_grenoble * 4`.

## Solution

```
Problem Status -> Optimal : Maximize
OBJ -> 9.0
Entrepot_Grenoble -> 1.0
Entrepot_Lyon -> 0.0
Usine_Grenoble -> 1.0
Usine_Lyon -> 0.0
```

### Optimise ratio `gains / couts`

*This operation in none linear, and thus cannot be solve with PuLP.*

# Gateaux (3) `./gateaux.py`

*Global* is what we have, *Tarte Banane* and *Tarte Chocolat* are object we what to create with what we have. We what to optimise the total **price**.

### Global

Attribute | Value
-- | --
*Farine* | 4000
*Banane* | 6
*Cacao* | 500
*Sucre* | 2000
*Beurre* | 500

### Tarte Banane

Attribute | Value
-- | --
*Farine* | 250
*Banane* | 2
*Cacao* | 0
*Sucre* | 75
*Beurre* | 100
**Price** | 4

### Tarte Chocolat

Attribute | Value
-- | --
*Farine* | 200
*Banane* | 0
*Cacao* | 75
*Sucre* | 150
*Beurre* | 150
**Price** | 4

## Variables

We define **4** *integer* variables greater than **0**.

- `banane`, the number of *tarte banane*.

- `chocolat`, the number of *tarte chocolat*.

## Constraints

1. There is **4000**g of *farine*: `250 * banane + 200 * chocolat <= 4000`.

2. There is **6** *banane*: `2 * banane  <= 6`.

3. There is **500**g of *cacao*: `75 * chocolat <= 500`.

4. There is **2000**g of *sucre*: `75 * banane + 150 * chocolat <= 2000`.

5. There is **500**g of *beurre*: `100 * banane + 150 * chocolat <= 500`.

## Optimise

You want to maximise the benefits (*price*): `Maximise 4 * banane + 4.5 * chocolat`.

## Solution

```
Problem Status -> Optimal : Maximize
OBJ -> 17.0
Tarte_Banane -> 2.0
Tarte_Chocolat -> 2.0
```

# Regression (3) `./regression.py`

## Variables

- `a`, the regression slope.

- `b`, the regression intersection.

- `errors`, the `array` of `floats` that contains the error for each input point.

## Constraints

We define `2`constraints for each point.

These `2` constraints translate `|ax + b - y| <= error`.

- `error >= a * points[i][0] + b - points[i][1]`, when `|ax + b - y|` is positive.

- `error >= -(a * points[i][0] + b - points[i][1])`, when `|ax + b - y|` is negative.

## Optimise

We want to minimise the sum of `errors`.

## Solution

```
Problem Status -> Optimal : Minimize
OBJ -> 0.7981818140000001
Err_0 -> 0.072727273
Err_1 -> 0.084848485
Err_10 -> 0.096969697
Err_11 -> 0.063636364
Err_12 -> 0.021212121
Err_2 -> 0.14242424
Err_3 -> 0.0
Err_4 -> 0.057575758
Err_5 -> 0.095151515
Err_6 -> 0.027272727
Err_7 -> 0.024242424
Err_8 -> 0.11212121
Err_9 -> 0.0
  a -> 0.51515152
  b -> 3.0121212
```

We compare this resultat with the analytic result (calculated in `formula_minimise_square`)

```
{a: 0.5246102167575096, b: 2.963878818608192}
```

Results are different but close (difference in `O(1e-1)`).

# Voyage (2) `./voyage.py`

## Variables

We define binary variable for each travel we can perform. There is **4** cities, so **6** different travels.

- `lyon_st_etienne`, **1** if you go from *Lyon* to *St-Etienne* (or the other way around), **0** otherwise.

- `lyon_valence`, **1** if you go from *Lyon* to *Valence* (or the other way around), **0** otherwise.

- `lyon_grenoble`, **1** if you go from *Lyon* to *Grenoble* (or the other way around), **0** otherwise.

- `st_etienne_valence`, **1** if you go from *St-Etienne* to *Valence* (or the other way around), **0** otherwise.

- `st_etienne_grenoble`, **1** if you go from *St-Etienne* to *Grenoble* (or the other way around), **0** otherwise.

- `grenoble_valence`, **1** if you go from *Grenoble* to *Valence* (or the other way around), **0** otherwise.

## Constraints

You want to do a loop through all **4** cities. So each city must be linked to exactly **2** travels

- For *Lyon*: `lyon_st_etienne + lyon_valence + lyon_grenoble == 2`.

- For *St-Etienne*: `lyon_st_etienne + st_etienne_valence + st_etienne_grenoble == 2`.

- For *Valence*: `lyon_valence + st_etienne_valence + grenoble_valence == 2`.

- For *Grenoble*: `lyon_grenoble + st_etienne_grenoble + grenoble_valence == 2`.

## Optimise

You want to minimise the distance you travel: `26 * lyon_st_etienne + 34 * lyon_valence + 78 * lyon_grenoble + 18 * st_etienne_valence + 52 * st_etienne_grenoble  + 51 * grenoble_valence`

*You cannot use less than 6 variables, indeed, the problem is defined by 6 values, each values is assigned to exactly one variable here.*

## Solution

```
Problem Status -> Optimal : Minimize
OBJ -> 163.0
Grenoble_Valence -> 1.0
Lyon_Grenoble -> 0.0
Lyon_St_Etienne -> 1.0
Lyon_Valence -> 1.0
St_etienne_Grenoble -> 1.0
St_etienne_Valence -> 0.0
```

The optimal way is ***Lyon* - *St-Etienne* - *Grenoble* - *Valence* - *Lyon***.





# Coloration (2) `./coloration.mzn`

## Variables

We define `a`, `b`, `c`, `d`, `e`, `f`, the six edges of the graph.

- `a` is linked to everyone but `f`.
- `b` is linked to everyone but `e`.
- `c` is linked to everyone but `d`.
- `d` is linked to everyone but `c`.
- `e` is linked to everyone but `b`.
- `f` is linked to everyone but `a`.

We define `n` the number of colour. Each value `a`, `b`, `c`, `d`, `e`, `f` is within `1` and `n` and corresponds to its colour.

## Constraints

We first declare `2 * 6` constraints to ensure that each edge's colours is within `[1 .. n]`.

Then we define `4 * 6` constraints to ensure that each edge's colours is not the same as its neighbour's colour.

## Optimise

We minimise `n` the number of colour.

## Solution

```
n = 3;
a = 1;
b = 2;
c = 3;
d = 3;
e = 2;
f = 1;
```

**The minimum number of colour is `3`.**

# Jobshop (5) `./jobshop.py`

## Variables

we define `4` arrays  or size `size`to hold the data of the problem.

- `tasks`, `array of string` with the name of the tasks.

- `releases`, `array of int` with the times after which each task can start to be done .

- `durations`, `array of int` with the times needed for each task to be done.

- `dues`, `array of int` with the times when each task need to be finished.

We define a `array of int` `starts` of size `size` to hold the starts time, and a `int` variable `past` that hold the sum of each delays.

## Constraints

For all tasks, the `start` time must be greater than (*which means later than*) the `release` time.

No task should overlap, that means that for each pair of task, there is at least one than ends before the other starts.

## Optimise

We minimise `past` the sum of delays.

## Solution

**We've reorganised the solution as a table to improve readability.**


**TOTAL PAST = 16**
Task | Release | Duration | Due | Start | Past
-- | -- | -- | -- | -- | --
A | 2 | 5 | 10 | 6 | 1
B | 5 | 6 | 21 | 14 | 0
C | 4 | 8 | 15 | 22 | 15
D | 0 | 4 |10 | 2 | 0
E | 0 | 2 | 5 | 0 | 0
F | 8 | 3 | 15 | 11 | 0
G | 9 | 2 | 22 | 20 | 0


# Jesuites (5) `./jesuites.mzn`

## Variables

We define `3` `set of int` to store the dimensions of the problem and a 3-dimentional `cube` variable that stores boolean variables.

For a given `week`, `task`, and `volonteer`, `cube[week, task, volonteer]` is `true` if and only if this given `volonteer` performs the task `task` on week `week`.

## Constraints

We want each task to be performed each week. Each task need `2` `volonteers` but the trash which has index `4`.

```
constraint forall(w in weeks)(
forall(t in tasks)(
if t == 4 then sum(cube[w, t, volonteers]) = 1 else sum(cube[w, t, volonteers]) = 2 endif
));
```

All team must be different, so each `volonteer` always works with a different `volonteer`.

```
constraint forall(w1, w2 in weeks where w1 != w2)(
forall(t1, t2 in tasks)(
cube[w1, t1, volonteers] != cube[w2, t2, volonteers]
));
```

Each `volonteer` must exucute, one, and only one, task per week.

```
constraint forall(w in weeks)(
forall(v in volonteers)(
sum(cube[w, tasks, v]) = 1
));
```

Because there are `7` weeks, there are `4` tasks that needs `7` `volonteers` to be performed, and there is not two times the same pair of `volonteer`, each `volonteer` will perform each task twice (so no need to impose this constraint). 

## Optimise

We satisfy the constraints.

## Solution

**We've replace `true` with `X` and `false` with `-` to improve readability.**

```
Semaine: 1
   Volonteer: 1	2	3	4	5	6	7
   Kitchen:   -	X	-	-	-	X	-
   Bathroom:  -	-	X	-	X	-	-
   Common:    X	-	-	X	-	-	-
   Trash:     -	-	-	-	-	-	X

Semaine: 2
   Volonteer: 1	2	3	4	5	6	7
   Kitchen:   X	-	-	-	X	-	-
   Bathroom:  -	X	-	X	-	-	-
   Common:    -	-	X	-	-	-	X
   Trash:     -	-	-	-	-	X	-

Semaine: 3
   Volonteer: 1	2	3	4	5	6	7
   Kitchen:   X	-	-	-	-	X	-
   Bathroom:  -	-	X	X	-	-	-
   Common:    -	X	-	-	-	-	X
   Trash:     -	-	-	-	X	-	-

Semaine: 4
   Volonteer: 1	2	3	4	5	6	7
   Kitchen:   -	-	X	-	-	X	-
   Bathroom:  -	X	-	-	X	-	-
   Common:    X	-	-	-	-	-	X
   Trash:     -	-	-	X	-	-	-

Semaine: 5
   Volonteer: 1	2	3	4	5	6	7
   Kitchen:   -	-	-	X	-	X	-
   Bathroom:  -	-	-	-	X	-	X
   Common:    X	X	-	-	-	-	-
   Trash:     -	-	X	-	-	-	-

Semaine: 6
   Volonteer: 1	2	3	4	5	6	7
   Kitchen:   -	-	-	-	X	X	-
   Bathroom:  -	-	-	X	-	-	X
   Common:    X	-	X	-	-	-	-
   Trash:     -	X	-	-	-	-	-

Semaine: 7
   Volonteer: 1	2	3	4	5	6	7
   Kitchen:   -	-	-	-	-	X	X
   Bathroom:  -	-	-	X	X	-	-
   Common:    -	X	X	-	-	-	-
   Trash:     X	-	-	-	-	-	-
```

# Ateliers Vehicules (5) `./ateliers-vehicules.mzn`

## Variables

We define `4` `set of int` to store the dimensions of the problem and a 4-dimentional `matrix` variable that stores boolean variables.

For a given `atelier`, `operateur`, `voiture`, and `temps`, `matrix[ateliers, operateurs, voitures, temps]` is `true` if and only if this givent `operateur` works on this given `voiture` at this given `temps` in this given `atelier`.

## Constraints

Each `voiture` has to go through each `atelier` exactly once.

```
constraint forall(v in voitures)(
sum(matrix[ateliers, operateurs, v, temps]) = 4
);

```

Each `operateur` cannot work more than the capacity of the `atelier` he or she is working in at this a given `temps`.

```
constraint forall(o in operateurs)(
forall(a in ateliers)(
forall(t in temps)(
sum(matrix[a, o, voitures, t]) <= ateliers_load[a]
)));
```

Each `operateur` cannot work on more than one `atelier` at a time.

```
constraint forall(o in operateurs)(
forall(t in temps)(
forall(v in voitures)(
sum(matrix[ateliers, o, v, t]) <= 1
)));
```

Each `operateur` cannot work on any `atelier` if he or she is not here.
```
constraint forall(o in operateurs)(
forall(t in temps where t < operateur_start[o])(
sum(matrix[ateliers, o, voitures, t]) = 0
));

constraint forall(o in operateurs)(
forall(t in temps where t > operateur_end[o])(
sum(matrix[ateliers, o, voitures, t]) = 0
));
```

## Optimise

We satisfy the constraints

## Solution

*MiniZinc ran for more than 5 minutes 41 seconds and returns `=====UNKNOWN=====`.* 

# Restaurant (5) `./restaurant.mzn`

## Variables

We define a `program`, with `14` rows corresponding to each day, and `40 > 38` columns corresponding to each employees.

There are at most `38` employees, indeed, the maximum number of employees needed is `19` on Thursday, and `19 * 2 = 38`.

We count the optimal number of employee with the variable `number_of_employee`.

We use `14` rows instead of `7` to avoid using the modulo operator. So, for example, Monday is `1` and `8`. So we can more easily perform the shift of `5` days per worker.

## Constraints

The number of employee optimal should be between 1 and 40.

```
constraint number_of_employee >= 1 /\ number_of_employee <= 40;
```

Each day should have the correct number of employees, define in `DATA:requires`.


```
constraint forall(w in week)(
sum(program[w, maximum_set_of_employee]) + sum(program[w + 7, maximum_set_of_employee]) >= requires[w]
);
```

The employee that have an index greater than the optimal number of employee should not work.

```
constraint forall(e in maximum_set_of_employee where e > number_of_employee)(
sum(program[1..14, e]) = 0
);
```

Each employee should not work more than 5 days a week

```
constraint forall(e in maximum_set_of_employee where e <= number_of_employee)(
sum(program[1..14, e]) = 5
);
```

If an employee start working on a day, he or she works the 4 following days.

```
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
```

## Optimise

We minimise the `number_of_employee` : `solve minimize number_of_employee;`.

## Solution

In a first run with found `34` employees, however we made an error on the constraint concerning the employees that shouldn't work :

```
constraint forall(e in maximum_set_of_employee where e > number_of_employee)(
sum(program[1..7, e]) = 0
);
```

Instead of:

```
constraint forall(e in maximum_set_of_employee where e > number_of_employee)(
sum(program[1..14, e]) = 0
);
```

When we corrected the bug, *Minizinc* didn't found a solution.

The solution found with the bug was:

Day | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 | 34
-- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --
Monday | X | - | - | - | - | - | - | - | - | - | - | - | - | - | - | X | X | X | X | X | X | X | X | X | X | X | X | X | - | - | - | - | - | -
Tuesday | X | X | X | X | X | X | X | X | X | X | X | X | X | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | -
Wednesday | X | - | - | - | - | - | - | - | - | - | - | - | X | X | X | - | - | - | - | X | X | X | X | X | X | X | X | X | X | X | - | - | -
Thursday | X | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X
Friday | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | - | - | - | - | - | - | - | - | - | - | - | - | - | - | -
Saturday | - | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | X | - | - | - | - | - | - | - | - | - | - | - | - | - | - | -
Sunday | - | X | X | X | X | X | X | X | X | X | X | X | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | -


*As you can see, the solution doesn't satisfy the constraint ... We don't understand why.*




