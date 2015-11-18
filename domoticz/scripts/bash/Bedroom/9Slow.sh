#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 255,"hue":1,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/16/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/17/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/18/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false}' http://10.0.1.102/api/erikvennink/lights/19/state
