# Xom Data · Divide safely when the divisor can be zero
# Problem: https://xomdata.com/practice/py-safe-divide
# Solved: 2026-08-11

def safe_divide(a, b):
    if b == 0:
        return None
    return round(a/b, 2)
