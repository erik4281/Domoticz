#!/bin/sh
#git update
sudo git reset --hard HEAD
sudo git pull
sudo chmod -R 750 /home/pi/domoticz/scripts/bash/
sudo chmod -R 750 /home/pi/domoticz/scripts/python/
