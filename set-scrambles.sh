case "$1" in
  "333") EVENT="3x3x3" ;;
  "222") EVENT="2x2x2" ;;
  "444") EVENT="4x4x4" ;;
  "555") EVENT="5x5x5" ;;
  "666") EVENT="6x6x6" ;;
  "777") EVENT="7x7x7" ;;
  "333bf") EVENT="3x3x3 Blindfolded" ;;
  "333fm") EVENT="3x3x3 Fewest Moves" ;;
  "333oh") EVENT="3x3x3 One-Handed" ;;
  "clock") EVENT="Clock" ;;
  "minx") EVENT="Megaminx" ;;
  "pyram") EVENT="Pyraminx" ;;
  "skewb") EVENT="Skewb" ;;
  "sq1") EVENT="Square-1" ;;
  "444bf") EVENT="4x4x4 Blindfolded" ;;
  "555bf") EVENT="5x5x5 Blindfolded" ;;
  "333mbf") EVENT="3x3x3 Multiple Blindfolded" ;;
  *) echo "The provided event code does not exist..." && exit 1
esac

FILENAME="$EVENT Round $2 Scramble Set $3.pdf"
LAST_SCRAMBLE_PATH="./last-scramble-set"

echo $FILENAME > $LAST_SCRAMBLE_PATH
bash ./change-scramble-set.sh "$FILENAME"
