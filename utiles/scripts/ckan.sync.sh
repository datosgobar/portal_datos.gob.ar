#!/bin/bash
# Crontab rule: */15 * * * * /path/to/ckan_sync/sync.sh
# ENV vars.
LOGPATH="/path/to/ckan_sync/logs"
SYNCDATE=$(date +"%F")
SYNCTIME=`date +%Y/%m/%dT%H:%M:%S-03:00`
LOGFILE="$LOGPATH/fs_sync_$SYNCDATE.log"
REMOTE_LOCATION="user@xxx.xxx.xxx.xxx:/path/to/remote/ckan_fs"

# Sync proc!
echo "---------| SYNC: $SYNCTIME [START] |---------" >> $LOGFILE
rsync -ahzv $REMOTE_LOCATION /path/to/local/ckan/fs/ >> $LOGFILE
echo "--------------------| [END] |--------------------" >> $LOGFILE
