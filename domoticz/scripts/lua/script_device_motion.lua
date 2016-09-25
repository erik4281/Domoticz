commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)
presence = otherdevices['People']

if (ts:sub(1,6) == 'Motion' and presence == 'On') then
	sc = ts:sub(7)
	sd = nil
	se = nil
	sf = nil
	sl = nil
	sm = nil
	if (sc == 'Living') then
		sc = 'Living'
		sd = 'Dining'
		sl = 'LivingExtra'
	elseif (sc == 'Dining') then
		sc = 'Living'
		sd = 'Dining'
		sl = 'LivingExtra'
	elseif (sc == 'Kitchen') then
		sc = 'Kitchen'
		sl = 'LivingExtra'
		sm = 'KitchenExtra'
	elseif (sc == 'Hallway') then
		sb = 'Hallway'
		sc = 'Living'
		sl = 'LivingExtra'
		print (ts..' saw motion. Now triggering more switches!!!')
	elseif (sc == 'FrontDoor') then
		sc = 'Hallway'
		sd = 'FrontDoor'
		commandArray['Variable:PeopleTimer'] = tostring(10)
		if (otherdevices['ModeSleep'] == 'On') then
			commandArray['ModeStandard'] = 'On'
		end
	elseif (sc == 'Bedroom') then
		sc = 'Bedroom'
		sl = 'Humidifier'
	elseif (sc == 'Toilet') then
		sc = 'Toilet'
		sd = 'Hallway'
	elseif (sc == 'Bathroom') then
		sc = 'Bathroom'
		sd = 'Hallway'
	end
	mc = 'Motion'..sc
	cbr = tonumber(otherdevices_svalues['Brightness'..sc])
	cbrt = tonumber(uservariables['BrightnessTrigger'..sc])
	if (cbr) then
	else
		cbr = 1
	end
	if (cbrt) then
	else
		cbrt = 250
	end
	if (sb) then
		mb = 'Motion'..sb
	end
	if (sd) then
		md = 'Motion'..sd
	end
	if (se) then
		me = 'Motion'..se
	end
	if (otherdevices[mb] == 'On' or otherdevices[mc] == 'On' or otherdevices[md] == 'On' or otherdevices[me] == 'On' or otherdevices[mc] == 'Open' or otherdevices[md] == 'Open' or otherdevices[me] == 'Open') then
		if (cbr < cbrt) then
			if (otherdevices['Switch'..sc] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sc)
				commandArray['Switch'..sc] = 'On'
			end
			if (sd and otherdevices['Switch'..sd] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sd)
				commandArray['Switch'..sd] = 'On'
			end
			if (se and otherdevices['Switch'..se] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..se)
				commandArray['Switch'..se] = 'On'
			end
		elseif (cbr > (cbrt + 50)) then
			if (otherdevices['Switch'..sc] == 'On') then
				print (ts..' saw motion. Now triggering switch Switch'..sc)
				commandArray['Switch'..sc] = 'Off'
			end
			if (sd and otherdevices['Switch'..sd] == 'On') then
				print (ts..' saw motion. Now triggering switch Switch'..sd)
				commandArray['Switch'..sd] = 'Off'
			end
			if (se and otherdevices['Switch'..se] == 'On') then
				print (ts..' saw motion. Now triggering switch Switch'..se)
				commandArray['Switch'..se] = 'Off'
			end
		end
		if (sb and otherdevices['Switch'..sb] == 'Off') then
			print (ts..' saw motion. Now triggering switch Switch'..sb)
			commandArray['Switch'..sb] = 'On'
		end
		if (sl and otherdevices['Switch'..sl] == 'Off') then
			print (ts..' saw motion. Now triggering switch Switch'..sl)
			commandArray['Switch'..sl] = 'On'
		end
		if (sm and otherdevices['Switch'..sm] == 'Off') then
			print (ts..' saw motion. Now triggering switch Switch'..sm)
			commandArray['Switch'..sm] = 'On'
		end
		commandArray['Variable:PeopleTimer'] = tostring(0)
	end
end

if (ts:sub(1,6) == 'Motion' and presence == 'Off' and (devicechanged[dc] == 'On' or devicechanged[dc] == 'Open')) then
	sc = ts:sub(7)
	if (sc == 'FrontDoor' or sc == 'Hallway') then
	else
		commandArray['SendNotification']='MOTION#Motion'..sc..' was active#0#bike'
		commandArray['ALARM'] = 'On'
	end
	print ('Motion in '..sc..', people are present, switching on light and setting mode to present')
	if (sc == 'Dining') then
		sc = 'Living'
	end
	if (sc == 'FrontDoor') then
		sc = 'Hallway'
	end
	os.execute ('/home/pi/domoticz/scripts/bash/'..sc..'/1.sh')
	commandArray['Switch'..sc] = 'On'
	commandArray['People'] = 'On'
	commandArray['Variable:PeopleTimer'] = tostring(0)

	if (otherdevices['SECURITY'] == 'On') then
		local ping={}

		ping[1]={'B8:53:AC:17:47:D4'}   -- Erik
		ping[2]={'F0:24:75:D0:AF:C2'}   -- JinHee

		for ip = 1, #ping do
			f = assert (io.popen ("hcitool names "..ping[ip][1]))
			bt = f:read()
			if bt==nil then
				commandArray['ALARM'] = 'On'
			else
				commandArray['ALARM'] = 'Off'
			end
			f:close()
		end
	end
end

return commandArray
