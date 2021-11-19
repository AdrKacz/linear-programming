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
