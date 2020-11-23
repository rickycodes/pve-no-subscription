FILE=/usr/share/perl5/PVE/API2/Subscription.pm
if test -f "$FILE"; then
    sed -i "s/NotFound/Active/g" "$FILE"
    ex=$?
    if [ "$ex" -eq "0" ]; then
      systemctl restart pvedaemon
	    systemctl restart pveproxy
      echo "all done!"
    else
      echo "something went wrong :("
    fi
else
  echo "file does not exist! are you sure this is pve?"
fi
