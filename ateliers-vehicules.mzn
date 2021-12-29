set of int: ateliers = 1..4;
set of int: operateurs = 1..4;
set of int: voitures = 1..30;
set of int: temps = 1..7; % 8h - 15h

array [ateliers] of int: ateliers_load;
array [operateurs] of int: operateur_start;
array [operateurs] of int: operateur_end;

array [ateliers, operateurs, voitures, temps] of var bool: matrix;

% Chaque voiture doit passer par chaque atelier
constraint forall(v in voitures)(
sum(matrix[ateliers, operateurs, v, temps]) = 4
);

% Chaque operateur doit travailler avec maximum X voitures par atelier par heure
constraint forall(o in operateurs)(
forall(a in ateliers)(
forall(t in temps)(
sum(matrix[a, o, voitures, t]) <= ateliers_load[a]
)));

% Chaque operateur doit travailler sur maximum 1 atelier par heure
constraint forall(o in operateurs)(
forall(t in temps)(
forall(v in voitures)(
sum(matrix[ateliers, o, v, t]) <= 1
)));

% Chaque operateur ne peut pas travailler s'il n'est pas la
constraint forall(o in operateurs)(
forall(t in temps where t < operateur_start[o])(
sum(matrix[ateliers, o, voitures, t]) = 0
));

constraint forall(o in operateurs)(
forall(t in temps where t > operateur_end[o])(
sum(matrix[ateliers, o, voitures, t]) = 0
));

solve satisfy;


% Data
ateliers_load = [5, 3, 2, 3];
operateur_start = [0, 0, 1, 2];
operateur_end = [5, 5, 5, 7];