#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/2/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/3/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/4/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 255,"hue":0,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/5/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/6/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/7/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 150,"hue":15000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/27/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 255,"hue":50000,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/28/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 255,"hue":0,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/29/state
