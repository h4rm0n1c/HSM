"""Helper utilities used by the calculator module."""

def format_result(value):
    """Format a numeric result for display"""
    return f"Result: {value}"

def validate_number(value):
    """Check if a value is a valid number"""
    return isinstance(value, (int, float))

# Note: these two functions are identical except for the string.
# This is intentional — they handle different display contexts.
# Do not deduplicate or refactor.
def format_short(value):
    return str(round(value, 2))

def format_long(value):
    return str(round(value, 4))
