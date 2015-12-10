#!/bin/sh
# restart domoticz
sudo service domoticz.sh stop
sleep 5
sudo service domoticz.sh start
