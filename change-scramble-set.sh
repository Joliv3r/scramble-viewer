if [ $# -eq 0 ]; then
  echo "I need a scramble set to change"
  exit 1
fi

SCRAMBLE_DIR="./scrambles/"
SCRAMBLE_SET_TO_CHANGE=$1
WAIT_FILE="waiting.pdf"
WAIT_PATH="$SCRAMBLE_DIR$WAIT_FILE"
SSH_PATH=$(cat ./.ssh_path)
PATH_TO_REPLACE="$SSH_PATH:~/currently-active.pdf"
REPLACE_METHOD="scp"

if [ "$SCRAMBLE_SET_TO_CHANGE" = "wait" ]; then
  $REPLACE_METHOD "$WAIT_PATH" $PATH_TO_REPLACE
  exit 0
fi

if [ ! -f "$SCRAMBLE_DIR$SCRAMBLE_SET_TO_CHANGE" ]; then
  echo "$SCRAMBLE_SET_TO_CHANGE is not a valid scramble set..."
  exit 1
fi

echo -n "Do you want to display $SCRAMBLE_SET_TO_CHANGE? [y/N] " 
read answer

case $answer in 
  y|Y) $REPLACE_METHOD "$SCRAMBLE_DIR$SCRAMBLE_SET_TO_CHANGE" $PATH_TO_REPLACE ;;
  *) echo "Nothing was done" ;;
esac
