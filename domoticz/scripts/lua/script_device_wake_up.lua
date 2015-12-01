commandArray = {}

dc = next(devicechanged)
ts = tostring(dc)
sleep = otherdevices['SleepMode']
switchsleep = 'SleepMode'
presence = otherdevices['People']

if (ts:sub(1,6) == 'Motion' and presence == 'On' and sleep == 'On') then
	timenumber = tonumber(os.date("%H")..os.date("%M"))
	wakestart = 0600
	wakestop = 1200
	if (timenumber >= wakestart and timenumber < wakestop) then
		sc = ts:sub(7)
		if (sc == 'Living' or sc == 'Dining' or sc == 'Kitchen') then
			print ("Waking up")
			commandArray[switchsleep] = 'Off'
		end
	end
end

return commandArray
