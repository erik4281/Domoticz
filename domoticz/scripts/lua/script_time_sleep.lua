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
	if (presence == 'On' and sleep == 'Off' and v == 'Switch' and (sc == 'Living' or sc == 'Kitchen') and (timenumber >= sleepstart or timenumber < sleepstop)) then
		sc = 'Living'
		sd = 'Kitchen'
		timeon = uservariables['SleepTimer']
		cdifference = timedifference(otherdevices_lastupdate['Switch'..sc])
		ddifference = timedifference(otherdevices_lastupdate['Switch'..sd])
		difference = cdifference
		if (ddifference < difference) then
			difference = ddifference
		end
		if (edifference < difference) then
			difference = edifference
		end
		timewait = timeon * 60
		mc = 'Switch'..sc
		md = 'Switch'..sd
		if (otherdevices[mc] == 'Off' and otherdevices[md] == 'Off' and difference >= timewait and difference < (timewait + 60)) then
			commandArray[switchsleep]='On'
		end
	end
end

return commandArray
