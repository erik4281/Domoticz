#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/16/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/17/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/18/state
sleep .05
curl -s -H "Accept: application/json" -X PUT --data '{"on":false}' http://10.0.1.102/api/erikvennink/lights/19/state
