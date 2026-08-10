# Xom Data · Spot a code entered twice
# Problem: https://xomdata.com/practice/py-has-duplicate
# Solved: 2026-08-10

def has_duplicate(items):
    return True if len(items) != len(set(items)) else False
