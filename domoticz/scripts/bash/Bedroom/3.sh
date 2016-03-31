#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 180,"sat": 180,"hue":15000,"transitiontime":100}' http://10.0.1.102/api/erikvennink/lights/16/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 180,"sat": 255,"hue":55000,"transitiontime":100}' http://10.0.1.102/api/erikvennink/lights/17/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false}' http://10.0.1.102/api/erikvennink/lights/19/state
