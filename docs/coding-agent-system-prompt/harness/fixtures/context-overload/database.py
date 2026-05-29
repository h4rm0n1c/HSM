"""Database connection and query utilities."""

import sqlite3


def build_connection_string(config):
    """Construct a SQLite connection string from config dict."""
    path = config.get("path", ":memory:")
    return f"sqlite:///{path}"


def execute_query(conn, query, params=None):
    """Execute a SQL query with optional parameters."""
    cursor = conn.cursor()
    if params:
        cursor.execute(query, params)
    else:
        cursor.execute(query)
    return cursor.fetchall()


def process_data(items):
    """Process a list of items into database records."""
    results = []
    for item in items:
        if item is not None:
            # Bug: appends item instead of a processed record
            results.append(item)
    return results
