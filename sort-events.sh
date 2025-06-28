#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "I need a competition ID..."
    exit 1
fi

JSON_FILE="$1-json"
SCHEDULE_FILE="schedule"
wget --output-document $JSON_FILE https://worldcubeassociation.org/api/v0/competitions/$1/wcif/public
cat $JSON_FILE | jq --from-file query.jq | tail -n +3 | head -n -2 | sed -r 's/[^[:alnum:][:space:]]//g' | sed -r 's/    //g' | sed -r 's/ Cube//g' | tee $SCHEDULE_FILE


