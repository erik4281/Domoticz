#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 255,"sat": 150,"hue":15000,"transitiontime":1800}' http://10.0.1.102/api/erikvennink/lights/16/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 255,"sat": 255,"hue":25000,"transitiontime":1800}' http://10.0.1.102/api/erikvennink/lights/17/state
