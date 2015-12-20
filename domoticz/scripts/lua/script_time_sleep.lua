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

timenumber = tonumber(os.date("%H")..os.date("%M"))
sleep = otherdevices['SleepMode']
switchsleep = 'SleepMode'
presence = otherdevices['People']
sleepstart = 2200
sleepstop = 0600
wakeup = otherdevices['WakeUpLight']
wakeuptime = tonumber(uservariables['WakeUpLightTime'])

for i, v in pairs(otherdevices) do
	ts = tostring(i)
	v = i:sub(1,6)
	sc = i:sub(7)
	if (presence == 'On' and sleep == 'Off' and (ts == 'SwitchLiving' or ts == 'SwitchKitchen'or ts == 'MotionFrontDoor') and (timenumber >= sleepstart or timenumber < sleepstop)) then
		sc = 'SwitchLiving'
		sd = 'SwitchKitchen'
		se = 'MotionFrontDoor'
		timeon = uservariables['SleepTimer']
		cdifference = timedifference(otherdevices_lastupdate[sc])
		ddifference = timedifference(otherdevices_lastupdate[sd])
		edifference = timedifference(otherdevices_lastupdate[se])
		difference = cdifference
		if (ddifference < difference) then
			difference = ddifference
		end
		if (edifference < difference) then
			difference = edifference
		end
		timewait = timeon * 60
		if (otherdevices[sc] == 'Off' and otherdevices[sd] == 'Off' and otherdevices[se] == 'Closed' and difference >= timewait and sleep == 'Off') then
			commandArray[switchsleep]='On'
		end
	end
	if (presence == 'On' and sleep == 'On' and wakeup == 'On' and timenumber == wakeuptime and otherdevices['SwitchBedroom'] == 'Off' and (weekday > 0 and weekday < 6)) then
		commandArray['Variable:WakeUpLightOn'] = tostring(1)
		scriptfolder = "/home/pi/domoticz/scripts/bash/"
		scene = scene..'0/WakeUp.sh'
		print ('Wake-Up light triggered: '..scriptfolder..sc..'/'..scene)
		os.execute (scriptfolder..sc..'/'..scene)
	end
	if (uservariables['WakeUpLightOn'] == 1 and (timenumber == wakeuptime + 30)) then
		commandArray['Variable:WakeUpLightOn'] = tostring(0)
		--scriptfolder = "/home/pi/domoticz/scripts/bash/"
		--scene = scene..'0/1.sh'
		--print ('Wake-Up light triggered daytime-light: '..scriptfolder..sc..'/'..scene)
		--os.execute (scriptfolder..sc..'/'..scene)
		commandArray['SwitchBedroom'] = 'On'
	end
end

return commandArray
