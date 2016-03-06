commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'FanSwitch2') then
	if (otherdevices['FanSwitch2'] == 'Off') then
		if (otherdevices['People'] == 'On') then
			commandArray['FanSwitch2'] = 'On'
		end	
		if (uservariables['FanMotionAutoTrigger'] == 0) then
			commandArray['Variable:FanMotionOverrideHigh'] = tostring(1)
		end	
	elseif (otherdevices['FanSwitch2'] == 'On') then
		if (otherdevices['People'] == 'Off') then
			commandArray['FanSwitch2'] = 'Off'
		end	
		if (uservariables['FanMotionAutoTrigger'] == 0) then
			commandArray['Variable:FanMotionOverrideHigh'] = tostring(2)
		end	
	end
end

if (ts == 'FanSwitch3') then
	if (otherdevices['FanSwitch3'] == 'Off') then
		if (uservariables['FanMotionAutoTrigger'] == 0) then
			commandArray['Variable:FanMotionOverrideHigh'] = tostring(1)
		end	
	elseif (otherdevices['FanSwitch3'] == 'On') then
		if (otherdevices['People'] == 'Off') then
			commandArray['FanSwitch3'] = 'Off'
		end	
		if (uservariables['FanMotionAutoTrigger'] == 0) then
			commandArray['Variable:FanMotionOverrideHigh'] = tostring(3)
		end	
	end
end

if (ts:sub(1,6) == 'iPhone') then
	print((otherdevices_lastupdate[dc]))
	if (devicechanged[dc] == 'On') then
		ph = ts:sub(7)
		commandArray['SendNotification']='PEOPLE#'..ph..' has arrived#0#bike'
	elseif (devicechanged[dc] == 'Off') then
		ph = ts:sub(7)
		commandArray['SendNotification']='PEOPLE#'..ph..' has departed#0#bike'
	end
	if (otherdevices['iPhoneErik'] == 'On' or otherdevices['iPhoneJinHee'] == 'On') then
		if (otherdevices['Phones'] == 'Off') then
			commandArray['Phones'] = 'On'
		end
		if (otherdevices['People'] == 'Off') then
			commandArray['People'] = 'On'
		end
	end
	if (otherdevices['iPhoneErik'] == 'Off' and otherdevices['iPhoneJinHee'] == 'Off') then
		if (otherdevices['Phones'] == 'On') then
			commandArray['Phones'] = 'Off'
		end
	end
end

if (ts == 'SleepMode') then
	if (devicechanged[dc] == 'On') then
		commandArray['SwitchHumidifier'] = 'On'
		commandArray[1] = {['UpdateDevice'] = "41|0|18"}
	elseif (devicechanged[dc] == 'Off') then
		commandArray['SwitchHumidifier'] = 'Off'
		commandArray[1] = {['UpdateDevice'] = "41|0|22"}
	end
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch') then
			sc = i:sub(7)
			scriptfolder = "/home/pi/domoticz/scripts/bash/"
			if (otherdevices[i] == 'On') then
				commandArray[i] = 'On'
			end
		end
	end
end

if (ts == 'People') then
	if (devicechanged[dc] == 'On') then
		if (otherdevices['NestActive'] == 'Off') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'On'
		end
		commandArray['FanSwitch2'] = 'On'
		commandArray['SendNotification']='HOME#HOME mode activated#0#intermission'
	elseif (devicechanged[dc] == 'Off') then
		if (otherdevices['NestActive'] == 'On') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'Off'
		end
		commandArray['FanSwitch3'] = 'Off'
		commandArray['SendNotification']='HOME#AWAY mode activated#0#intermission'
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

if (ts == 'NestActive') then
	if (devicechanged[dc] == 'On') then
		commandArray['NestAway'] = 'Off'
	elseif (devicechanged[dc] == 'Off') then
		commandArray['NestAway'] = 'On'
	end
end

if (ts == 'ALARM' and devicechanged[dc] == 'On') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Motion' and otherdevices[i] == 'On') then
			commandArray['SendNotification']='ALARM#'..i..' is ON!#1#siren'
		elseif (v == 'Motion' and otherdevices[i] == 'Open') then
			commandArray['SendNotification']='ALARM#'..i..' is OPEN!#1#siren'
		end
	end
elseif (ts == 'ALARM' and devicechanged[dc] == 'Off') then
	commandArray['SendNotification']='ALARM#Alarm is OFF#1#siren'
end

return commandArray
