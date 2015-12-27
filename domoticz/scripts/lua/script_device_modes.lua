function notify(notSubject, notMessage, notPeople)
	print ('Function triggered! '..notSubject..' - '..notMessage..' - '..notPeople)
	if (notPeople == 'Erik') then
		notErik = 'uIlZfdCTm3'
		result = io.popen("curl -k 'https://api.pilot.patrickferreira.com/"..notErik.."/"..notSubject.."/"..notMessage.."'")
	elseif (notPeople == 'JinHee') then
		notJinHee = 'VJsRPzgoPD'
		result = io.popen("curl -k 'https://api.pilot.patrickferreira.com/"..notJinHee.."/"..notSubject.."/"..notMessage.."'")
	else
		notErik = 'uIlZfdCTm3'
		notJinHee = 'VJsRPzgoPD'
		result = io.popen("curl -k 'https://api.pilot.patrickferreira.com/"..notErik.."/"..notSubject.."/"..notMessage.."'")
		result = io.popen("curl -k 'https://api.pilot.patrickferreira.com/"..notJinHee.."/"..notSubject.."/"..notMessage.."'")
	end
end

commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts == 'Pi2Present') then
	if (otherdevices['People'] == 'On') then
		if (otherdevices['Pi2Present'] == 'On') then
			print('Switching FanHigh to ON, after Pi2 became present')
			commandArray['FanHigh'] = 'On'
		elseif (otherdevices['Pi2Present'] == 'Off') then
			print('Switching FanHigh to OFF, after Pi2 got lost')
			commandArray['FanHigh'] = 'Off'
		end
	else
		print('Switching FanHigh to OFF, because nobody is home when Pi2 became present or got lost')
		commandArray['FanHigh'] = 'Off'
	end
end

if (ts:sub(1,7) == 'FanHigh') then
	if (otherdevices['People'] == 'On') then
		if (otherdevices['FanHigh'] == 'On') then
			if (otherdevices['FanHome'] == 'On') then
				print('Switching FanHome to OFF, after FanHigh was enabled')
				commandArray['FanHome'] = 'Off'
			end
			if (otherdevices['FanMax'] == 'Off') then
				print('Switching FanMax to ON, after FanHigh was enabled')
				commandArray['FanMax'] = 'On'
			end
		end
		if (otherdevices['FanHigh'] == 'Off') then
			if (otherdevices['FanMax'] == 'On') then
				print('Switching FanMax to OFF, after FanHigh was disabled')
				commandArray['FanMax'] = 'Off'
			end
			if (otherdevices['FanHome'] == 'Off') then
				print('Switching FanHome to ON, after FanHigh was disabled')
				commandArray['FanHome'] = 'On'
			end
		end
	else
		print('Switching FanHome and FanMax to OFF, because nobody is home')
		commandArray['FanHome'] = 'Off'
		commandArray['FanMax'] = 'Off'
	end
end

if (ts:sub(1,6) == 'iPhone') then
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
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Switch') then
			if (devicechanged[dc] == 'On') then
				commandArray['Bedroom Humidifier'] = 'On'
				commandArray[1] = {['UpdateDevice'] = "41|0|18"}
			elseif (devicechanged[dc] == 'Off') then
				commandArray['Bedroom Humidifier'] = 'Off'
				commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			end
			sc = i:sub(7)
			scriptfolder = "/home/pi/domoticz/scripts/bash/"
			if (otherdevices[i] == 'On') then
				timenumber = tonumber(os.date("%H")..os.date("%M"))
				time1 = tonumber(uservariables['Timer'..sc..'1'])
				time2 = tonumber(uservariables['Timer'..sc..'2'])
				time3 = tonumber(uservariables['Timer'..sc..'3'])
				time4 = tonumber(uservariables['Timer'..sc..'4'])
				if (time1) then
					scene = 0
				else
					scene = 1
				end
				if (scene == 0 and time1) then
					if (timenumber >= time1) then
						scene = 1
					end
				end
				if (scene == 1 and time2) then
					if (timenumber >= time2) then
						scene = 2
					end
				end
				if (scene == 2 and time3) then
					if (timenumber >= time3) then
						scene = 3
					end
				end
				if (scene == 3 and time4) then
					if (timenumber >= time4) then
						scene = 4
					end
				end
				if (devicechanged[dc] == 'On') then
					scene = 9
				end
				scene = scene..'Slow.sh'
				print ('Switch triggered: '..scriptfolder..sc..'/'..scene)
				os.execute (scriptfolder..sc..'/'..scene)
			end
		end
	end
end

if (ts == 'People') then
	if (devicechanged[dc] == 'On') then
		if (otherdevices['NestAway'] == 'On') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestAway'] = 'Off'
		end
		commandArray['FanMax'] = 'Off'
		commandArray['FanHome'] = 'On'
		commandArray['FanHigh'] = 'Off'
		notify ('HOME', 'Home%20mode%20activated', 'Both')
	elseif (devicechanged[dc] == 'Off') then
		if (otherdevices['NestAway'] == 'Off') then
			commandArray[1] = {['UpdateDevice'] = "41|0|22"}
			commandArray['NestAway'] = 'On'
		end
		notify ('HOME', 'Away%20mode%20activated', 'Both')
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

if (ts == 'ALARM' and devicechanged[dc] == 'On') then
	for i, v in pairs(otherdevices) do
		v = i:sub(1,6)
		if (v == 'Motion' and otherdevices[i] == 'On' and otherdevices['People'] == 'Off') then
			notify ('ALARM', i..'%20is%20ON,%20but%20nobody%20is%20home!', 'Both')
		elseif (v == 'Motion' and otherdevices[i] == 'On' and otherdevices['People'] == 'On') then
			notify ('ALARM', i..'%20is%20ON,%20but%20nobody%20is%20home!', 'Erik')
		end
		if (v == 'Motion' and otherdevices[i] == 'Open' and otherdevices['People'] == 'Off') then
			notify ('ALARM', i..'%20is%20OPEN,%20but%20nobody%20is%20home!', 'Both')
		elseif (v == 'Motion' and otherdevices[i] == 'Open' and otherdevices['People'] == 'On') then
			notify ('ALARM', i..'%20is%20OPEN,%20but%20nobody%20is%20home!', 'Erik')
		end
		if (v == 'Tamper' and otherdevices[i] == 'On' and otherdevices['People'] == 'Off') then
			notify ('ALARM', i..'%20is%20ON,%20but%20nobody%20is%20home!', 'Both')
		elseif (v == 'Tamper' and otherdevices[i] == 'On' and otherdevices['People'] == 'On') then
			notify ('ALARM', i..'%20is%20ON,%20but%20nobody%20is%20home!', 'Erik')
		end
	end
elseif (ts == 'ALARM' and devicechanged[dc] == 'Off' and otherdevices['People'] == 'Off') then
	notify ('ALARM', 'Alarm%20is%20OFF!', 'Both')
end

return commandArray
