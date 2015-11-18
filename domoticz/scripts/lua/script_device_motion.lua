commandArray = {}

t = next(devicechanged)
s = tostring(t)

if (s:sub(1,6) == 'Motion' and otherdevices['People'] == 'On') then
	c = s:sub(7)
	d = nil
	e = nil
	f = nil
	l = nil
	m = nil
	if (c == 'FrontDoor') then
		commandArray['TriggerDoor'] = 'On'
	elseif (devicechanged[t] == 'On') then
		commandArray['TriggerDoor'] = 'Off'
	end
	if (c == 'Living') then
		c = 'Living'
		d = 'Dining'
		l = 'LivingExtra'
	elseif (c == 'Dining') then
		c = 'Living'
		d = 'Dining'
		l = 'LivingExtra'
	elseif (c == 'Kitchen') then
		c = 'Kitchen'
		d = 'Living'
		e = 'Dining'
		l = 'LivingExtra'
		m = 'KitchenExtra'
	elseif (c == 'FrontDoor') then
		c = 'Hallway'
		d = 'FrontDoor'
	elseif (c == 'Toilet') then
		c = 'Toilet'
		d = 'Hallway'
	elseif (c == 'Bathroom') then
		c = 'Bathroom'
		d = 'Hallway'
	end
	t = 'Motion'..c
	cbr = tonumber(otherdevices_svalues['Brightness'..c])
	cbrt = tonumber(uservariables['BrightnessTrigger'..c])
	if (cbr) then
	else
		cbr = 1
	end
	if (cbrt) then
	else
		cbrt = 250
	end
	if (d) then
		u = 'Motion'..d
	end
	if (e) then
		v = 'Motion'..e
	end
	if (otherdevices[t] == 'On' or otherdevices[u] == 'On' or otherdevices[v] == 'On') then
		if (cbr < cbrt) then
			if (otherdevices['Switch'..c] == 'Off') then
				print (s..' saw motion. Now triggering switch Switch'..c)
				commandArray['Switch'..c] = 'On'
			end
			if (d and otherdevices['Switch'..d] == 'Off') then
				print (s..' saw motion. Now triggering switch Switch'..d)
				commandArray['Switch'..d] = 'On'
			end
			if (e and otherdevices['Switch'..e] == 'Off') then
				print (s..' saw motion. Now triggering switch Switch'..e)
				commandArray['Switch'..e] = 'On'
			end
			if (l and otherdevices['Switch'..l] == 'Off') then
				print (s..' saw motion. Now triggering switch Switch'..l)
				commandArray['Switch'..l] = 'On'
			end
			if (m and otherdevices['Switch'..m] == 'Off') then
				print (s..' saw motion. Now triggering switch Switch'..m)
				commandArray['Switch'..m] = 'On'
			end
		else
			if (otherdevices['Switch'..c] == 'On') then
				print (s..' saw motion. Now triggering switch Switch'..c)
				commandArray['Switch'..c] = 'Off'
			end
			if (d and otherdevices['Switch'..d] == 'On') then
				print (s..' saw motion. Now triggering switch Switch'..d)
				commandArray['Switch'..d] = 'Off'
			end
			if (e and otherdevices['Switch'..e] == 'On') then
				print (s..' saw motion. Now triggering switch Switch'..e)
				commandArray['Switch'..e] = 'Off'
			end
			if (l and otherdevices['Switch'..l] == 'Off') then
				print (s..' saw motion. Now triggering switch Switch'..l)
				commandArray['Switch'..l] = 'On'
			end
			if (m and otherdevices['Switch'..m] == 'Off') then
				print (s..' saw motion. Now triggering switch Switch'..m)
				commandArray['Switch'..m] = 'On'
			end
		end
	end
end

return commandArray
