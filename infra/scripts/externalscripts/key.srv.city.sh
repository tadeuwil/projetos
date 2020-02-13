#!/bin/bash
set -e
printf "\033c"

# Tested with Zabbix vZabbix 3.0.24 & Speedtest-cli v2.0.0
echo "checking speedtest and report back to zabbix, please wait..."

#################
# Configuration #
#################
# Zabbix 
TIMESTAMP=$(date "+%Y.%m.%d-%H.%M.%S")
ZABBIX_SENDER="/usr/bin/zabbix_sender"
ZABBIX_HOST="SpeedTest"
ZABBIX_SRV="zabbix IP or FQDN"
ZABBIX_LOG="/dev/null"
ZABBIX_DATA=/tmp/zbxdata_$TIMESTAMP.log
# Speedtest
SPEEDTEST="/usr/bin/speedtest-cli"
CACHE_FILE=/tmp/speedtest_$TIMESTAMP.log
ID="21197" # Test against server ID, to get all servers ID - run 'speedtest --list' 

 #################
# Generate data #
#################
speedtest --server $ID --csv > $CACHE_FILE

##################
# Extract fields #
##################
output=$(cat $CACHE_FILE)
    WAN_IP=$(echo "$output" | cut -f10 -d ',')
    PING=$(echo "$output" | cut -f6 -d ',')
    SRV_NAME=$(echo "$output" | cut -f2 -d ',')
    SRV_CITY=$(echo "$output" | cut -f3 -d ',')
    SRV_KM=$(echo "$output" | cut -f5 -d ',' | cut -b1-5)
    DL_TMP=$(echo "$output" | cut -f7 -d ',')
    UP_TMP=$(echo "$output" | cut -f8 -d ',')
    

#####################
# convert to Mbit/s #
#####################
DL=$(echo "$DL_TMP" |  awk '{ printf("%.2f\n", $1 / 1024 /1024 ) }')
UP=$(echo "$UP_TMP" |  awk '{ printf("%.2f\n", $1 / 1024 /1024 ) }')


#####################
# Write Zabbix Data #
#####################
 echo "SpeedTest" key.download $DL >> $ZABBIX_DATA 
 echo "SpeedTest" key.upload $UP >> $ZABBIX_DATA 
 echo "SpeedTest" key.wan.ip $WAN_IP >> $ZABBIX_DATA 
 echo "SpeedTest" key.ping $PING >> $ZABBIX_DATA
 echo "SpeedTest" key.srv.name $SRV_NAME >> $ZABBIX_DATA
 echo "SpeedTest" key.srv.city $SRV_CITY >> $ZABBIX_DATA
 echo "SpeedTest" key.srv.km $SRV_KM >> $ZABBIX_DATA

##########################
# zabbix sender finction #
##########################
function send_value {
        /usr/bin/zabbix_sender -z ZABBIX_SERVER_IP_OR_FQDN -i $ZABBIX_DATA
}

#######################
# Send data to Zabbix #
send_value
#######################