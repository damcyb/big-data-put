#!/usr/bin/env python3
import sys

current_install_year = None
current_install_dockcount = 0
current_install_count = 0

current_title = None
current_actorcount = 0
title = None

for line in sys.stdin:
    title, actor_count = line.strip().split("\t")
    actor_count = int(actor_count.strip())
    if current_title == title:
        current_actorcount += actor_count
    else:
        if current_title:
            print(f"{current_title}\t{current_title},{current_actorcount}")
        current_title = title
        current_actorcount = actor_count
if current_title == title:
    print(f"{current_title}\t{current_title},{current_actorcount}")

