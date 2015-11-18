commandArray = {}

t0 = os.time()
t = next(devicechanged)
s = tostring(t)

if (s:sub(1,6) == 'Switch') then

	c = s:sub(7)
	t = 'Switch'..c
	scriptfolder = "/home/pi/domoticz/scripts/bash/"

	if (otherdevices[t] == 'On') then

		timenumber = tonumber(os.date("%H")..os.date("%M"))
		time1 = tonumber(uservariables['Timer'..c..'1'])
		time2 = tonumber(uservariables['Timer'..c..'2'])
		time3 = tonumber(uservariables['Timer'..c..'3'])
		time4 = tonumber(uservariables['Timer'..c..'4'])

		if (time1) then
			scene = 0
		else
			scene = '1'
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
	print ('Switch triggered: '..scriptfolder..c..'/'..scene)
	os.execute (scriptfolder..c..'/'..scene)

end

return commandArray