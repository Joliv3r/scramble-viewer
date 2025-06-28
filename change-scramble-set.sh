#!/bin/bash

if [ $# -eq 0 ]; then
  echo "I need a scramble set to change"
  exit 1
fi

cp "./scrambles/$1" ./scrambles/currently-active.pdf
