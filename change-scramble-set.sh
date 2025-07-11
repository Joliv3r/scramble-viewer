if [ $# -eq 0 ]; then
  echo "I need a scramble set to change"
  exit 1
fi

SCRAMBLE_DIR="./scrambles/"
SCRAMBLE_SET_TO_CHANGE=$1
WAIT_FILE="waiting.pdf"
WAIT_PATH="$SCRAMBLE_DIR$WAIT_FILE"
PATH_TO_REPLACE="$SSH_PATH:~/currently-active.pdf"
# PATH_TO_REPLACE="./scrambles/currently-active.pdf"
REPLACE_METHOD="scp -i $SSH_KEY"
LOG_FILE="./log"
LSS_FILE="./last-scramble-set"
PASSWORD_FILE="./scrambles/$COMPETITION_NAME - Computer Display PDF Passcodes - SECRET.txt"
TMP_SCRAMBLE="./scrambles/tmp.pdf"

log-change() {
  echo "$(date +"%H:%M:%S"): $SCRAMBLE_SET_TO_CHANGE" >> $LOG_FILE
}

decrypt-scramble() {
  LEN=${#SCRAMBLE_SET_TO_CHANGE}-2
  PASSWORD_LINE=$(cat "$PASSWORD_FILE" | grep "${SCRAMBLE_SET_TO_CHANGE:0:-4}")
  PASSWORD=${PASSWORD_LINE:$LEN:8}
  qpdf --password="$PASSWORD" --decrypt "$SCRAMBLE_DIR$SCRAMBLE_SET_TO_CHANGE" $TMP_SCRAMBLE
}

if [ "$SCRAMBLE_SET_TO_CHANGE" = "wait" ]; then
  log-change
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
  y|Y) 
    log-change
    decrypt-scramble
    echo $SCRAMBLE_SET_TO_CHANGE > $LSS_FILE
    $REPLACE_METHOD "$TMP_SCRAMBLE" $PATH_TO_REPLACE ;;
  *) echo "Nothing was done" ;;
esac
