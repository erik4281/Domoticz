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

--if (door == 'Closed' and difference < timewait) then
if (door == 'Closed') then
	if (otherdevices['People'] == 'On') then
		motion = 1
		for i, v in pairs(otherdevices) do
			v = i:sub(1,6)
			if (v == 'Motion' and otherdevices[i] == 'Off' and timedifference(otherdevices_lastupdate[i]) > 60) then
				motion = 0
			end
		end
		print ('Motion: '..motion)
		if (motion == 1) then
			commandArray['Variable:AlarmTimer'] = tostring(0)
		else
			commandArray['Variable:AlarmTimer'] = tostring(uservariables['AlarmTimer'] + 1)
			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'] + 1)
			if (uservariables['PeopleTimer'] > 12) then
				commandArray['People'] = 'Off'
			end
			if (uservariables['AlarmTimer'] > 12) then
				commandArray['ALARM'] = 'On'
			end
		end
--		if (otherdevices['Phones'] == 'On') then
--			commandArray['Variable:AlarmTimer'] = tostring(0)
--		else
--			commandArray['Variable:AlarmTimer'] = tostring(uservariables['AlarmTimer'] + 1)
--			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'] + 1)
--			if (uservariables['PeopleTimer'] > 12) then
--				commandArray['People'] = 'Off'
--			end
--			if (uservariables['AlarmTimer'] > 12) then
--				commandArray['ALARM'] = 'On'
--			end
--		end
--	else
--		if (otherdevices['Phones'] == 'On') then
--			commandArray['People'] = 'On'
--		end
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
