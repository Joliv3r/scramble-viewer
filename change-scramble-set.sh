#!/bin/bash

if [ $# -eq 0 ]; then
  echo "I need a scramble set to change"
  exit 1
fi

SCRAMBLE_SET_TO_CHANGE=$1

echo -n "Do you want to display $SCRAMBLE_SET_TO_CHANGE? [y/N] " 
read answer

case $answer in 
  y|Y) cp "./scrambles/$SCRAMBLE_SET_TO_CHANGE" ./scrambles/currently-active.pdf ;;
  *) echo "Nothing was done" ;;
esac
