commandArray = {}

dc = next(devicechanged)

if (dc == 'SleepMode') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch') then
			c = i:sub(7)
			scriptfolder = "/home/pi/domoticz/scripts/bash/"
			if (otherdevices[dc] == 'On') then
				commandArray['Bedroom Humidifier'] = 'On'
				if (otherdevices[i] == 'On') then
					scene = '9Slow.sh'
					os.execute (scriptfolder..c..'/'..scene)
				end
			elseif (otherdevices[dc] == 'Off') then
				commandArray['Bedroom Humidifier'] = 'Off'
				if (otherdevices[i] == 'On') then
					scene = '1Slow.sh'
					os.execute (scriptfolder..c..'/'..scene)
				end
			end
		end
	end
end

if (dc == 'People') then
	if (otherdevices[dc] == 'On') then
		if (otherdevices['NestAway'] == 'On') then
			commandArray['NestAway'] = 'Off'
		end
		commandArray['SendNotification']='Presence#Activated HOME mode#0#default'
	elseif (otherdevices[dc] == 'Off') then
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

if (dc == 'ALARM' and otherdevices[dc] == 'On' and otherdevices['People'] == 'Off') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch') then
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
end

return commandArray
