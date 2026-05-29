"""Logging configuration and helpers."""

import logging


def setup_logger(name, level=logging.INFO):
    """Configure and return a logger with the given name and level."""
    logger = logging.getLogger(name)
    logger.setLevel(level)
    if not logger.handlers:
        handler = logging.StreamHandler()
        formatter = logging.Formatter(
            "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)
    return logger


def process_data(items):
    """Process a list of log entries returning formatted messages."""
    results = []
    for item in items:
        if isinstance(item, str):
            results.append(f"[LOG] {item}")
        else:
            results.append(f"[LOG] {repr(item)}")
    return results
