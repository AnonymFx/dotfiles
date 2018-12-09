#!/usr/bin/python

import i3ipc
import rofi
import sys
import time
from time import sleep

i3 = i3ipc.Connection()
menu = rofi.Rofi()

def scratchpad():
    for con in i3.get_tree():
        if(con.name == "__i3_scratch"):
            return con

def get_windows():
    wins = []
    names = []
    numEntries = 0
    for con in scratchpad():
        wins += con
    for con in wins:
        names.append(con.name)
        numEntries += 1
    return reversed(wins),reversed(names), numEntries

wins, names, numEntries = get_windows()
index, key = menu.select("Scratchpad",names)#,select="0 -theme /home/brian/.config/rofi/i3scratch.rasi")

if index < 0:
    sys.exit()

for i in range((numEntries - index)*2-1):
    i3.command("scratchpad show")

i3.command("resize set 1800 1012")
i3.command("move position center")
