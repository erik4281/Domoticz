commandArray={}

debug=true

prefix="(PING) "
--timeon = uservariables['DepartTimer']
timeon = 2

local ping={}
local ping_success
local bt_success

ping[1]={'10.0.1.123', 'iPadErik', 'iPadErik', timeon}
ping[2]={'10.0.1.124', 'iPadJinHee', 'iPadJinHee', timeon}
ping[3]={'10.0.1.125', 'MacBookAirErik', 'MacBookAirErik', timeon}
ping[4]={'10.0.1.126', 'MacBookAirJinHee', 'MacBookAirJinHee', timeon}
ping[5]={'10.0.1.114', 'AppleTvLiving', 'AppleTvLiving', timeon}
ping[6]={'10.0.1.115', 'AppleTvBedroom', 'AppleTvBedroom', timeon}
ping[7]={'10.0.1.109', 'TvLiving', 'TvLiving', timeon}
ping[8]={'10.0.1.101', 'PS4', 'PS4', timeon}
ping[9]={'10.0.1.110', 'Printer', 'Printer', timeon}

for ip = 1, #ping do
	ping_success=os.execute('ping -c 1 -w 1 '..ping[ip][1])
	if ping_success then
		if (debug==true) then
			print(prefix.."ping success "..ping[ip][2])
		end
		if (otherdevices[ping[ip][2]]=='Off') then
			print(ping[ip][2]..otherdevices[ping[ip][2]])
			commandArray[ping[ip][2]]='On'
		end
		if (uservariables[ping[ip][3]]) ~= 1 then
			commandArray['Variable:'..ping[ip][3]]= tostring(1)
		end
	else
		if (debug==true) then
			print(prefix.."ping fail "..ping[ip][2])
		end
		if (otherdevices[ping[ip][2]]=='On') then
			if (uservariables[ping[ip][3]])==ping[ip][4] then
				commandArray[ping[ip][2]]='Off'
			else
				commandArray['Variable:'..ping[ip][3]]= tostring((uservariables[ping[ip][3]]) + 1)
			end
		end
	end
end

return commandArray
