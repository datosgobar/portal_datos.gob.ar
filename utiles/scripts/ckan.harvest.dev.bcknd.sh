#!/bin/bash
set -ue

####################################################################################### 
#                                                                                     # 
#    MINIMAL CKAN  HARVEST TOOL LAUNCHER                                              #
#    (yes... boringme install supervisor and other things...                          # 
#     but please, don't tell it any one)                                              #
#                                                                                     #
#######################################################################################

# EXECUTION MODES

FETCH_ONLY=2
GATHER_ONLY=1
FETCH_AND_GATHER=0

CRNTDATE="`date +%F`"
CKN_CONFIG_FILE="$CKAN_CONFIG/$CKAN_CONFIG_FILE"
CKN_PASTER="$CKAN_HOME/bin/paster"

EXECUTE_MODE=$FETCH_AND_GATHER


printf "========================================$CRNTDATE========================================\n"

FETCH_CONSUMER="$CKN_PASTER --plugin=ckanext-harvest harvester fetch_consumer -c $CKN_CONFIG_FILE  >> /tmp/fetch_consumer_$CRNTDATE.log 2>&1 &"
GATHER_CONSUMER="$CKN_PASTER  --plugin=ckanext-harvest harvester gather_consumer -c $CKN_CONFIG_FILE >> /tmp/gather_consumer_$CRNTDATE.log 2>&1 &"

printf "Checking if services are runnning..."
if pidof -x "paster" >/dev/null; then
    echo "\nProcess already running"
    printf " [kill_them] "

    if [[ "$(kill -9 $(pidof -x paster))" -eq "0" ]] ; then
    	printf "OK\n"
    else
    	printf "FAILS\n"	
    fi
else 
	printf "OK\n"
fi

printf "Starting Harvest services... "

if [[ "$EXECUTE_MODE" -eq "$FETCH_ONLY" ]] ;
	then
	printf "Starting [FETCH] service... "
	eval $FETCH_CONSUMER
	exit_codes=$?
elif [[ "$EXECUTE_MODE" -eq "$GATHER_ONLY" ]] ;
	then
	printf "Starting [GATHER] service... "
	eval $GATHER_CONSUMER
	exit_codes=$?
elif [[ "$EXECUTE_MODE" -eq "$FETCH_AND_GATHER" ]]; 
	then
	printf "Starting [FETCH] and [GATHER] services... "
	eval $FETCH_CONSUMER
	ff=$?
	eval $GATHER_CONSUMER
	fa=$?
	exit_codes=$[fa+ff]		
fi


if [[ $exit_codes -eq "0" ]] ;
then
	printf "[OK]\n"
else
	printf "[FAIL]\n"
fi 

echo "Actual services \"paster\" running:"
ps aux | grep paster | grep -v  grep
printf "===========================================END============================================\n"
