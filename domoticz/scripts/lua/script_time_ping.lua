commandArray={}

presence = otherdevices['People']

if (presence == 'On') then
	
	prefix="(TIMED PING) "
	timeon = uservariables['DeviceTimer']

	local ping={}
	local ping_success
	local bt_success
	
	ping[1]={'10.0.1.125', 'MacBookAirErik', 'MacBookAirErik', 'MacBookAirErikOff', timeon}
	ping[2]={'10.0.1.126', 'MacBookAirJinHee', 'MacBookAirJinHee', 'MacBookAirJinHeeOff', timeon}
	ping[3]={'10.0.1.109', 'TvLiving', 'TvLiving', 'TvLivingOff', timeon}
	--ping[4]={'10.0.1.114', 'AppleTvLiving', 'AppleTvLiving', 'AppleTvLivingOff', timeon}
	--ping[5]={'10.0.1.115', 'AppleTvBedroom', 'AppleTvBedroom', 'AppleTvBedroomOff', timeon}
	--ping[6]={'10.0.1.123', 'iPadErik', 'iPadErik', timeon}
	--ping[7]={'10.0.1.124', 'iPadJinHee', 'iPadJinHee', timeon}
	--ping[8]={'10.0.1.101', 'PS4', 'PS4', timeon}
	--ping[9]={'10.0.1.110', 'Printer', 'Printer', timeon}
	
	for ip = 1, #ping do
		ping_success=os.execute('ping -c 1 -w 1 '..ping[ip][1])
		if ping_success then
			print(prefix.."ping success "..ping[ip][2])
			if (otherdevices[ping[ip][2]]=='Off') then
				commandArray[ping[ip][2]]='On'
				commandArray['Variable:'..ping[ip][3]]= tostring(1)
			else
				commandArray['Variable:'..ping[ip][3]]= tostring((uservariables[ping[ip][3]]) + 1)
			end
			if (uservariables[ping[ip][4]]) ~= 1 then
				commandArray['Variable:'..ping[ip][4]]= tostring(1)
			end
		else
			print(prefix.."ping fail "..ping[ip][2])
			if (otherdevices[ping[ip][2]]=='On') then
				if (uservariables[ping[ip][4]])==ping[ip][5] then
					commandArray[ping[ip][2]]='Off'
				else
					commandArray['Variable:'..ping[ip][4]]= tostring((uservariables[ping[ip][4]]) + 1)
				end
			end
		end
	end
else

	ping[1]={'10.0.1.125', 'MacBookAirErik', 'MacBookAirErik', 'MacBookAirErikOff', timeon}
	ping[2]={'10.0.1.126', 'MacBookAirJinHee', 'MacBookAirJinHee', 'MacBookAirJinHeeOff', timeon}
	ping[3]={'10.0.1.109', 'TvLiving', 'TvLiving', 'TvLivingOff', timeon}
	--ping[4]={'10.0.1.114', 'AppleTvLiving', 'AppleTvLiving', 'AppleTvLivingOff', timeon}
	--ping[5]={'10.0.1.115', 'AppleTvBedroom', 'AppleTvBedroom', 'AppleTvBedroomOff', timeon}
	--ping[6]={'10.0.1.123', 'iPadErik', 'iPadErik', timeon}
	--ping[7]={'10.0.1.124', 'iPadJinHee', 'iPadJinHee', timeon}
	--ping[8]={'10.0.1.101', 'PS4', 'PS4', timeon}
	--ping[9]={'10.0.1.110', 'Printer', 'Printer', timeon}
	
	for ip = 1, #ping do
		print(prefix.."ping skipped "..ping[ip][2])
		commandArray['Variable:'..ping[ip][3]]= tostring(1)
		commandArray['Variable:'..ping[ip][4]]= tostring(1)
		if (otherdevices[ping[ip][2]]=='On') then
			commandArray[ping[ip][2]]='Off'
		end
	end
end

return commandArray
