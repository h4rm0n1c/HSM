"""Application metrics collection and reporting."""

import time


def now_millis():
    """Return current time in milliseconds."""
    return int(time.time() * 1000)


def compute_percentile(values, percentile):
    """Compute a percentile from a sorted list of values."""
    if not values:
        return 0
    sorted_vals = sorted(values)
    idx = max(0, min(len(sorted_vals) - 1, int(len(sorted_vals) * percentile / 100)))
    return sorted_vals[idx]


def process_data(items):
    """Process a list of raw metric values into aggregated stats."""
    if not items:
        return {"count": 0, "sum": 0, "avg": 0}
    total = sum(items)
    return {
        "count": len(items),
        "sum": total,
        "avg": total / len(items),
    }
