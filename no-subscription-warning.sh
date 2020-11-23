#!/usr/bin/env bash

FIND="NotFound"
REPLACE="Active"
FILE=/usr/share/perl5/PVE/API2/Subscription.pm

OUTPUT_SUBSCRIPTION_STATUS="subscription status: $FIND"
OUTPUT_PERFORMING_REPLACEMENT="performing replacement in $FILE..."
OUTPUT_RESTARTING_SERVICES="restarting services..."
OUTPUT_ALL_DONE="all done!"
OUTPUT_SOMETHING_WENT_WRONG="something went wrong :("
OUTPUT_CANNOT_FIND_ITEM="cannot find item. have you already run the replacement?"
OUTPUT_FILE_DOES_NOT_EXIST="file does not exist! are you sure this is pve?"

if test -f "$FILE"; then
  if grep -i "$FIND" "$FILE"
  then
    echo "$OUTPUT_SUBSCRIPTION_STATUS"
    echo "$OUTPUT_PERFORMING_REPLACEMENT"
    if sed -i "s/$FIND/$REPLACE/g" "$FILE"
    then
      echo "$OUTPUT_RESTARTING_SERVICES"
      systemctl restart pvedaemon && systemctl restart pveproxy
      echo "$OUTPUT_ALL_DONE"
    else
      echo "$OUTPUT_SOMETHING_WENT_WRONG"
    fi
  else
    echo "$OUTPUT_CANNOT_FIND_ITEM"
  fi
else
  echo "$OUTPUT_FILE_DOES_NOT_EXIST"
fi
