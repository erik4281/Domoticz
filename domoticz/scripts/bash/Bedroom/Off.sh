#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":150}' http://10.0.1.102/api/erikvennink/lights/16/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":150}' http://10.0.1.102/api/erikvennink/lights/17/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false}' http://10.0.1.102/api/erikvennink/lights/19/state
