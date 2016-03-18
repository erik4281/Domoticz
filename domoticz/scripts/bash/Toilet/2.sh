#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"transitiontime":5}' http://10.0.1.102/api/erikvennink/lights/22/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"transitiontime":5}' http://10.0.1.102/api/erikvennink/lights/22/state
