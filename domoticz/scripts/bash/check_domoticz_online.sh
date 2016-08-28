#!/bin/sh
# check domoticz
status=`curl -s -i -H "Accept: application/json" "http://10.0.1.101:8080/json.htm?type=devices&rid=1" | grep "status"| awk -F: '{print $2}'|sed 's/,//'| sed 's/\"//g'`
if [ $status ]
then
echo "Domoticz is al gestart"
else
sudo service domoticz.sh stop
sleep 5
sudo service domoticz.sh start
fi
