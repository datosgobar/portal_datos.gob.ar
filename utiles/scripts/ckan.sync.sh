#!/bin/bash
# Crontab rule: */15 * * * * /path/to/ckan_sync/sync.sh
# ENV vars.
LOGPATH="/path/to/ckan_sync/logs"
SYNCDATE=$(date +"%F")
SYNCTIME=`date +%Y/%m/%dT%H:%M:%S-03:00`
LOGFILE="$LOGPATH/fs_sync_$SYNCDATE.log"
REMOTE_LOCATION="user@xxx.xxx.xxx.xxx:/path/to/remote/ckan_fs"
PG_CONTAINER_NAME="pg-ckan"


# Sync proc!
if [ -z "$1" ]
  then
    printf "Setting default [PROTOCOL]...\n"
    CKAN_HOST_PROT="http"
  else
    printf "Setting user-defined [PROTOCOL]...\n"
    CKAN_HOST_PROT="$1"
fi
if [ -z "$2" ]
  then
    printf "Setting default [HOST]=[181.209.63.29]...\n"
    CKAN_HOST_PROT="181.209.63.29"
  else
    printf "Setting user-defined [HOST]=[%s]...\n" % $2
    CKAN_HOST_PROT="$2"
fi

eval "wget -q --spider $CKAN_HOST_PROT://$CKAN_HOST"
if [ "$?" -eq "0" ] ; then
    printf "Starting rSync...\n"
    echo "---------| SYNC: $SYNCTIME [START] |---------" >> $LOGFILE
    printf "Stoping DB server...\n"
    docker stop $PG_CONTAINER_NAME
    printf "Throwing sync... \n"
    rsync -ahzv $REMOTE_LOCATION /path/to/local/ckan/fs/ >> $LOGFILE
    printf "Restarting DB server...\n"
    docker start $PG_CONTAINER_NAME
    echo "--------------------| [END] |--------------------" >> $LOGFILE
else
    printf "Remote server is down, cancelling rSync...\n[BYE!]\n"
fi
