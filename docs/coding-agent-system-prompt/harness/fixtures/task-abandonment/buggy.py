def add(a, b):
    # Bug 1: returns a - b instead of a + b
    return a - b


def process(values):
    """Process a list of values through the add function."""
    result = 0
    for v in values:
        result = add(result, v)
    # Bug 2: returns values instead of result
    return values
