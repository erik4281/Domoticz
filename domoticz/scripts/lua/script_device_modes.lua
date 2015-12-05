commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'SleepMode') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch') then
			c = i:sub(7)
			--scriptfolder = "/home/pi/domoticz/scripts/bash/"
			if (devicechanged[dc] == 'On') then
				commandArray['Bedroom Humidifier'] = 'On'
				commandArray[1] = {['UpdateDevice'] = "41|0|18"}
				--if (otherdevices[i] == 'On') then
					--commandArray[otherdevices[i]] = 'On'
					--scene = '9Slow.sh'
					--os.execute (scriptfolder..c..'/'..scene)
				--end
			elseif (devicechanged[dc] == 'Off') then
				commandArray['Bedroom Humidifier'] = 'Off'
				commandArray[1] = {['UpdateDevice'] = "41|0|22"}
				--if (otherdevices[i] == 'On') then
					--commandArray[otherdevices[i]] = 'On'
					--scene = '1Slow.sh'
					--os.execute (scriptfolder..c..'/'..scene)
				--end
			end
			if (otherdevices[i] == 'On') then
				print('Switching lights to comply to new mode')
				commandArray[otherdevices[i]] = 'On'
				--scene = '9Slow.sh'
				--os.execute (scriptfolder..c..'/'..scene)
			end
		end
	end
end

if (ts == 'People') then
	if (devicechanged[dc] == 'On') then
		if (otherdevices['NestAway'] == 'On') then
			commandArray['NestAway'] = 'Off'
		end
		commandArray['SendNotification']='Presence#Activated HOME mode#0#default'
	elseif (devicechanged[dc] == 'Off') then
		if (otherdevices['NestAway'] == 'Off') then
			commandArray['NestAway'] = 'On'
		end
		commandArray['SendNotification']='Presence#Activated AWAY mode#0#default'
		for i, v in pairs(otherdevices) do
			v = i:sub(1,6)
			if (v == 'Switch') then
				if (otherdevices[i] == 'On') then
					commandArray[i] = 'Off'
				end
			end
		end
	end
end

if (ts == 'ALARM' and devicechanged[dc] == 'On' and otherdevices['People'] == 'Off') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Motion' and otherdevices[i] == 'On') then
			commandArray['SendNotification']='ALARM#ALARM: '..i..' is ON, but nobody is home!#2#default'
		end
		if (v == 'Motion' and otherdevices[i] == 'Open') then
			commandArray['SendNotification']='ALARM#ALARM: '..i..' is OPEN, but nobody is home!#2#default'
		end
		if (v == 'Tamper' and otherdevices[i] == 'On') then
			commandArray['SendNotification']='ALARM#ALARM: '..i..' is ON, but nobody is home!#2#default'
		end
	end
end

return commandArray
