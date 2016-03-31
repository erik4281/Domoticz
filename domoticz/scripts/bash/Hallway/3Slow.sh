#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 180,"transitiontime":150}' http://10.0.1.102/api/erikvennink/lights/13/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 180,"transitiontime":150}' http://10.0.1.102/api/erikvennink/lights/14/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 180,"transitiontime":150}' http://10.0.1.102/api/erikvennink/lights/15/state
