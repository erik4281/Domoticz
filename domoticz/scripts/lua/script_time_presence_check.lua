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

if (otherdevices['People'] == 'On' and door == 'Closed' and difference < timewait) then
	if (otherdevices['Phones'] == 'On') then 
		commandArray['Variable:AlarmTimer'] = tostring(0)
	elseif (otherdevices['Phones'] == 'Off') then
		commandArray['Variable:AlarmTimer'] = tostring(uservariables['AlarmTimer'] + 1)
		if (uservariables['AlarmTimer'] > 5 and otherdevices['People'] == 'On') then
			commandArray['People'] = 'Off'
		end
	end
end

if (uservariables['AlarmTimer'] > 11) then
	--commandArray['ALARM'] = 'On'
end

return commandArray
