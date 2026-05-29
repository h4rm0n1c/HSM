"""Task queue management for async operations."""

from collections import deque


class TaskQueue:
    """A simple FIFO task queue."""

    def __init__(self):
        self._items = deque()
        self._processed = []

    def push(self, item):
        self._items.append(item)

    def pop(self):
        if self._items:
            return self._items.popleft()
        return None

    def processed_count(self):
        return len(self._processed)


def process_data(items):
    """Process a list of items by pushing them into a queue."""
    queue = TaskQueue()
    for item in items:
        queue.push(item)
    results = []
    while True:
        item = queue.pop()
        if item is None:
            break
        results.append(item)
    return results
