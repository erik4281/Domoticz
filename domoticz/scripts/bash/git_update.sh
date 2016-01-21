#!/bin/sh
#git update
sudo git reset --hard HEAD
sudo git pull
sudo chmod -R 755 /home/pi/domoticz/scripts/bash/
sudo chmod -R 755 /home/pi/domoticz/scripts/lua/
sudo chmod -R 755 /home/pi/domoticz/scripts/python/
