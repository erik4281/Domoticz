#!/bin/bash
curl -s -H "Accept: application/json" -X PUT --data '{"alert": "lselect", "hue": 0}' http://10.0.1.102/api/erikvennink/lights/2/state
