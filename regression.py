# IBM CPLEX

from pulp import *
from helpers import print_problem
solver = get_solver('PULP_CBC_CMD', msg=0) # To avoid unnecessary logs

points = [(1.0, 3.6), (1.5, 3.7), (2.0, 3.9), (2.5, 4.3), (3.0, 4.5), (3.5, 4.72), (4.0, 5.1), (4.2, 5.2), (5.0, 5.7), (5.8, 6.0), (6.0, 6.2), (6.7, 6.4), (7.2, 6.7)]

# Define Variables
a, b = LpVariable('a'), LpVariable('b')
errors = [LpVariable(f'Err_{i}') for i in range(len(points))]

# Create Problem
def minimise_errors():
    problem = LpProblem('Voyage', LpMinimize)

    for i, error in enumerate(errors):
        problem += error >= a * points[i][0] + b - points[i][1]
        problem += error >= -(a * points[i][0] + b - points[i][1])

    problem += lpSum(errors)

    status = problem.solve(solver)

    print_problem(problem)

def formula_minimise_square():
    n = len(points)
    a_num = n * sum([point[0] * point[1] for point in points]) -  sum([point[0] for point in points]) * sum([point[1] for point in points])

    b_num = sum([point[0] * point[0] for point in points]) * sum([point[1] for point in points]) -  sum([point[0] for point in points]) * sum([point[0] * point[1] for point in points])

    den = n * sum([point[0] * point[0] for point in points]) -  sum([point[0] for point in points]) * sum([point[0] for point in points])

    return a_num / den, b_num / den

if __name__ == '__main__':
    print(formula_minimise_square())
