from pulp import *
solver = get_solver('PULP_CBC_CMD', msg=0) # To avoid unnecessary logs

# Define Variables
usine_lyon = LpVariable('Usine_Lyon', 0, 1, LpInteger)
usine_grenoble = LpVariable('Usine_Grenoble', 0, 1, LpInteger)
entrepot_lyon = LpVariable('Entrepot_Lyon', 0, 1, LpInteger)
entrepot_grenoble = LpVariable('Entrepot_Grenoble', 0, 1, LpInteger)

# Create Problem
def maximise_benefits():
    problem = LpProblem('BIP_Problem', LpMaximize)

    problem += entrepot_lyon + entrepot_grenoble <= 1

    problem += entrepot_lyon <= usine_lyon
    problem += entrepot_grenoble <= usine_grenoble

    problem += usine_lyon * 6 + usine_grenoble * 3 + entrepot_lyon * 5 + entrepot_grenoble * 2 <= 10

    problem += usine_lyon * 9 + usine_grenoble * 5 + entrepot_lyon * 6 + entrepot_grenoble * 4

    status = problem.solve(solver)

    print_problem(problem)

def maximise_ratio():
    # Returns an error -> None linear optimisation
    problem = LpProblem('BIP_Problem', LpMaximize)

    problem += entrepot_lyon + entrepot_grenoble <= 1

    problem += entrepot_lyon <= usine_lyon
    problem += entrepot_grenoble <= usine_grenoble

    problem += (usine_lyon * 9 + usine_grenoble * 5 + entrepot_lyon * 6 + entrepot_grenoble * 4) / (usine_lyon * 6 + usine_grenoble * 3 + entrepot_lyon * 5 + entrepot_grenoble * 2)

    status = problem.solve(solver)

    print_problem(problem)

def print_problem(problem):
    print(problem)
    print(f'Problem Status -> {LpStatus[problem.status]} : {LpSenses[problem.sense]}')
    print(f'{problem.objective.name:>3} -> {value(problem.objective)}')
    for v in problem.variables():
        print(f'{str(v):>3} -> {value(v)}')

if __name__ == '__main__':
    maximise_ratio()
