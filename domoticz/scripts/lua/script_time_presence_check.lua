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
		if (otherdevices['Phones'] == 'On') then
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
	else
		if (otherdevices['Phones'] == 'On') then
			commandArray['People'] = 'On'
		end
	end
elseif (door == 'Closed' and difference > 900 and otherdevices['People'] == 'Off' and (otherdevices['FanSwitch2'] == 'On' or otherdevices['FanSwitch3'] == 'On')) then
	commandArray['FanSwitch2'] = 'Off'
	commandArray['FanSwitch3'] = 'Off'
end

return commandArray
