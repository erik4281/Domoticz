#!/bin/sh
#git update
sudo git reset --hard HEAD
sudo git pull
sudo chmod -R 750 domoticz/scripts/bash/
sudo chmod -R 750 domoticz/scripts/python/
