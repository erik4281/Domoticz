#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":false,"transitiontime":50}' http://10.0.1.102/api/erikvennink/lights/1/state
