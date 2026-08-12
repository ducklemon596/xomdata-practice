# Xom Data · Flatten grouped results by one level
# Problem: https://xomdata.com/practice/py-flatten-one-level
# Solved: 2026-08-12

def flatten(groups):
    return [x for lst in groups for x in lst]
