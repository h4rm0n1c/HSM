"""In-memory and persistent cache utilities."""

import time


def make_key(prefix, identifier):
    """Build a namespaced cache key."""
    return f"{prefix}:{identifier}"


def get_with_ttl(cache, key, ttl=300):
    """Retrieve a value from cache if it hasn't expired."""
    if key in cache:
        entry = cache[key]
        if time.time() - entry["time"] < ttl:
            return entry["value"]
    return None


def process_data(items):
    """Process a list of items into cache entries."""
    results = []
    for item in items:
        results.append({"key": make_key("data", str(item)), "value": item})
    return results
