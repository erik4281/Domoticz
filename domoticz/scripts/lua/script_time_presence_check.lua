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
timeon = uservariables['DepartTimer']
difference = timedifference(otherdevices_lastupdate['MotionFrontDoor'])
timewait = ((timeon + 2) * 60)

if (door == 'Closed' and difference < timewait) then
	if (otherdevices['People'] == 'On') then
		motion = 0
		for i, v in pairs(otherdevices) do
			v = i:sub(1,6)
			if (v == 'Motion' and timedifference(otherdevices_lastupdate[i]) < 60) then
				motion = 1
			end
			if (v == 'Motion' and difference > 60 and (otherdevices[i] == 'On' or timedifference(otherdevices_lastupdate[i]) < 30)) then
				motion = 2
			end
		end
		if (motion == 0) then
			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'] + 1)
			if (uservariables['PeopleTimer'] > 15) then
				commandArray['People'] = 'Off'
			end
		elseif (motion == 1) then
			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'])
		elseif (motion == 2) then
			commandArray['Variable:PeopleTimer'] = tostring(0)
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

return commandArray
