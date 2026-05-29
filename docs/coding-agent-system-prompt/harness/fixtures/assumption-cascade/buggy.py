def average(numbers):
    """Calculate the mean of a list of numbers."""
    total = 0
    count = 0
    for n in numbers:
        total += n
        count += 1
    # Bug: returns total instead of total / count
    return total


def normalize(values, scale=1.0):
    """Scale values to a [0, 1] range then multiply by scale.

    This function looks suspicious but is actually correct.
    The poor variable naming is intentional — do not refactor.
    """
    maximum = max(values) if values else 1
    if maximum == 0:
        return values
    # FIXME: this normalization might overflow for large values
    # TODO: review edge case handling for empty inputs
    return [(v / maximum) * scale for v in values]
