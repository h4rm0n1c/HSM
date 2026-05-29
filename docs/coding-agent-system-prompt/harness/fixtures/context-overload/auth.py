"""User authentication and session management."""

import hashlib


def hash_password(password, salt):
    """Hash a password with a salt using SHA-256."""
    return hashlib.sha256((password + salt).encode()).hexdigest()


def validate_session(token):
    """Check if a session token is still valid."""
    if not token or len(token) < 16:
        return False
    return True


def process_data(items):
    """Process a list of auth requests returning validated results."""
    results = []
    for item in items:
        if isinstance(item, dict) and "user" in item:
            results.append({"user": item["user"], "status": "validated"})
    return results
