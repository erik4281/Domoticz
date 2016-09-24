function timedifference(s)
	year = string.sub(s, 1, 4)
	month = string.sub(s, 6, 7)
	day = string.sub(s, 9, 10)
	hour = string.sub(s, 12, 13)
	minutes = string.sub(s, 15, 16)
	seconds = string.sub(s, 18, 19)
	t1 = os.time()
	t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
	difference = os.difftime (t1, t2)
	return difference
end

commandArray = {}

door = otherdevices['MotionFrontDoor']
difference = timedifference(otherdevices_lastupdate['MotionFrontDoor'])
timewait = 900

if (door == 'Closed' and ((difference < timewait) or (otherdevices['ALARM'] == 'On'))) then
	if (otherdevices['People'] == 'On') then
		motion = 0
		for i, v in pairs(otherdevices) do
			v = i:sub(1,6)
			if (v == 'Motion' and timedifference(otherdevices_lastupdate[i]) < 60) then
				motion = 1
			end
			if (v == 'Motion' and (otherdevices[i] == 'On' or timedifference(otherdevices_lastupdate[i]) < 30) and difference < timewait and difference > 60) then
				motion = 2
			end
			if (v == 'Motion' and (otherdevices[i] == 'On' or timedifference(otherdevices_lastupdate[i]) < 30) and otherdevices['ALARM'] == 'On' and timedifference(otherdevices_lastupdate['ALARM']) > 60) then
				motion = 2
			end
		end
		print ('Motion is set to '..motion)
		if (motion == 0) then
			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'] + 1)
			if (uservariables['PeopleTimer'] > 15) then
				commandArray['People'] = 'Off'
			end
		elseif (motion == 1) then
			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'])
		elseif (motion == 2) then
			commandArray['Variable:PeopleTimer'] = tostring(0)
			if (timedifference(otherdevices_lastupdate['ALARM']) > 600) then
				commandArray['ALARM'] = 'Off'
			end
		end
	end
elseif (door == 'Closed' and difference > 900 and otherdevices['People'] == 'Off') then
	if (otherdevices['FanSwitch2'] == 'On' or otherdevices['FanSwitch3'] == 'On') then
		commandArray['FanSwitch2'] = 'Off'
		commandArray['FanSwitch3'] = 'Off'
	end
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch' and otherdevices[i] == 'On') then
			commandArray[i] = 'Off'
		end
	end
end

if (otherdevices['ALARM'] == 'On' and otherdevices['SECURITY'] == 'On' and timedifference(otherdevices_lastupdate['ALARM']) > 60) then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Motion' and otherdevices[i] == 'On') then
			commandArray['SendNotification']='ALARM#'..i..' is ON!#1#siren'
		elseif (v == 'Motion' and otherdevices[i] == 'Open') then
			commandArray['SendNotification']='ALARM#'..i..' is OPEN!#1#siren'
		end
	end
	commandArray['ALARM'] = 'Off'
	commandArray['People'] = 'Off'
end

return commandArray
