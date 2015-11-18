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
doortime = otherdevices_lastupdate['MotionFrontDoor']
presenceswitch = otherdevices['People']
presenceswitchname = 'People'

for i, v in pairs(otherdevices) do

	tc = tostring(i)
	v = i:sub(1,6)
	c = i:sub(7)

	if (v == 'Motion' and c == 'FrontDoor') then

		timeon = uservariables['DepartTimer']
		difference = timedifference(otherdevices_lastupdate[tc])
		timewait = timeon * 60

		if (door == 'Off' and uservariables['MotionTrigger'] == '0' and difference >= timewait and difference < (timewait + 600)) then
			print ("Departing")
			commandArray[presenceswitchname]='Off'
		end

	end

end

return commandArray