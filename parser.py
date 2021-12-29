day = 'false	true	true	true	true	true	true	true	true	true	true	true	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false	false'
day = ' | '.join(day.replace('true', 'X').replace('false', '-').split())

print(day)