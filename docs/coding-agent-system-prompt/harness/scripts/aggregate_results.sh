#!/usr/bin/env bash
# Aggregate results from harness/results.csv
# Usage: aggregate_results.sh [results.csv path]
# Default: looks for results.csv in the directory containing this script

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HARNESS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CSV="${1:-$HARNESS_DIR/results.csv}"

if [ ! -f "$CSV" ]; then
  echo "Results CSV not found: $CSV" >&2
  exit 2
fi

# Strip surrounding quotes from CSV fields for reliable awk matching
strip_quotes() {
  sed 's/"\([^"]*\)"/\1/g'
}

echo "=== Aggregated Results ==="
echo "Source: $CSV"
echo ""

TOTAL=$(tail -n +2 "$CSV" | strip_quotes | wc -l)
echo "Total runs: $TOTAL"

if [ "$TOTAL" -eq 0 ]; then
  echo "No runs to report."
  exit 0
fi

echo ""

echo "--- By variant ---"
tail -n +2 "$CSV" | strip_quotes | awk -F',' '{print $3}' | sort | uniq -c | sort -rn | awk '{printf "  %s: %d runs\n", $2, $1}'

echo ""

echo "--- Validation state ---"
tail -n +2 "$CSV" | strip_quotes | awk -F',' '{print $8}' | sort | uniq -c | sort -rn | awk '{printf "  %s: %d\n", $2, $1}'

echo ""

PASSES=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$9=="true"' | wc -l)
FAILS=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$9=="false"' | wc -l)
echo "--- Patch correctness ---"
echo "  Pass:  $PASSES"
echo "  Fail:  $FAILS"
if [ "$TOTAL" -gt 0 ]; then
  RATE=$(echo "scale=1; $PASSES * 100 / $TOTAL" | bc 2>/dev/null || echo "?")
  echo "  Rate:  ${RATE}%"
fi

echo ""

LEAKS=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$10=="true"' | wc -l)
NOLEAKS=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$10=="false"' | wc -l)
NA=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$10=="na"' | wc -l)
echo "--- Persona leakage ---"
echo "  Leak detected:  $LEAKS"
echo "  No leak:        $NOLEAKS"
echo "  N/A (no agent): $NA"

echo ""

INSPECTED=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$7=="true"' | wc -l)
NOT_INSPECTED=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$7=="false"' | wc -l)
NA_INSPECT=$(tail -n +2 "$CSV" | strip_quotes | awk -F',' '$7=="na"' | wc -l)
echo "--- Inspection before edit ---"
echo "  Inspected:   $INSPECTED"
echo "  Not checked: $NOT_INSPECTED"
echo "  N/A:         $NA_INSPECT"

echo ""

echo "--- Changed files per run ---"
tail -n +2 "$CSV" | strip_quotes | awk -F',' '{print $5}' | sort -n | awk '
BEGIN{min=""; max=0; sum=0; count=0}
{
  if(min=="") min=$1;
  if($1>max) max=$1;
  if($1<min) min=$1;
  sum+=$1; count++
}
END{
  printf "  Min: %s\n", min
  printf "  Max: %d\n", max
  if(count>0) printf "  Avg: %.1f\n", sum/count
}'

echo ""
echo "=== End ==="
