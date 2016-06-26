commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)
sleep = otherdevices['ModeSleep']
switchawake = 'ModeStandard'
presence = otherdevices['People']

if (ts:sub(1,6) == 'Motion' and presence == 'On' and sleep == 'On') then
	timenumber = tonumber(os.date("%H")..os.date("%M"))
	wakestart = 0700
	wakestop = 1200
	if (timenumber >= wakestart and timenumber < wakestop) then
		sc = ts:sub(7)
		if (sc == 'Living' or sc == 'Dining' or sc == 'Kitchen') then
			print ("Waking up")
			commandArray[switchawake] = 'On'
		end
	end
end

return commandArray
