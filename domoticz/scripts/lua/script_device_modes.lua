commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'FanSwitch2') then
	if (otherdevices['People'] == 'On' and otherdevices['FanSwitch2'] == 'Off') then
		commandArray['FanSwitch2'] = 'On'
	elseif (otherdevices['People'] == 'Off' and otherdevices['FanSwitch2'] == 'On') then
		commandArray['FanSwitch2'] = 'Off'
	end
end

if (ts == 'FanSwitch3') then
	if (otherdevices['People'] == 'Off' and otherdevices['FanSwitch3'] == 'On') then
		commandArray['FanSwitch3'] = 'Off'
	end
end

if (ts:sub(1,6) == 'iPhone') then
	print((otherdevices_lastupdate[dc]))
	if (devicechanged[dc] == 'On') then
		ph = ts:sub(7)
		commandArray['SendNotification']='PEOPLE#'..ph..' has arrived#0#bike'
	elseif (devicechanged[dc] == 'Off') then
		ph = ts:sub(7)
		commandArray['SendNotification']='PEOPLE#'..ph..' has departed#0#bike'
	end
	if (otherdevices['iPhoneErik'] == 'On' or otherdevices['iPhoneJinHee'] == 'On') then
		if (otherdevices['Phones'] == 'Off') then
			commandArray['Phones'] = 'On'
		end
		if (otherdevices['People'] == 'Off') then
			commandArray['People'] = 'On'
		end
	end
	if (otherdevices['iPhoneErik'] == 'Off' and otherdevices['iPhoneJinHee'] == 'Off') then
		if (otherdevices['Phones'] == 'On') then
			commandArray['Phones'] = 'Off'
		end
	end
end

if (ts == 'SleepMode') then
	if (devicechanged[dc] == 'On') then
		commandArray['Bedroom Humidifier'] = 'On'
		commandArray[1] = {['UpdateDevice'] = "41|0|18"}
	elseif (devicechanged[dc] == 'Off') then
		commandArray['Bedroom Humidifier'] = 'Off'
		commandArray[1] = {['UpdateDevice'] = "41|0|22"}
	end
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch') then
			sc = i:sub(7)
			scriptfolder = "/home/pi/domoticz/scripts/bash/"
			if (otherdevices[i] == 'On') then
				commandArray[i] = 'On'
				--timenumber = tonumber(os.date("%H")..os.date("%M"))
				--time1 = tonumber(uservariables['Timer'..sc..'1'])
				--time2 = tonumber(uservariables['Timer'..sc..'2'])
				--time3 = tonumber(uservariables['Timer'..sc..'3'])
				--time4 = tonumber(uservariables['Timer'..sc..'4'])
				--if (time1) then
				--	scene = 0
				--else
				--	scene = 1
				--end
				--if (scene == 0 and time1) then
				--	if (timenumber >= time1) then
				--		scene = 1
				--	end
				--end
				--if (scene == 1 and time2) then
				--	if (timenumber >= time2) then
				--		scene = 2
				--	end
				--end
				--if (scene == 2 and time3) then
				--	if (timenumber >= time3) then
				--		scene = 3
				--	end
				--end
				--if (scene == 3 and time4) then
				--	if (timenumber >= time4) then
				--		scene = 4
				--	end
				--end
				--if (devicechanged[dc] == 'On') then
				--	scene = 9
				--end
				--scene = scene..'Slow.sh'
				--print ('Switch triggered: '..scriptfolder..sc..'/'..scene)
				--os.execute (scriptfolder..sc..'/'..scene)
			end
		end
	end
end

if (ts == 'People') then
	if (devicechanged[dc] == 'On') then
		if (otherdevices['NestActive'] == 'Off') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'On'
		end
		commandArray['FanSwitch2'] = 'On'
		commandArray['SendNotification']='HOME#HOME mode activated#0#intermission'
	elseif (devicechanged[dc] == 'Off') then
		if (otherdevices['NestActive'] == 'On') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'Off'
		end
		commandArray['FanSwitch3'] = 'Off'
		commandArray['SendNotification']='HOME#AWAY mode activated#0#intermission'
		for i, v in pairs(otherdevices) do
			v = i:sub(1,6)
			if (v == 'Switch') then
				if (otherdevices[i] == 'On') then
					commandArray[i] = 'Off'
				end
			end
		end
	end
end

if (ts == 'NestActive') then
	if (devicechanged[dc] == 'On') then
		commandArray['NestAway'] = 'Off'
	elseif (devicechanged[dc] == 'Off') then
		commandArray['NestAway'] = 'On'
	end
end

if (ts == 'ALARM' and devicechanged[dc] == 'On') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Motion' and otherdevices[i] == 'On') then
			commandArray['SendNotification']='ALARM#'..i..' is ON!#1#siren'
		elseif (v == 'Motion' and otherdevices[i] == 'Open') then
			commandArray['SendNotification']='ALARM#'..i..' is OPEN!#1#siren'
		end
	end
elseif (ts == 'ALARM' and devicechanged[dc] == 'Off') then
	commandArray['SendNotification']='ALARM#Alarm is OFF#1#siren'
end

return commandArray
