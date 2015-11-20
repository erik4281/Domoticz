#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/2/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/3/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/4/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 255,"hue":27000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/5/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/6/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/7/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 150,"hue":15000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/27/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 255,"hue":50000,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/28/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 200,"sat": 255,"hue":0,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/29/state
