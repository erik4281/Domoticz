#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/8/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/9/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/10/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false}' http://10.0.1.102/api/erikvennink/lights/25/state