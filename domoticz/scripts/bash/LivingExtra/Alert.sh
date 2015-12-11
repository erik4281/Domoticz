#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"alert":"lselect"}' http://10.0.1.102/api/erikvennink/lights/1/state
curl -s -H "Accept: application/json" -X PUT --data '{"alert":"lselect"}' http://10.0.1.102/api/erikvennink/lights/5/state
curl -s -H "Accept: application/json" -X PUT --data '{"alert":"lselect"}' http://10.0.1.102/api/erikvennink/lights/28/state
curl -s -H "Accept: application/json" -X PUT --data '{"alert":"lselect"}' http://10.0.1.102/api/erikvennink/lights/29/state
