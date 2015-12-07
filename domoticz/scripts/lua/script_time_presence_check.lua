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
timewait = (timeon * 60) + 120

if (otherdevices['People'] == 'On' and door == 'Closed' and difference < (timewait + 60)) then
	if (otherdevices['Phones'] == 'Off') then
		commandArray['People'] = 'Off'
		if (otherdevices['ALARM'] == 'Off') then
			if (uservariables['AlarmTimer'] < 2) then
				commandArray['Variable: AlarmTimer'] = tostring(uservariables['AlarmTime'] + 1)
			if (uservariables['AlarmTimer'] >= 2) then
				commandArray['ALARM'] = 'On'
			end
		end

	end
elseif (otherdevices['People'] == 'On' and (otherdevices['Phones'] == 'Off')) then
	
end

return commandArray
