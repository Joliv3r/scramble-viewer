#!/bin/bash

HEADER="\e[32mASD\$\e[0m "

HELP="
Usage: display-scrambles [OPTION]
Changes scrambles at another scrambler PC.

Options:
  help                        shows this text
  init <competition-id>       initializes program to work with the competition
  next                        changes to the next scramble set
  set <scramble-set>          changes to the given scramble set
  sort <competition-id>       sorts the schedule
  wait                        changes to the waiting screen

if no option is given you will be taken to an interactive shell where all the commands are the same.
"

ACTIVE_PATH="./last-scramble-set"
WAIT_PATH="./scrambles/waiting.pdf"

handle_input() {
  case "$1" in
    "help") echo "$HELP" ;;
    "init") rm -f $ACTIVE_PATH && bash ./change-scramble-set.sh "wait" && bash ./sort-events.sh $2 ;;
    "next") bash ./show-next-scramble-set.sh ;;
    "set") bash ./set-scrambles.sh $2 $3 $4 ;;
    "wait") bash ./change-scramble-set.sh "wait" ;;
    "sort") bash ./sort-events.sh $2 ;;
    "exit") exit 0 ;;
    *) echo "$1 is not a valid option, type help if you are unsure of what you are doing."
  esac
}

if [ ! $# -eq 0 ]; then
  handle_input $@
  exit 0
fi

while true; do
  echo -en "$HEADER"
  read ANSWER
  handle_input $ANSWER
done
