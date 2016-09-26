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
difference = timedifference(otherdevices_lastupdate['MotionFrontDoor'])
timewait = 9000

if (door == 'Closed' and ((difference < timewait) or (otherdevices['ALARM'] == 'On'))) then
	print ('Difference = '..difference)
	if (otherdevices['People'] == 'On') then
		motion = 0
		for i, v in pairs(otherdevices) do
			v = i:sub(1,6)
	print ('Difference 2 = '..difference)
			if (v == 'Motion' and motion < 2 and timedifference(otherdevices_lastupdate[i]) < 60) then
				motion = 1
				print (i..' was updated in the last minute!!!')
			end
			if (v == 'Motion' and (otherdevices[i] == 'On' or timedifference(otherdevices_lastupdate[i]) < 30) and difference < timewait and difference > 60) then
				motion = 2
				print (i..' was ON in the last minute!!!')
			end
			if (v == 'Motion' and (otherdevices[i] == 'On' or timedifference(otherdevices_lastupdate[i]) < 30) and otherdevices['ALARM'] == 'On' and timedifference(otherdevices_lastupdate['ALARM']) > 60 and difference > 60) then
				motion = 2
				print (i..' was ON in the last minute!!! This was triggered because an alarm was active!')
			end
		end
		print ('Time Presence Check: PeopleTimer: '..tostring(uservariables['PeopleTimer'])..', Motion: '..motion)
		if (motion == 0) then
			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'] + 1)
			if (uservariables['PeopleTimer'] > 15) then
				commandArray['People'] = 'Off'
			end
		elseif (motion == 1) then
			commandArray['Variable:PeopleTimer'] = tostring(uservariables['PeopleTimer'])
		elseif (motion == 2) then
			commandArray['Variable:PeopleTimer'] = tostring(0)
			if (timedifference(otherdevices_lastupdate['ALARM']) > 600) then
				commandArray['ALARM'] = 'Off'
			end
		end
	end
elseif (door == 'Closed' and difference > 900 and otherdevices['People'] == 'Off') then
	if (otherdevices['FanSwitch2'] == 'On' or otherdevices['FanSwitch3'] == 'On') then
		commandArray['FanSwitch2'] = 'Off'
		commandArray['FanSwitch3'] = 'Off'
	end
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch' and otherdevices[i] == 'On') then
			commandArray[i] = 'Off'
		end
	end
end

if (otherdevices['ALARM'] == 'On') then
	local ping={}

	ping[1]={'B8:53:AC:17:47:D4'}   -- Erik
	ping[2]={'F0:24:75:D0:AF:C2'}   -- JinHee

	for ip = 1, #ping do
		f = assert (io.popen ("hcitool names "..ping[ip][1]))
		bt = f:read()
		if bt==nil then
		else
			commandArray['ALARM'] = 'Off'
		end
		f:close()
	end
end

if (otherdevices['ALARM'] == 'On' and otherdevices['SECURITY'] == 'On' and timedifference(otherdevices_lastupdate['ALARM']) > 60) then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Motion' and (otherdevices[i] == 'On' or timedifference(otherdevices_lastupdate[i]) < 30)) then
			commandArray['SendNotification']='ALARM#'..i..' is ON!#1#siren'
		elseif (v == 'Motion' and (otherdevices[i] == 'Open' or timedifference(otherdevices_lastupdate[i]) < 30)) then
			commandArray['SendNotification']='ALARM#'..i..' is OPEN!#1#siren'
		end
	end
	commandArray['ALARM'] = 'Off'
	commandArray['People'] = 'Off'
end

return commandArray
