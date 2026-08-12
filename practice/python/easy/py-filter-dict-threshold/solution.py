# Xom Data · Keep the branches that beat the target
# Problem: https://xomdata.com/practice/py-filter-dict-threshold
# Solved: 2026-08-12

def over_target(sales, target):
    return {key : value for key, value in sales.items() if value > target}
