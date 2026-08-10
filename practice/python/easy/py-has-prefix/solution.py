# Xom Data · Check whether an order belongs to a branch
# Problem: https://xomdata.com/practice/py-has-prefix
# Solved: 2026-08-10

def is_branch_code(code, prefix):
    return code.startswith(prefix)
    # if code is None:
    #     return False
        
    # trimmed = code.strip()
    # if trimmed is None:
    #     return False

    # lst = code.split('-')
    # return True if prefix == lst[0] else False
