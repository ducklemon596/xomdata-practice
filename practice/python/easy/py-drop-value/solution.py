# Xom Data · Remove a code from the scan list
# Problem: https://xomdata.com/practice/py-drop-value
# Solved: 2026-08-12

def drop_value(items, target):
    lst = []

    for item in items:
        if item != target:
            lst.append(item)

    return lst
