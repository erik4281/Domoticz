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
			timenumber = tonumber(os.date("%H")..os.date("%M"))
			time0 = tonumber(uservariables['Timer'..c..'0'])
			time1 = tonumber(uservariables['Timer'..c..'1'])
			time2 = tonumber(uservariables['Timer'..c..'2'])
			time3 = tonumber(uservariables['Timer'..c..'3'])
			time4 = tonumber(uservariables['Timer'..c..'4'])
			execute = 0

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

		end

	end

end

return commandArray