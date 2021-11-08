from pulp import *
from helpers import print_problem
solver = get_solver('PULP_CBC_CMD', msg=0) # To avoid unnecessary logs

# Define Variables
lyon_st_etienne = LpVariable('Lyon_St_Etienne', 0, 1, LpInteger)
lyon_valence = LpVariable('Lyon_Valence', 0, 1, LpInteger)
lyon_grenoble= LpVariable('Lyon_Grenoble', 0, 1, LpInteger)
st_etienne_valence = LpVariable('St_etienne_Valence', 0, 1, LpInteger)
st_etienne_grenoble = LpVariable('St_etienne_Grenoble', 0, 1, LpInteger)
grenoble_valence = LpVariable('Grenoble_Valence', 0, 1, LpInteger)

# Create Problem
def minimise_distance():
    problem = LpProblem('Voyage', LpMinimize)

    problem += lyon_st_etienne + lyon_valence + lyon_grenoble == 2

    problem += lyon_st_etienne + st_etienne_valence + st_etienne_grenoble == 2

    problem += lyon_valence + st_etienne_valence + grenoble_valence == 2

    problem += lyon_grenoble + st_etienne_grenoble + grenoble_valence == 2

    problem += 26 * lyon_st_etienne + 34 * lyon_valence + 78 * lyon_grenoble + 18 * st_etienne_valence + 52 * st_etienne_grenoble  + 51 * grenoble_valence

    status = problem.solve(solver)

    print_problem(problem)

if __name__ == '__main__':
    minimise_distance()
