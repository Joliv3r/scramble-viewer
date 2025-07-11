#!/bin/bash

HEADER="\e[32mASD\$\e[0m "

HELP="
Usage: display-scrambles [OPTION]
Changes scrambles at another scrambler PC.

Options:
  clean                       removes all generated files
  current                     shows currently active pdf
  help                        shows this text
  init <competition-id>       initializes program to work with the competition
  next                        changes to the next scramble set
  set <scramble-set>          changes to the given scramble set
  sort <competition-id>       sorts the schedule
  wait                        changes to the waiting screen

if no option is given you will be taken to an interactive shell where all the commands are the same.
"

ACTIVE_PATH="./last-scramble-set"
LOG_PATH="./log"
WAIT_PATH="./scrambles/waiting.pdf"

handle_input() {
  case "$1" in
    "help") echo "$HELP" ;;
    "init") 
      echo -n "Are you sure you want to initialize. [y/N] "
      read ANSWER
      case "$ANSWER" in
        y|Y) rm -f $ACTIVE_PATH \
          && bash ./change-scramble-set.sh "wait" \
          && bash ./sort-events.sh $2 \
          && export COMPETITION_NAME=$(cat trondheimfriends2024-json | jq '.["name"]' | sed -r 's/[^[:alnum:][:space:]]//g') ;;
        *) echo "Nothing was done."
      esac ;;
    "next") bash ./show-next-scramble-set.sh ;;
    "set") bash ./set-scrambles.sh $2 $3 $4 ;;
    "wait") bash ./change-scramble-set.sh "wait" ;;
    "sort") bash ./sort-events.sh $2 ;;
    "current") cat $ACTIVE_PATH ;;
    "clean")
      echo -n "Are you sure you want to clean all temporary files, this will delete the log file and the schedule. [y/N] "
      read ANSWER
      case "$ANSWER" in
        y|Y) rm -f $ACTIVE_PATH $LOG_PATH *-json ;;
        *) echo "Nothing was done."
      esac ;;
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
