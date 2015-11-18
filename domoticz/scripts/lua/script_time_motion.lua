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
 
for i, v in pairs(otherdevices) do

	tc = tostring(i)
	v = i:sub(1,6)

	if (v == 'Motion') then

		c = i:sub(7)
		d = nil
		e = nil
		f = nil
		l = nil
		m = nil

		if (c == 'Living') then
			c = 'Living'
			d = 'Dining'
			e = 'Kitchen'
			l = 'LivingExtra'
			m = 'KitchenExtra'
		elseif (c == 'Dining') then
			c = 'Living'
			d = 'Dining'
			e = 'Kitchen'
			l = 'LivingExtra'
			m = 'KitchenExtra'
		elseif (c == 'Kitchen') then
			c = 'Kitchen'
			l = 'KitchenExtra'
			m = nothing
		elseif (c == 'Hallway') then
			c = 'Hallway'
			d = 'FrontDoor'
			e = 'Toilet'
			f = 'Bathroom'
		elseif (c == 'FrontDoor') then
			c = 'Hallway'
			d = 'FrontDoor'
			e = 'Toilet'
			f = 'Bathroom'
		end

		motioncheck = 'Off'

		t = 'Motion'..c
		ctimeon = uservariables['WaitOff'..c]
		cdifference = timedifference(otherdevices_lastupdate[t])
		if (otherdevices[t] == 'On') then
			motioncheck = 'On'
		end

		if (d) then
			u = 'Motion'..d
			dtimeon = uservariables['WaitOff'..d]
			ddifference = timedifference(otherdevices_lastupdate[u])
			if (otherdevices[u] == 'On') then
				motioncheck = 'On'
			end
		end
		if (e) then
			v = 'Motion'..e
			etimeon = uservariables['WaitOff'..e]
			edifference = timedifference(otherdevices_lastupdate[v])
			if (otherdevices[v] == 'On') then
				motioncheck = 'On'
			end
		end
		if (f) then
			w = 'Motion'..f
			ftimeon = uservariables['WaitOff'..f]
			fdifference = timedifference(otherdevices_lastupdate['Motion'..f])
			if (otherdevices[w] == 'On') then
				motioncheck = 'On'
			end
		end

		difference = cdifference
		if (d and (ddifference < difference)) then
			difference = ddifference
		end
		if (e and (edifference < difference)) then
			difference = edifference
		end
		if (f and (fdifference < difference)) then
			difference = fdifference
		end
		
		timeon = ctimeon
		if (d and (dtimeon > timeon)) then
			timeon = dtimeon
		end
		if (e and (etimeon > timeon)) then
			timeon = etimeon
		end
		if (f and (ftimeon > timeon)) then
			timeon = ftimeon
		end

		timewait = timeon * 60

		if (motioncheck == 'Off' and difference >= timewait and difference < (timewait + 60)) then
			if (otherdevices['Switch'..c] == 'On') then
				print (tc..' saw no more motion. Now triggering switch Switch'..c)
				commandArray['Switch'..c] = 'Off'
			end
			if (l and otherdevices['Switch'..l] == 'On') then
				print (tc..' saw no more motion. Now triggering switch Switch'..l)
				commandArray['Switch'..l] = 'Off'
			end
			if (m and otherdevices['Switch'..l] == 'On') then
				print (tc..' saw no more motion. Now triggering switch Switch'..m)
				commandArray['Switch'..m] = 'Off'
			end
		end

	end

end
 
return commandArray