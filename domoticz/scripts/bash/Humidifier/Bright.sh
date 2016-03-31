#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"on":true}' http://10.0.1.102/api/erikvennink/lights/24/state
