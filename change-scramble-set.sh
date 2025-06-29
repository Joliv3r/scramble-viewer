#!/bin/bash

if [ $# -eq 0 ]; then
  echo "I need a scramble set to change"
  exit 1
fi

SCRAMBLE_DIR="./scrambles/"
SCRAMBLE_SET_TO_CHANGE=$1

if [ ! -f "$SCRAMBLE_DIR$SCRAMBLE_SET_TO_CHANGE" ]; then
  echo "$SCRAMBLE_SET_TO_CHANGE is not a valid scramble set..."
  exit 1
fi

echo -n "Do you want to display $SCRAMBLE_SET_TO_CHANGE? [y/N] " 
read answer

case $answer in 
  y|Y) cp "$SCRAMBLE_DIR$SCRAMBLE_SET_TO_CHANGE" ./scrambles/currently-active.pdf ;;
  *) echo "Nothing was done" ;;
esac
