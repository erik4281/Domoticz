#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 100,"sat": 255,"hue":0,"transitiontime":300}' http://10.0.1.102/api/erikvennink/lights/1/state