commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts:sub(1,6) == 'Switch') then
	sc = ts:sub(7)
	scriptfolder = "/home/pi/domoticz/scripts/bash/"
	if (devicechanged[dc] == 'On') then
		timenumber = tonumber(os.date("%H")..os.date("%M"))
		weekday = tonumber(os.date("%w"))
		print (weekday)
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
		if (otherdevices['SleepMode'] == 'On') then
			scene = 9
		end
	else
		scene = 'Off'
	end
	scene = scene..'.sh'
	print ('Switch triggered: '..scriptfolder..sc..'/'..scene)
	os.execute (scriptfolder..sc..'/'..scene)
end

return commandArray
