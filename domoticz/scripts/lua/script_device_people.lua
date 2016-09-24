commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'People') then
	print ('People changed')
	if (devicechanged[dc] == 'On') then
		print ('People is now ON')
		if (otherdevices['NestActive'] == 'Off') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'On'
		end
		print ('Nest activated')
		commandArray['FanSwitch2'] = 'On'
		print ('Fan switched')
		commandArray['SendNotification']='HOME#HOME mode activated#0#intermission'
		print ('Notification sent')
		commandArray['ModeStandard'] = 'On'
		print ('Mode set to standard')
	elseif (devicechanged[dc] == 'Off') then
		print ('People is now OFF')
		if (otherdevices['NestActive'] == 'On') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestActive'] = 'Off'
		end
		print ('Nest deactivated')
		commandArray['ALARM'] = 'Off'
		print ('Alarm OFF')
		commandArray['FanSwitch3'] = 'Off'
		print ('Fan OFF')
		commandArray['Variable:CoolingMode'] = tostring(0)
		print ('Coolingvariable OFF')
		commandArray['SendNotification']='HOME#AWAY mode activated#0#intermission'
		print ('Notification sent')
--		for i, v in pairs(otherdevices) do
--			v = i:sub(1,6)
--			if (v == 'Switch') then
--				if (otherdevices[i] == 'On') then
--					commandArray[i] = 'Off'
--				end
--			end
--		end
		print ('Switches OFF')
--		for j, w in pairs(otherdevices) do
--			w = j:sub(1,4)
--			if (w == 'Mode') then
--				if (otherdevices[j] == 'On') then
--					commandArray[j] = 'Off'
--				end
--			end
--		end
		print ('Modes OFF')
	end
end

return commandArray
