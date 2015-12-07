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

MbE = otherdevices['MacBookAirErik']
MbJ = otherdevices['MacBookAirJinHee']
TvL = otherdevices['TvLiving']

for i, v in pairs(otherdevices) do
	ts = tostring(i)
	v = i:sub(1,6)
	if (v == 'Motion') then
		sc = i:sub(7)
		sd = nil
		se = nil
		sf = nil
		sl = nil
		sm = nil
		if (sc == 'Living') then
			sc = 'Living'
			sd = 'Dining'
			se = 'Kitchen'
			sl = 'LivingExtra'
			sm = 'KitchenExtra'
		elseif (sc == 'Dining') then
			sc = 'Living'
			sd = 'Dining'
			se = 'Kitchen'
			sl = 'LivingExtra'
			sm = 'KitchenExtra'
		elseif (sc == 'Kitchen') then
			sc = 'Kitchen'
			sl = 'KitchenExtra'
		elseif (sc == 'Hallway') then
			sc = 'Hallway'
			sd = 'FrontDoor'
			se = 'Toilet'
			sf = 'Bathroom'
		elseif (sc == 'FrontDoor') then
			sc = 'Hallway'
			sd = 'FrontDoor'
			se = 'Toilet'
			sf = 'Bathroom'
		end
		motioncheck = 'Off'
		mc = 'Motion'..sc
		ctimeon = uservariables['WaitOff'..sc]
		cdifference = timedifference(otherdevices_lastupdate[mc])
		if (otherdevices[mc] == 'On' or otherdevices[mc] == 'Open') then
			motioncheck = 'On'
		end
		if (sd) then
			md = 'Motion'..sd
			dtimeon = uservariables['WaitOff'..sd]
			ddifference = timedifference(otherdevices_lastupdate[md])
			if (otherdevices[md] == 'On' or otherdevices[md] == 'Open') then
				motioncheck = 'On'
			end
		end
		if (se) then
			me = 'Motion'..se
			etimeon = uservariables['WaitOff'..se]
			edifference = timedifference(otherdevices_lastupdate[me])
			if (otherdevices[me] == 'On' or otherdevices[me] == 'Open') then
				motioncheck = 'On'
			end
		end
		if (sf) then
			mf = 'Motion'..sf
			ftimeon = uservariables['WaitOff'..sf]
			fdifference = timedifference(otherdevices_lastupdate['Motion'..sf])
			if (otherdevices[mf] == 'On' or otherdevices[mf] == 'Open') then
				motioncheck = 'On'
			end
		end
		difference = cdifference
		if (sd and (ddifference < difference)) then
			difference = ddifference
		end
		if (se and (edifference < difference)) then
			difference = edifference
		end
		if (sf and (fdifference < difference)) then
			difference = fdifference
		end
		timeon = ctimeon
		if (sd and (dtimeon > timeon)) then
			timeon = dtimeon
		end
		if (se and (etimeon > timeon)) then
			timeon = etimeon
		end
		if (sf and (ftimeon > timeon)) then
			timeon = ftimeon
		end
		if (sc == 'Living' and (MbE == 'On' or MbJ == 'On' or Tv: == 'On')) then
			timeon = timeon + 75
		end
		if (sc == 'Study' and (MbE == 'On' or MbJ == 'On')) then
			timeon = timeon + 75
		end
		timewait = timeon * 60
		if (motioncheck == 'Off' and difference >= timewait) then
			if (otherdevices['Switch'..sc] == 'On') then
				print (ts..' saw no more motion. Now triggering switch Switch'..sc)
				commandArray['Switch'..sc] = 'Off'
			end
			if (sl and otherdevices['Switch'..sl] == 'On') then
				print (ts..' saw no more motion. Now triggering switch Switch'..sl)
				commandArray['Switch'..sl] = 'Off'
			end
			if (sm and otherdevices['Switch'..sm] == 'On') then
				print (ts..' saw no more motion. Now triggering switch Switch'..sm)
				commandArray['Switch'..sm] = 'Off'
			end
		end
	end
end
 
return commandArray
