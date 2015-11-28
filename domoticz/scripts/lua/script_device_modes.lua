commandArray = {}

dc = next(devicechanged)
s = tostring(t)

if (dc == 'SleepMode' or dc == 'People' or dc == 'ALARM') then
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
			end
			if (dc == 'People' and otherdevices[dc] == 'On') then
				if (otherdevices['NestAway'] == 'On') then
					print ('Presence triggered home: Nest switched to home')
					commandArray['NestAway'] = 'Off'
				end
				commandArray['SendNotification']='Presence#Activated HOME mode#0#default'
			elseif (dc == 'People' and otherdevices[dc] == 'Off') then
				if (otherdevices['NestAway'] == 'Off') then
					print ('Presence triggered away: Nest switched to away')
					commandArray['NestAway'] = 'On'
				end
				commandArray['SendNotification']='Presence#Activated AWAY mode#0#default'
				if (otherdevices[t] == 'On') then
					commandArray[t] = 'Off'
				end
			end
		end
		if (dc == 'ALARM' and otherdevices[dc] == 'On' and otherdevices['People'] == 'Off') then
			if (v == 'Motion' and otherdevices[tc] == 'On') then
				commandArray['SendNotification']='ALARM#ALARM: '..tc..' is ON, but nobody is home!#2#default'
			end
			if (v == 'Motion' and otherdevices[tc] == 'Open') then
				commandArray['SendNotification']='ALARM#ALARM: '..tc..' is OPEN, but nobody is home!#2#default'
			end
			if (v == 'Tamper' and otherdevices[tc] == 'On') then
				commandArray['SendNotification']='ALARM#ALARM: '..tc..' is ON, but nobody is home!#2#default'
			end
		end
		if (dc == 'ALARM' and otherdevices[dc] == 'On') then
			commandArray['UpdateDevice']='41|0|24'
		elseif (dc == 'ALARM' and otherdevices[dc] == 'Off') then
			commandArray['UpdateDevice']='41|0|21'
		end
	end
	print (otherdevices_svalues['Room Setpoint'])
end

return commandArray
