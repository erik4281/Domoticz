commandArray = {}

t = next(devicechanged)
s = tostring(t)
sleepswitch = otherdevices['SleepMode']
sleepswitchname = 'SleepMode'

if (s:sub(1,6) == 'Motion' and otherdevices['People'] == 'On' and sleepswitch == 'On') then
	timenumber = tonumber(os.date("%H")..os.date("%M"))
	wakestart = 0600
	wakestop = 1200
	if (timenumber >= wakestart and timenumber < wakestop) then
		c = s:sub(7)
		if (c == 'Living' or c == 'Dining' or c == 'Kitchen') then
			print ("Waking up")
			commandArray[sleepswitchname] = 'Off'
		end
	end
end

return commandArray
