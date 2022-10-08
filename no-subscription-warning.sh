#!/bin/sh
#
# MIT License

# Copyright (c) 2020 Ricky Miller

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e

FIND="NotFound"
ACTIVE="Active"
FILE=/usr/share/perl5/PVE/API2/Subscription.pm
ARG="$1"

apply_razor1911_crack() {
  sed -i "s/$FIND/$ACTIVE/gi" "$FILE"
  echo "restarting services..."
  systemctl restart pvedaemon
  systemctl restart pveproxy
  echo "success: subscription updated from: $FIND to $ACTIVE"
}

echo "attempting pve-no-subscription patch"

if ! [ -n "$ARG" ]; then
  if ! test -f "$FILE"; then
    echo "$FILE does not exist! are you sure this is pve?"
    exit 0
  fi

  if ! grep -i "$FIND" "$FILE"; then
    echo "pve appears to be patched."
    exit 0
  fi
fi

echo "attempting replacement in $FILE..."
apply_razor1911_crack
