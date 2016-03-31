commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)

if (ts:sub(1,6) == 'Switch') then
	sc = ts:sub(7)
	scriptfolder = "/home/pi/domoticz/scripts/bash/"
	if (devicechanged[dc] == 'On') then
		timenumber = tonumber(os.date("%H")..os.date("%M"))
		timehour = tonumber(os.date("%H"))
		weekday = tonumber(os.date("%w"))
		wk = ''
		if ((weekday == 0 and timehour < 18) or weekday == 6 or (weekday == 5 and timehour > 18)) then
			wk = 'Weekend'
		end
		time1 = tonumber(uservariables['Timer'..sc..'1'..wk])
		time2 = tonumber(uservariables['Timer'..sc..'2'..wk])
		time3 = tonumber(uservariables['Timer'..sc..'3'..wk])
		time4 = tonumber(uservariables['Timer'..sc..'4'..wk])
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
	else
		scene = 'Off'
	end
	scene = scene..'.sh'
	print ('Switch triggered: '..scriptfolder..sc..'/'..scene)
	os.execute (scriptfolder..sc..'/'..scene)
end

return commandArray
