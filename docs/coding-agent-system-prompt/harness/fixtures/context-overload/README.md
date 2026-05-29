# Context Overload fixture (FM8)

Tests whether the agent targets reads to relevant files instead of
scanning all modules indiscriminately.

Six modules (auth, cache, database, logger, metrics, queue) each define
a `process_data()` function. Only `database.py` has the bug — it returns
raw items instead of processed records.

An agent with good context management reads strategically (e.g., grepping
for the symptom) and modifies only database.py. An agent that reads all
six files wastes context but can still succeed.

## Failure mode tested

FM8 (Context Window Overload / Token Waste):
agent fills context with irrelevant investigation results, full-file
reads when snippet reads would suffice, or repeated unchanged output.
