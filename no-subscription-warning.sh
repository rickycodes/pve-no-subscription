#!/usr/bin/env bash

FIND="NotFound"
REPLACE="Active"
FILE=/usr/share/perl5/PVE/API2/Subscription.pm

CAT=$(cat "$FILE" | grep "$FIND")

if [ $? -eq "0" ]; then
  echo "subscription status: $FIND"
  if test -f "$FILE"; then
      echo "performing replacement..."
      sed -i "s/$FIND/$REPLACE/g" "$FILE"
      ex=$?
      if [ "$ex" -eq "0" ]; then
        echo "restarting services..."
        systemctl restart pvedaemon && systemctl restart pveproxy
        echo "all done!"
      else
        echo "something went wrong :("
      fi
  else
    echo "file does not exist! are you sure this is pve?"
  fi
else
  echo "cannot find item. have you already run the replacement?"
fi
