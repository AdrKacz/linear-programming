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

# BIP `./bip.py`

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

1. There is at most **1** *entrepot*: `entrepot_lyon + entrepot_grenoble <= 1`.

2. If there is *entrepot*, there must be *usine* in the same place:
 - For *Lyon*, `entrepot_lyon <= usine_lyon`,

 - For *Grenoble*, `entrepot_grenoble <= usine_grenoble`.

3. You can spend at most **10 millions**, knowing the prices of each constructions : `usine_lyon * 6 + usine_grenoble * 3 + entrepot_lyon * 5 + entrepot_grenoble * 2 <= 10`.

## Optimise

You want to maximise the benefits, knowing the benefits of each construction: `Maximise usine_lyon * 9 + usine_grenoble * 5 + entrepot_lyon * 6 + entrepot_grenoble * 4`.

## Solution

```
Problem Status -> Optimal : Maximize
OBJ -> 14.0
Entrepot_Grenoble -> 0.0
Entrepot_Lyon -> 0.0
Usine_Grenoble -> 1.0
Usine_Lyon -> 1.0
```

### Optimise ratio `gains / couts`

*This operation in none linear, and thus cannot be solve with PuLP.*

# Gateaux `./gateaux.py`

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
