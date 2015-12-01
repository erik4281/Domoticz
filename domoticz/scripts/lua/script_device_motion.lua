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
	elseif (sc == 'FrontDoor') then
		sc = 'Hallway'
		sd = 'FrontDoor'
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
	if (sd) then
		md = 'Motion'..sd
	end
	if (se) then
		me = 'Motion'..se
	end
	if (otherdevices[mc] == 'On' or otherdevices[md] == 'On' or otherdevices[me] == 'On' or otherdevices[mc] == 'Open' or otherdevices[md] == 'Open' or otherdevices[me] == 'Open') then
		if (cbr < cbrt) then
			if (otherdevices['Switch'..sc] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sc)
				commandArray['Switch'..sc] = 'On'
			end
			if (d and otherdevices['Switch'..sd] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sd)
				commandArray['Switch'..sd] = 'On'
			end
			if (e and otherdevices['Switch'..se] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..se)
				commandArray['Switch'..se] = 'On'
			end
			if (l and otherdevices['Switch'..sl] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sl)
				commandArray['Switch'..sl] = 'On'
			end
			if (m and otherdevices['Switch'..sm] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sm)
				commandArray['Switch'..sm] = 'On'
			end
		else
			if (otherdevices['Switch'..sc] == 'On') then
				print (ts..' saw motion. Now triggering switch Switch'..sc)
				commandArray['Switch'..sc] = 'Off'
			end
			if (d and otherdevices['Switch'..sd] == 'On') then
				print (ts..' saw motion. Now triggering switch Switch'..sd)
				commandArray['Switch'..sd] = 'Off'
			end
			if (e and otherdevices['Switch'..se] == 'On') then
				print (ts..' saw motion. Now triggering switch Switch'..se)
				commandArray['Switch'..se] = 'Off'
			end
			if (l and otherdevices['Switch'..sl] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sl)
				commandArray['Switch'..sl] = 'On'
			end
			if (m and otherdevices['Switch'..sm] == 'Off') then
				print (ts..' saw motion. Now triggering switch Switch'..sm)
				commandArray['Switch'..sm] = 'On'
			end
		end
	end
end

if (ts:sub(1,6) == 'Tamper' and presence == 'On' and devicechanged[dc] == 'On') then
	if (otherdevices['ALARM'] == 'Off') then
		commandArray['ALARM'] = 'On'
	end
elseif (ts:sub(1,6) == 'Tamper' and presence == 'On' and devicechanged[dc] == 'Off') then
	if (otherdevices['ALARM'] == 'On') then
		commandArray['ALARM'] = 'Off'
	end
end

return commandArray
