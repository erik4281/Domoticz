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
FanOn = uservariables['WaitOnFan']
FanOff = uservariables['WaitOffFan']

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
			if (otherdevices[v..sc] == 'On' or timedifference(otherdevices_lastupdate[v..sc]) < 61) then
				commandArray['Variable:FanMotionOn'] = tostring(uservariables['FanMotionOn'] + 1)
				if (otherdevices['FanSwitch3'] == 'Off' or uservariables['FanMotionOn'] > 5) then
					commandArray['Variable:FanMotionOff'] = tostring(0)
				end
				if (uservariables['FanMotionOn'] >= FanOn and otherdevices['FanSwitch3'] == 'Off' and timedifference(otherdevices_lastupdate['FanSwitch3']) > (FanOn * 60) and otherdevices['ALARM'] == 'Off') then
					commandArray['FanSwitch3'] = 'On'
				end
			elseif (otherdevices[v..sc] == 'Off' and timedifference(otherdevices_lastupdate[v..sc]) > 61) then
				if (uservariables['FanMotionOn'] > 0) then
					commandArray['Variable:FanMotionOn'] = tostring(0)
				end
				if (otherdevices['FanSwitch3'] == 'On') then
					commandArray['Variable:FanMotionOff'] = tostring(uservariables['FanMotionOff'] + 1)
				end
				if (uservariables['FanMotionOff'] >= FanOff and otherdevices['FanSwitch3'] == 'On' and timedifference(otherdevices_lastupdate['FanSwitch3']) > (FanOff * 60) and uservariables['CoolingMode'] == 0) then
					commandArray['FanSwitch3'] = 'Off'
				end
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
--			sl = 'DoorOpened'
		elseif (sc == 'Bedroom') then
			sc = 'Bedroom'
			if (otherdevices['ModeSleep'] == 'Off') then
				sl = 'Humidifier'
			end
		end
		motioncheck = 'Off'
		mc = 'Motion'..sc
		sleeping = ''
		if (otherdevices['ModeSleep'] == 'On') then
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
		if (sc == 'Living' and (MbE == 'On' or MbJ == 'On' or TvL == 'On')) then
			timeon = timeon + 15
		end
		if (sc == 'Study' and (MbE == 'On' or MbJ == 'On')) then
			timeon = timeon + 45
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
