commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'SleepMode') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch') then
			if (devicechanged[dc] == 'On') then
				commandArray['Bedroom Humidifier'] = 'On'
				commandArray[1] = {['UpdateDevice'] = "41|0|18"}
			elseif (devicechanged[dc] == 'Off') then
				commandArray['Bedroom Humidifier'] = 'Off'
				commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			end
			sc = i:sub(7)
			scriptfolder = "/home/pi/domoticz/scripts/bash/"
			if (otherdevices[i] == 'On') then
				timenumber = tonumber(os.date("%H")..os.date("%M"))
				time1 = tonumber(uservariables['Timer'..sc..'1'])
				time2 = tonumber(uservariables['Timer'..sc..'2'])
				time3 = tonumber(uservariables['Timer'..sc..'3'])
				time4 = tonumber(uservariables['Timer'..sc..'4'])
				if (time1) then
					scene = 0
				else
					scene = 1
				end
				if (scene == 0 and time1) then
					if (timenumber >= time1) then
						scene = 1
					end
				end
				if (scene == 1 and time2) then
					if (timenumber >= time2) then
						scene = 2
					end
				end
				if (scene == 2 and time3) then
					if (timenumber >= time3) then
						scene = 3
					end
				end
				if (scene == 3 and time4) then
					if (timenumber >= time4) then
						scene = 4
					end
				end
				if (devicechanged[dc] == 'On') then
					scene = 9
				end
				scene = scene..'Slow.sh'
				print ('Switch triggered: '..scriptfolder..sc..'/'..scene)
				os.execute (scriptfolder..sc..'/'..scene)
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
elseif (ts == 'ALARM' and devicechanged[dc] == 'Off' and otherdevices['People'] == 'Off') then
	commandArray['SendNotification']='ALARM#Alarm is OFF!#2#default'
end

return commandArray
