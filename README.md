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

# BIP

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

You want to maximise the benefits, knowing the benefits of each construction : `Maximise usine_lyon * 9 + usine_grenoble * 5 + entrepot_lyon * 6 + entrepot_grenoble * 4`.

### Optimise ratio `gains / couts`

*This operation in none linear, and thus cannot be solve with PuLP.*
