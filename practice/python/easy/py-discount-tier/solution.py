# Xom Data · Discount tier by order value
# Problem: https://xomdata.com/practice/py-discount-tier
# Solved: 2026-08-12

def discount_percent(total):
    if total < 500000:
        return 0
    elif total < 2000000:
        return 5
    else:
        return 10
