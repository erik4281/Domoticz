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
	ts = tostring(i)
	v = i:sub(1,6)
	if (v == 'Switch') then
		sc = i:sub(7)
		scriptfolder = "/home/pi/domoticz/scripts/bash/"
		if (otherdevices[ts] == 'On') then
			difference = timedifference(otherdevices_lastupdate[ts])
			timenumber = tonumber(os.date("%H")..os.date("%M"))
			timehour = tonumber(os.date("%H"))
			timeminute = tonumber(os.date("%M"))
			loopminute = tonumber(uservariables['LoopMinute'])
			weekday = tonumber(os.date("%w"))
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
				elseif (timeminute == loopminute + 1) then
					difference = 30
					looping = 1
				end
			end
			if (difference >= 1 and difference < 61) then
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
				scene = scene..'.sh'
				print ('Backup triggered: '..scriptfolder..sc..'/'..scene)
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
			if (looping == 0 and execute == 1) then
				print ('Time triggered: '..scriptfolder..sc..'/'..scene)
				os.execute (scriptfolder..sc..'/'..scene)
				execute = 0
			end
		elseif (otherdevices[ts] == 'Off') then
			difference = timedifference(otherdevices_lastupdate[ts])
			if (difference >= 1 and difference < 61) then
				scene = 'Off'
				scene = scene..'.sh'
				print ('Backup triggered: '..scriptfolder..sc..'/'..scene)
				os.execute (scriptfolder..sc..'/'..scene)
			end
		end
	end
end

return commandArray
