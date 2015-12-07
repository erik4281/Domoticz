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
presence = otherdevices['People']
timeon = uservariables['DepartTimer']
difference = timedifference(otherdevices_lastupdate['MotionFrontDoor'])
timewait = (timeon * 60) + 120

if (presence == "On" and door == 'Closed' and difference < (timewait + 60)) then
	if ((otherdevices['iPhoneErik'] == 'On' or otherdevices['iPhoneJinHee'] == 'On') and presence == 'Off') then
		commandArray['People'] = 'On'
	end
	if ((otherdevices['iPhoneErik'] == 'Off' and otherdevices['iPhoneJinHee'] == 'Off') and presence == 'On') then
		commandArray['People'] = 'Off'
	end
end

return commandArray
