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

sleepswitch = otherdevices['SleepMode']
sleepswitchname = 'SleepMode'

sleepstart = 2200
sleepstop = 0400

for i, v in pairs(otherdevices) do

	tc = tostring(i)
	v = i:sub(1,6)
	c = i:sub(7)

	if (v == 'Motion' and (c == 'Living' or c == 'Dining ' or c == 'Kitchen') and (timenumber >= sleepstart or timenumber < sleepstop)) then

		c = 'Living'
		d = 'Dining'
		e = 'Kitchen'

		timeon = uservariables['SleepTimer']

		cdifference = timedifference(otherdevices_lastupdate['Motion'..c])
		ddifference = timedifference(otherdevices_lastupdate['Motion'..d])
		edifference = timedifference(otherdevices_lastupdate['Motion'..e])

		difference = cdifference
		if (ddifference < difference) then
			difference = ddifference
		end
		if (edifference < difference) then
			difference = edifference
		end
		
		timewait = timeon * 60

		t = 'Motion'..c
		u = 'Motion'..d
		v = 'Motion'..e

		if (sleepswitch == 'Off' and otherdevices[t] == 'Off' and otherdevices[u] == 'Off' and otherdevices[v] == 'Off' and difference >= timewait and difference < (timewait + 60)) then
			print ("Going to sleep")
			commandArray[sleepswitchname]='On'
		end

	end

end

return commandArray