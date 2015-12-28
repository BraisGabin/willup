#!/bin/sh

if [ $# -lt 1 ]
then
  echo "Usage: $0 server_name..."
  exit 1
fi

user=willup

if [ "`whoami`" != "$user" ]
then
  echo "Error: This script must be run by the user $user"
  exit 1
fi

for server_name in "$@"
do
  screen -dr $server_name -X quit
done
