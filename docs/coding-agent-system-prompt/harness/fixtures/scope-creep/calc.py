"""A simple calculator module with a bug and tempting adjacent refactoring."""

def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    # bug: returns a / b instead of a * b
    return a / b

def divide(a, b):
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
