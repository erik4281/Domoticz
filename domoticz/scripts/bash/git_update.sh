#!/bin/sh
#git update
sudo git reset --hard HEAD
sudo git pull
sudo chmod -R 755 /home/pi/domoticz/scripts/bash/
sudo chmod -R 755 /home/pi/domoticz/scripts/lua/
sudo chmod -R 755 /home/pi/domoticz/scripts/python/
sudo npm update -g homebridge-edomoticz
sudo forever restart /usr/local/lib/node_modules/homebridge/bin/homebridge
tail -f `ls -t ~/.forever/*.log | grep -v '^d' | head -n1`
