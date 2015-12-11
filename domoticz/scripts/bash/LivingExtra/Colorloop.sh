#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 255,"hue":0,"effect":"colorloop"}' http://10.0.1.102/api/erikvennink/lights/1/state
sleep 20
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 255,"hue":0,"effect":"none"}' http://10.0.1.102/api/erikvennink/lights/1/state
