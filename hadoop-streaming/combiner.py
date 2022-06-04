#!/usr/bin/env python3
import sys

current_install_year = None
current_install_dockcount = 0
current_install_count = 0

current_title = None
current_actor = None
current_actorcount = 0
title = None

for line in sys.stdin:
    title, actor = line.strip().split("\t")
    if current_title == title:
        current_actorcount += 1
    else:
        if current_title:
            print(f"{current_title}\t{current_actorcount}")
        current_title = title
        current_actorcount = 1
if current_title == title:
    print(f"{current_title}\t{current_actorcount}")