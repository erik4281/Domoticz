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
HaL = otherdevices['HarmonyLiving']
HaB = otherdevices['HarmonyBedroom']

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
			print (otherdevices[v..sc])
			print (timedifference(otherdevices_lastupdate[v..sc]))
			print (uservariables['KitchenMotionOn'])
			print (uservariables['KitchenMotionOff'])
			if (otherdevices[v..sc] == 'On' or timedifference(otherdevices_lastupdate[v..sc]) < 120) then
				commandArray['Variable:KitchenMotionOff'] = tostring(0)
				--if (uservariables['KitchenMotionOn'] < 1) then
				--	commandArray['Variable:KitchenMotionOn'] = tostring(1)
				--else 
					commandArray['Variable:KitchenMotionOn'] = tostring(uservariables['KitchenMotionOn'] + 1)
				--end
			elseif (otherdevices[v..sc] == 'Off' and timedifference(otherdevices_lastupdate[v..sc]) > 120) then
				commandArray['Variable:KitchenMotionOn'] = tostring(0)
				--if (uservariables['KitchenMotionOff'] < 1) then
				--	commandArray['Variable:KitchenMotionOff'] = tostring(1)
				--else 
					commandArray['Variable:KitchenMotionOff'] = tostring(uservariables['KitchenMotionOff'] + 1)
				--end
			end
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
		sleeping = ''
		if (otherdevices['SleepMode'] == 'On') then
			sleeping = 'Sleep'
		end
		ctimeon = uservariables['WaitOff'..sc..sleeping]
		adifference = timedifference(otherdevices_lastupdate['Switch'..sc])
		cdifference = timedifference(otherdevices_lastupdate[mc])
		if (otherdevices[mc] == 'On' or otherdevices[mc] == 'Open') then
			motioncheck = 'On'
		end
		if (sd) then
			md = 'Motion'..sd
			dtimeon = uservariables['WaitOff'..sd..sleeping]
			ddifference = timedifference(otherdevices_lastupdate[md])
			if (otherdevices[md] == 'On' or otherdevices[md] == 'Open') then
				motioncheck = 'On'
			end
		end
		if (se) then
			me = 'Motion'..se
			etimeon = uservariables['WaitOff'..se..sleeping]
			edifference = timedifference(otherdevices_lastupdate[me])
			if (otherdevices[me] == 'On' or otherdevices[me] == 'Open') then
				motioncheck = 'On'
			end
		end
		if (sf) then
			mf = 'Motion'..sf
			ftimeon = uservariables['WaitOff'..sf..sleeping]
			fdifference = timedifference(otherdevices_lastupdate['Motion'..sf])
			if (otherdevices[mf] == 'On' or otherdevices[mf] == 'Open') then
				motioncheck = 'On'
			end
		end
		difference = adifference
		if (cdifference < difference) then
			difference = cdifference
		end
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
		if (sc == 'Living' and (MbE == 'On' or MbJ == 'On' or TvL == 'On' or HaL == 'On')) then
			timeon = timeon + 75
		end
		if (sc == 'Study' and (MbE == 'On' or MbJ == 'On')) then
			timeon = timeon + 75
		end
		if (sc == 'Bedroom' and HaB == 'On') then
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
