LSS_FILE="./last-scramble-set"
SCHEDULE="./schedule"
SCRAMBLE_DIR="./scrambles/"

if [ ! -f $SCHEDULE ]; then
  echo "Need a schedule file to give next scramble set.\nConsider running ./sort-events.sh <competition-id>"
  exit 1
fi

# If last-scramble-set does not exist we start with the first scramble set.
if [ ! -f $LSS_FILE ]; then
  NEXT_SCRAMBLE_SET="$(head -n 1 $SCHEDULE) Scramble Set A.pdf"
  bash ./change-scramble-set.sh "$NEXT_SCRAMBLE_SET"
  exit 0
fi

LAST_SCRAMBLE_SET=$(cat $LSS_FILE)

INDEX=$((${#LAST_SCRAMBLE_SET}-5))
SET=${LAST_SCRAMBLE_SET:INDEX:1}
NEXT_SCRAMBLE_SET="${LAST_SCRAMBLE_SET:0:INDEX}$(echo $SET | tr 'A-Y' 'B-Z')${LAST_SCRAMBLE_SET:INDEX+1}"

if [ -f "$SCRAMBLE_DIR$NEXT_SCRAMBLE_SET" ]; then
  bash ./change-scramble-set.sh "$NEXT_SCRAMBLE_SET"
  exit 0
fi

PREVIOUS_ROUND=${LAST_SCRAMBLE_SET:0:$((${#LAST_SCRAMBLE_SET}-19))}
NEXT_SCRAMBLE_SET="$(grep -A1 "$PREVIOUS_ROUND" $SCHEDULE | tail -n 1) Scramble Set A.pdf"

if [ -f "$SCRAMBLE_DIR$NEXT_SCRAMBLE_SET" ]; then
  bash ./change-scramble-set.sh "$NEXT_SCRAMBLE_SET"
  exit 0
fi

echo "Was not able to find the next scramble set. Consider manually overwriting $LSS_FILE or maybe the competition is over?"
exit 1
