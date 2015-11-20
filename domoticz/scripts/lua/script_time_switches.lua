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

for i, v in pairs(otherdevices) do
	tc = tostring(i)
	v = i:sub(1,6)
	if (v == 'Switch') then
		c = i:sub(7)
		t = 'Switch'..c
		scriptfolder = "/home/pi/domoticz/scripts/bash/"
		if (otherdevices[t] == 'On') then
			difference = timedifference(otherdevices_lastupdate[t])
			timenumber = tonumber(os.date("%H")..os.date("%M"))
			time0 = tonumber(uservariables['Timer'..c..'0'])
			time1 = tonumber(uservariables['Timer'..c..'1'])
			time2 = tonumber(uservariables['Timer'..c..'2'])
			time3 = tonumber(uservariables['Timer'..c..'3'])
			time4 = tonumber(uservariables['Timer'..c..'4'])
			execute = 0
			if (difference >= 1 and difference < 61) then
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
			end
			scene = scene..'.sh'
			print ('Backup triggered: '..scriptfolder..c..'/'..scene)
			os.execute (scriptfolder..c..'/'..scene)
			if (time1) then
				scene = 0
			else
				scene = 1
			end
			if (time0) then
				if (timenumber == time0) then
					scene = 0
					execute = 1
				end
			end
			if (time1) then
				if (timenumber == time1) then
					scene = 1
					execute = 1
				end
			end
			if (time2) then
				if (timenumber == time2) then
					scene = 2
					execute = 1
				end
			end
			if (time3) then
				if (timenumber == time3) then
					scene = 3
					execute = 1
				end
			end
			if (time4) then
				if (timenumber == time4) then
					scene = 4
					execute = 1
				end
			end
			if (execute == 1) then
				scene = scene..'Slow.sh'
				print ('Time triggered: '..scriptfolder..c..'/'..scene)
				os.execute (scriptfolder..c..'/'..scene)
				execute = 0
			end
		elseif (otherdevices[t] == 'Off') then
			difference = timedifference(otherdevices_lastupdate[t])
			if (difference >= 1 and difference < 61) then
				scene = 'Off'
			end
			scene = scene..'.sh'
			print ('Backup triggered: '..scriptfolder..c..'/'..scene)
			os.execute (scriptfolder..c..'/'..scene)
		end
	end
end

return commandArray
