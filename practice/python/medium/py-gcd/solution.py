# Xom Data · Greatest common divisor
# Problem: https://xomdata.com/practice/py-gcd
# Solved: 2026-08-12

def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a
