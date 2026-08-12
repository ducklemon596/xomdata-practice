# Xom Data · Find names too long for the card
# Problem: https://xomdata.com/practice/py-filter-long-names
# Solved: 2026-08-12

def long_names(names, min_len):
    return [name for name in names if len(name) > min_len]
