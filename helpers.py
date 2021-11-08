from pulp import *

def print_problem(problem):
    print(problem)
    print(f'Problem Status -> {LpStatus[problem.status]} : {LpSenses[problem.sense]}')
    print(f'{problem.objective.name:>3} -> {value(problem.objective)}')
    for v in problem.variables():
        print(f'{str(v):>3} -> {value(v)}')
