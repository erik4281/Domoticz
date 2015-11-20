#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/8/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/9/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/10/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 255}' http://10.0.1.102/api/erikvennink/lights/25/state
