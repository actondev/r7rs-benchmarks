#! /usr/bin/env bash

DIR="csv"

ALL_ROWS="$DIR/all.rows.csv"
ALL_TABLE="$DIR/all.csv"

> "$ALL_ROWS"
> "$ALL_TABLE"

for var in "$@"
do
    RESULT_OUT="results.$var"
    CSV_ROWS="$DIR/$var.rows.csv"
    CSV_TABLE="$DIR/$var.csv"

    [[ ! -f "$RESULT_OUT" ]] && echo "$RESULT_OUT doesn't exist, skipping" && continue

    echo "here $var"
    # 1st step: generating csv with 3 columns per row: scheme-name,test-name,time
    grep '+!CSVLINE' "$RESULT_OUT" | sed 's/+!CSVLINE!+//' | sed -E 's/(.*),([^:]+).*,(.*)/\1,\2,\3/g' > "$CSV_ROWS"

    # 2nd step: converting to "table" csv
    # also, keeps the last entry of a certain result (in case of duplicates)
    awk -F, -f process.awk "$CSV_ROWS" > "$CSV_TABLE"

    echo "Wrote $CSV_TABLE"

    # about all.csv
    echo cat "$CSV_ROWS" "$ALL_ROWS"
    cat "$CSV_ROWS" >> "$ALL_ROWS"
done

# now, combining them all into a csv
awk -F, -f process.awk "$ALL_ROWS" > "$ALL_TABLE"
echo "Wrote $ALL_TABLE"
