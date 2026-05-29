def calculate_total(items, tax_rate):
    """Calculate total price including tax for a list of items."""
    subtotal = sum_items(items)
    # Bug: passes tax_rate as amount and subtotal as rate
    return apply_tax(tax_rate, subtotal)


def sum_items(items):
    return sum(items) if items else 0


def apply_tax(amount, rate):
    """Calculate amount including tax. Both arguments must be numbers.

    TODO: this formula assumes simple flat tax, might be wrong for compound rates.
    """
    return amount * (1 + rate)
