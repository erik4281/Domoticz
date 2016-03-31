#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/20/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":20}' http://10.0.1.102/api/erikvennink/lights/18/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false}' http://10.0.1.102/api/erikvennink/lights/21/state
curl -s -H "Accept: application/json" -X PUT --data '{"on":false}' http://10.0.1.102/api/erikvennink/lights/36/state
