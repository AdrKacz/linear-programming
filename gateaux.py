from pulp import *
from helpers import print_problem
solver = get_solver('PULP_CBC_CMD', msg=0) # To avoid unnecessary logs

# Define Variables
banane = LpVariable('Tarte_Banane', lowBound=0, cat=LpInteger)
chocolat = LpVariable('Tarte_Chocolat', lowBound=0, cat=LpInteger)

## Create Problem
def maximise_benefits():
    problem = LpProblem('Gateaux', LpMaximize)

    problem += 250 * banane + 200 * chocolat <= 4000
    problem += 2 * banane  <= 6
    problem += 75 * chocolat <= 500
    problem += 75 * banane + 150 * chocolat <= 2000
    problem += 100 * banane + 150 * chocolat <= 500

    problem += 4 * banane + 4.5 * chocolat

    status = problem.solve(solver)

    print_problem(problem)

if __name__ == '__main__':
    maximise_benefits()
