#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 150,"sat": 150,"hue":15000,"transitiontime":50}' http://10.0.1.102/api/erikvennink/lights/30/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 150,"sat": 55,"hue":0,"transitiontime":50}' http://10.0.1.102/api/erikvennink/lights/31/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 150,"sat": 150,"hue":15000,"transitiontime":50}' http://10.0.1.102/api/erikvennink/lights/32/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 255,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/23/state
