#!/bin/sh
# git update
#sudo git reset --hard HEAD
sudo git pull
sudo chmod -R 750 domoticz/scripts/bash/
sudo chmod 750 domoticz/scripts/python/check_device_bluetooth.py
sudo chmod 750 domoticz/scripts/python/check_device_online.py
