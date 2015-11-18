#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true,"bri": 180,"transitiontime":100}' http://10.0.1.102/api/erikvennink/lights/11/state