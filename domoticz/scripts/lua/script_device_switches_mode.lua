commandArray = {}

dc = next(devicechanged)
s = tostring(t)

if (dc == 'SleepMode' or dc == 'People') then
	for i, v in pairs(otherdevices) do
		tc = tostring(i)
		v = i:sub(1,6)
		if (v == 'Switch') then
			c = i:sub(7)
			t = 'Switch'..c
			scriptfolder = "/home/pi/domoticz/scripts/bash/"
			if (dc == 'SleepMode' and otherdevices[dc] == 'On') then
				commandArray['Bedroom Humidifier'] = 'On'
				if (otherdevices[t] == 'On') then
					scene = '9Slow.sh'
					print ('SleepMode triggered sleep: '..scriptfolder..c..'/'..scene)
					os.execute (scriptfolder..c..'/'..scene)
				end
			elseif (dc == 'SleepMode' and otherdevices[dc] == 'Off') then
				commandArray['Bedroom Humidifier'] = 'Off'
				if (otherdevices[t] == 'On') then
					scene = '1Slow.sh'
					print ('SleepMode triggered wake: '..scriptfolder..c..'/'..scene)
					os.execute (scriptfolder..c..'/'..scene)
				end
			elseif (dc == 'People' and otherdevices[dc] == 'Off') then
				scene = 'Off.sh'
				print ('Presence triggered away: '..scriptfolder..c..'/'..scene)
				os.execute (scriptfolder..c..'/'..scene)
			end
		end
	end
end

return commandArray
