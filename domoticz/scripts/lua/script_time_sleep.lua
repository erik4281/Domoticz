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

timenumber = tonumber(os.date("%H")..os.date("%M"))
sleep = otherdevices['SleepMode']
switchsleep = 'SleepMode'
presence = otherdevices['People']
sleepstart = 2200
sleepstop = 0400

for i, v in pairs(otherdevices) do
	ts = tostring(i)
	v = i:sub(1,6)
	sc = i:sub(7)
	if (presence == 'On' and sleep == 'Off' and (ts == 'SwitchLiving' or ts == 'SwitchKitchen'or ts == 'MotionFrontDoor') and (timenumber >= sleepstart or timenumber < sleepstop)) then
		sc = 'SwitchLiving'
		sd = 'SwitchKitchen'
		se = 'MotionFrontDoor'
		timeon = uservariables['SleepTimer']
		cdifference = timedifference(otherdevices_lastupdate[sc])
		ddifference = timedifference(otherdevices_lastupdate[sd])
		edifference = timedifference(otherdevices_lastupdate[se])
		difference = cdifference
		if (ddifference < difference) then
			difference = ddifference
		end
		if (edifference < difference) then
			difference = edifference
		end
		if (fdifference < difference) then
			difference = fdifference
		end
		timewait = timeon * 60
		if (otherdevices[sc] == 'Off' and otherdevices[sd] == 'Off' and otherdevices[se] == 'Closed' and difference >= timewait and sleep == 'Off') then
			commandArray[switchsleep]='On'
		end
	end
end

return commandArray
