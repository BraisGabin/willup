#!/bin/sh

echo WARNING! This action will remove completely Willup and all the game data.
read -p "Are you sure that you want to continue? [y/N] " yn

case $yn in
  y|Y)
    ;;
  *)
    echo Aborting the operation.
    exit 1;
    ;;
esac

user=willup
home=`getent passwd $user | cut -d: -f6`

/usr/local/bin/willup stop
sudo rm /usr/local/bin/willup
sudo rm -r /var/log/willup
sudo deluser --remove-all-files $user # FIXME with the home at /var/lib/ --remove-home do nothing
