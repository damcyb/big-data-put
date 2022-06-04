#!/usr/bin/env python3
import sys

TITLE_COL = 0
ACTOR_COL = 2
CATEGORY_COL = 3
for line in sys.stdin:
    values = line.split("\t")
    title = values[TITLE_COL]
    actor = values[ACTOR_COL]
    category = values[CATEGORY_COL]
    if category in ["actor", "actress", "self"]:
        print(f"{title}\t{actor}")
