#!/usr/bin/env bash
set -e

FIND="NotFound"
REPLACE="Active"
FILE=/usr/share/perl5/PVE/API2/Subscription.pm
STEAMROLL_OPTION="--steamroll"
OPTION="$1"

OUTPUT_UNRECIGNIZED_OPTION="unrecognized option"
OUTPUT_SUBSCRIPTION_STATUS="subscription status: $FIND"
OUTPUT_PERFORMING_REPLACEMENT="attempting replacement in $FILE..."
OUTPUT_RESTARTING_SERVICES="restarting services..."
OUTPUT_ALL_DONE="all done!"
OUTPUT_CANNOT_FIND_ITEM="cannot find item. have you already run the replacement?"
OUTPUT_FILE_DOES_NOT_EXIST="$FILE does not exist! are you sure this is pve?"

apply_razor1911_crack() {
  sed -i "s/$FIND/$REPLACE/g" "$FILE"
  echo "$OUTPUT_RESTARTING_SERVICES"
  systemctl restart pvedaemon
  systemctl restart pveproxy
  echo "$OUTPUT_ALL_DONE"
}

if [ -n "$OPTION" ]; then
  if [ "$OPTION" == "$STEAMROLL_OPTION" ]; then
    apply_razor1911_crack
  else
    echo "$OUTPUT_UNRECIGNIZED_OPTION"
  fi
else
  if test -f "$FILE"; then
    if grep -i "$FIND" "$FILE"; then
      echo "$OUTPUT_SUBSCRIPTION_STATUS"
      echo "$OUTPUT_PERFORMING_REPLACEMENT"
      apply_razor1911_crack
    else
      echo "$OUTPUT_CANNOT_FIND_ITEM"
    fi
  else
    echo "$OUTPUT_FILE_DOES_NOT_EXIST"
  fi
fi
