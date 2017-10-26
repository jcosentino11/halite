#!/bin/sh

if [ "$#" -eq 2 ]; then
	# Have two bots fight each other
	./halite -d "240 160" "python3 $1.py" "python3 $2.py"
elif [ "$#" -eq 1 ]; then
	# Have a bot fight itself
	./halite -d "240 160" "python3 $1.py" "python3 $1.py"
else
	echo "Usage: ./game.sh <bot-name> [opponent-bot-name]"
fi