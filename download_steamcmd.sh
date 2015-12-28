#!/bin/sh

if [ $# -ne 1 ]
then
  echo "Usage: $0 path"
  exit 1
fi

mkdir -p $1
cd $1
wget -O /tmp/steamcmd_linux.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf /tmp/steamcmd_linux.tar.gz
rm /tmp/steamcmd_linux.tar.gz
