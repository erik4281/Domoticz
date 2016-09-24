commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'People') then
	if (devicechanged[dc] == 'On') then
		if (otherdevices['NestActive'] == 'Off') then
			--commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'On'
		end
		commandArray['FanSwitch2'] = 'On'
		commandArray['SendNotification']='HOME#HOME mode activated#0#intermission'
		commandArray['ModeStandard'] = 'On'
	elseif (devicechanged[dc] == 'Off') then
		if (otherdevices['NestActive'] == 'On') then
			--commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'Off'
		end
		commandArray['ALARM'] = 'Off'
		commandArray['FanSwitch3'] = 'Off'
		commandArray['Variable:CoolingMode'] = tostring(0)
		commandArray['SendNotification']='HOME#AWAY mode activated#0#intermission'
		for i, v in pairs(otherdevices) do
			v = i:sub(1,6)
			if (v == 'Switch') then
				if (otherdevices[i] == 'On') then
					commandArray[i] = 'Off'
				end
			end
		end
		for j, w in pairs(otherdevices) do
			w = j:sub(1,4)
			if (w == 'Mode') then
				if (otherdevices[j] == 'On') then
					commandArray[j] = 'Off'
				end
			end
		end
		print ('Modes OFF')
	end
end

return commandArray
