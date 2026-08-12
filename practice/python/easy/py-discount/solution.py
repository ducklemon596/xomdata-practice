# Xom Data · Compute price after discount
# Problem: https://xomdata.com/practice/py-discount
# Solved: 2026-08-12

def final_price(price, percent):
    return round(price - price * percent / 100, 2)
