#!/bin/sh

show_usage(){
  echo "Usage: $0 [--server-name=<server_name>] [--server-password=<server_password>] path_to_server_token_txt"
}

server_name="[TEST] Willup"
server_pass=""
path_server_token=""
for arg in "$@"
do
  case "$arg" in
    --server-name=*)
      server_name="${arg#*=}"
      ;;
    --server-password=*)
      server_pass="${arg#*=}"
      ;;
    *)
      if [ "$path_server_token" = "" ]
      then
        path_server_token=$arg
      else
        show_usage
        exit 1
      fi
      ;;
  esac
done
if [ "$path_server_token" = "" ]
then
  show_usage
  exit 1
fi

escape_sed(){
  echo `echo "$1" | sed 's/\//\\\\\//g'`
}

readonly user=willup
readonly servers="overworld cave"
readonly home=/var/lib/willup
readonly path_log=/var/log/willup
readonly path_steamcmd=$home/steamcmd
readonly path_steamapps=$home/steamapps
readonly path_bin=$path_steamapps/DST/bin
readonly path_servers=$home/.klei
readonly path_start=$path_bin/start.sh
readonly path_stop=$path_bin/stop.sh
readonly path_update_dst=$path_bin/update_dst.sh

# Create a new user
sudo adduser --home $home --disabled-login --gecos "Don't Starve Together - Willup" $user

# Install steamcmd's dependencies
if uname -m | grep -q 'x86_64'
then
  sudo apt-get install lib32gcc1
fi

# Download steamcmd
sudo -u $user ./download_steamcmd.sh $path_steamcmd

# Download Don't Starve Together
sudo su $user -c "sh scripts/update_dst.sh $path_steamcmd $path_steamapps/DST"

# Configure server
sudo mkdir $path_log
sudo chown $user $path_log
sudo -u $user chmod 700 $path_log
sudo -u $user cp scripts/start.sh $path_start
sudo -u $user chmod u+x $path_start
sudo -u $user cp scripts/stop.sh $path_stop
sudo -u $user chmod u+x $path_stop
sudo -u $user cp scripts/update_dst.sh $path_update_dst
sudo -u $user chmod u+x $path_update_dst

readonly cluster_token=`uuidgen`
command_start=$path_start
command_stop=$path_stop
for server in $servers
do
  server_dir=DST_$server
  path_server=$path_servers/$server_dir
  command_start="$command_start $server_dir"
  command_stop="$command_stop $server_dir"

  sudo -u $user mkdir -p $path_server
  sudo -u $user cp $path_server_token $path_server/server_token.txt
  sudo -u $user cp defaults/settings/$server.ini $path_server/settings.ini
  sudo -u $user sed -i "s/_SERVER_NAME_/$server_name/g" $path_server/settings.ini
  sudo -u $user sed -i "s/_SERVER_PASS_/$server_pass/g" $path_server/settings.ini
  sudo -u $user sed -i "s/_CLUSTER_KEY_/$cluster_token/g" $path_server/settings.ini
  sudo -u $user cp defaults/worldgenoverride/$server.lua $path_server/worldgenoverride.lua
done

command_update_dst="$path_update_dst $path_steamcmd $path_steamapps/DST"
readonly path_willup=`sudo -u $user mktemp`
sudo -u $user cp scripts/willup $path_willup
sudo -u $user sed -i "s/_COMMAND_START_/`escape_sed "$command_start"`/g" $path_willup
sudo -u $user sed -i "s/_COMMAND_STOP_/`escape_sed "$command_stop"`/g" $path_willup
sudo -u $user sed -i "s/_COMMAND_UPDATE_DST_/`escape_sed "$command_update_dst"`/g" $path_willup
sudo -u $user chmod +r,+x $path_willup
sudo mv $path_willup /usr/local/bin/willup
