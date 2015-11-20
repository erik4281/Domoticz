commandArray = {}

t = next(devicechanged)
s = tostring(t)
c = s:sub(7)
presenceswitch = otherdevices['People']
presencewitchname = 'People'

if (s:sub(1,6) == 'Motion' and c == 'FrontDoor' and devicechanged[t] == 'On' and presenceswitch == 'Off') then
	print ("Arriving")
	commandArray[presencewitchname] = 'On'
	commandArray['TriggerDoor'] = 'Off'
	os.execute ('/home/pi/domoticz/scripts/bash/Hallway/1.sh')
	os.execute ('/home/pi/domoticz/scripts/bash/Hallway/1.sh')
end
if (s:sub(1,6) == 'Motion' and c == 'Bedroom' and devicechanged[t] == 'On' and presenceswitch == 'Off') then
	print ("Movement in Bedroom. Switching to present again!")
	commandArray[presencewitchname] = 'On'
	commandArray['TriggerDoor'] = 'Off'
	os.execute ('/home/pi/domoticz/scripts/bash/Bedroom/0.sh')
	os.execute ('/home/pi/domoticz/scripts/bash/Bedroom/0.sh')
end

return commandArray
