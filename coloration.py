from pulp import *
from helpers import print_problem
solver = get_solver('PULP_CBC_CMD', msg=0) # To avoid unnecessary logs
