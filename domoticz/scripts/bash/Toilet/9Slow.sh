#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"transitiontime":30}' http://10.0.1.102/api/erikvennink/lights/22/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"transitiontime":30}' http://10.0.1.102/api/erikvennink/lights/22/state
