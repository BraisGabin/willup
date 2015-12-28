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

screenrc_temp=`mktemp`
cd "$( dirname "$0" )"
for server_name in "$@"
do
  if screen -list | grep -q $server_name
  then
    echo $server_name is running rightnow.
  else
    echo logfile /var/log/willup/$server_name.log > $screenrc_temp
    screen -dmS $server_name -Lc $screenrc_temp ./dontstarve_dedicated_server_nullrenderer -conf_dir $server_name
    sleep 1 # FIXME I need this because screen don't read $screenrc_temp immediately
  fi
done
rm $screenrc_temp
