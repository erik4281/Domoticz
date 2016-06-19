#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 50,"sat": 255,"hue":0,"transitiontime":20,"effect":"none"}' http://10.0.1.102/api/erikvennink/lights/1/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/12/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true}' http://10.0.1.102/api/erikvennink/lights/35/state
