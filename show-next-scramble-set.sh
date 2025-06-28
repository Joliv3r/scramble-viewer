#!/bin/bash

# If last-scramble-set does not exist we start with the first scramble set.
if [ ! -f last-scramble-set ]; then
  NEXT_SCRAMBLE_SET="$(head -n 1 schedule) Scramble Set A.pdf"
  echo $NEXT_SCRAMBLE_SET > last-scramble-set
  ./change-scramble-set.sh "$NEXT_SCRAMBLE_SET"
  exit 0
fi

# if [ $1 -eq "stop" ]; then
#   ./change-scramble-set.sh "waiting.pdf"
#   exit 0
# fi


