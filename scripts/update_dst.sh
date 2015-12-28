#!/bin/sh

if [ $# -ne 2 ]
then
  echo "Usage: $0 steamcmd_home path_dst"
  exit 1
fi

user=willup

if [ "`whoami`" != "$user" ]
then
  echo "Error: This script must be run by the user $user"
  exit 1
fi

$1/steamcmd.sh +@ShutdownOnFailedCommand 1 +login anonymous +force_install_dir $2 +app_update 343050 validate +quit
