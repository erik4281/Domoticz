commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'FanSwitch2') then
	if (otherdevices['FanSwitch2'] == 'Off') then
		if (otherdevices['People'] == 'On' and otherdevices['ALARM'] == 'Off') then
			commandArray['FanSwitch2'] = 'On'
		end	
	elseif (otherdevices['FanSwitch2'] == 'On') then
		if (otherdevices['People'] == 'Off') then
			commandArray['FanSwitch2'] = 'Off'
		end	
	end
end

if (ts == 'FanSwitch3') then
	if (otherdevices['FanSwitch3'] == 'On') then
		if (otherdevices['People'] == 'Off') then
			commandArray['FanSwitch3'] = 'Off'
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

--if (ts == 'ALARM' and devicechanged[dc] == 'On' and otherdevices['SECURITY'] == 'On') then
--	for i, v in pairs(otherdevices) do
--		v = i:sub(1,6)
--		if (v == 'Motion' and otherdevices[i] == 'On') then
--			commandArray['SendNotification']='ALARM#'..i..' is ON!#1#siren'
--		elseif (v == 'Motion' and otherdevices[i] == 'Open') then
--			commandArray['SendNotification']='ALARM#'..i..' is OPEN!#1#siren'
--		end
--	end
--elseif (ts == 'ALARM' and devicechanged[dc] == 'Off') then
--	commandArray['SendNotification']='ALARM#Alarm is OFF#1#siren'
--end

return commandArray
