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

time = os.date("*t")
timenumber = tonumber(os.date("%H")..os.date("%M"))
timehour = tonumber(os.date("%H"))
timeminute = tonumber(os.date("%M"))
loopminute = tonumber(uservariables['LoopMinute'])
weekday = tonumber(os.date("%w"))

for i, v in pairs(otherdevices) do
	ts = tostring(i)
	v = i:sub(1,6)
	if (v == 'Switch' and i ~= 'SwitchDoorOpened') then
		sc = i:sub(7)
		scriptfolder = "/home/pi/domoticz/scripts/bash/"
		if (otherdevices[ts] == 'On') then
			difference = timedifference(otherdevices_lastupdate[ts])
			wk = ''
			if ((weekday == 0 and timehour < 18) or weekday == 6 or (weekday == 5 and timehour > 18)) then
				wk = 'Weekend'
			end
			time0 = tonumber(uservariables['Timer'..sc..'0'..wk])
			time1 = tonumber(uservariables['Timer'..sc..'1'..wk])
			time2 = tonumber(uservariables['Timer'..sc..'2'..wk])
			time3 = tonumber(uservariables['Timer'..sc..'3'..wk])
			time4 = tonumber(uservariables['Timer'..sc..'4'..wk])
			execute = 0
			looping = 0
			if (sc == 'LivingExtra') then
				if (timeminute == loopminute) then
					scene = 'Colorloop.sh'
					print ('Colorloop triggered: '..scriptfolder..sc..'/'..scene)
					os.execute (scriptfolder..sc..'/'..scene)
					looping = 1
				elseif ((timeminute == loopminute + 1) or (timeminute == loopminute + 2)) then
					difference = 30
					looping = 1
				end
			end
			if (difference >= 1 and difference < 121) then
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
				if (otherdevices['ModeSleep'] == 'On') then
					scene = 'Sleep'
				end
				if (otherdevices['ModeBright'] == 'On') then
					scene = 'Bright'
				end
				if (otherdevices['ModeMovie'] == 'On' and (sc == 'Living' or sc == 'LivingExtra')) then
					scene = 'Movie'
				end
				scene = scene..'.sh'
				if (difference < 61) then
					print ('First backup triggered: '..scriptfolder..sc..'/'..scene)
				else
					print ('Final backup triggered: '..scriptfolder..sc..'/'..scene)
				end
				os.execute (scriptfolder..sc..'/'..scene)
				scene = 1
			end
			if (time1) then
				scene = 0
			else
				scene = 1
			end
			if (time0) then
				if (timenumber == time0) then
					scene = '0Slow'
					execute = 1
				end
			end
			if (time1) then
				if (timenumber == time1) then
					scene = '1Slow'
					execute = 1
				end
			end
			if (time2) then
				if (timenumber == time2) then
					scene = '2Slow'
					execute = 1
				end
			end
			if (time3) then
				if (timenumber == time3) then
					scene = '3Slow'
					execute = 1
				end
			end
			if (time4) then
				if (timenumber == time4) then
					scene = '4Slow'
					execute = 1
				end
			end
			scene = scene..'.sh'
			if (looping == 0 and execute == 1 and otherdevices['ModeStandard'] == 'On') then
				print ('Time triggered: '..scriptfolder..sc..'/'..scene)
				os.execute (scriptfolder..sc..'/'..scene)
				execute = 0
			end
		elseif (otherdevices[ts] == 'Off') then
			difference = timedifference(otherdevices_lastupdate[ts])
			if (difference >= 1 and difference < 121) then
				scene = 'Off'
				checkbright = sc
				if (sc == 'LivingExtra') then
					checkbright = 'Living'
				elseif (sc == 'KitchenExtra') then
					checkbright = 'Kitchen'
				end
				cbr = tonumber(otherdevices_svalues['Brightness'..checkbright])
				cbrt = tonumber(uservariables['BrightnessTrigger'..checkbright])
				if (cbr) then
				else
					cbr = 1
				end
				if (cbrt) then
				else
					cbrt = 250
				end
				if (otherdevices['ModeDimming'] == 'On' and cbr < cbrt) then
					scene = 'Dimming'
				end
				if (otherdevices['ModeBright'] == 'On' and cbr < cbrt) then
					scene = 'Bright'
				end
				scene = scene..'.sh'
				if (difference < 61) then
					print ('First backup triggered: '..scriptfolder..sc..'/'..scene)
				else
					print ('Final backup triggered: '..scriptfolder..sc..'/'..scene)
				end
				os.execute (scriptfolder..sc..'/'..scene)
			end
		end
	end
end

for i, v in pairs(otherdevices) do
	ts = tostring(i)
	if (ts == 'FanSwitch3' and otherdevices['People'] == 'On') then
		if (otherdevices[ts] == 'Off' and ((otherdevices['TemperatureLiving']) > (otherdevices['TempHumBar']:sub(1,4) + 5)) and (otherdevices['TemperatureLiving'] - 1) > 23) then
			print ('Living is hotter than outside and hotter than setpoint, fan is low and will be set to high')
			commandArray['FanSwitch3'] = 'On'
			commandArray['Variable:CoolingMode'] = tostring(1)
		end
		if (otherdevices[ts] == 'On' and ((otherdevices['TemperatureLiving']) < (otherdevices['TempHumBar']:sub(1,4) + 5))) then
			print ('Living is colder than outside and hotter than setpoint, fan is high and will be set to normal')
			commandArray['FanSwitch3'] = 'Off'
			commandArray['Variable:CoolingMode'] = tostring(0)
		end
	end
end

return commandArray
