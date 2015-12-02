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

door = otherdevices['MotionFrontDoor']
presence = otherdevices['People']

for i, v in pairs(otherdevices) do
	ts = tostring(i)
	v = i:sub(1,6)
	if (otherdevices == 'MotionFrontDoor') then
		print ('CHECKING OK!!!!')
		timeon = uservariables['DepartTimer']
		difference = timedifference(otherdevices_lastupdate[ts])
		timewait = (timeon * 60) + 120
		if (presence == "On" and door == 'Closed' and difference < (timewait + 60)) then
			prefix="(PING) "
			local ping={}
			local ping_success
			local bt_success
			ping[1]={'10.0.1.121', 'iPhoneErik', 'iPhoneErik', 'DC:9B:9C:BE:D5:08', timeon}
			ping[2]={'10.0.1.122', 'iPhoneJinHee', 'iPhoneJinHee', 'F0:24:75:D0:AF:C2', timeon}
			for ip = 1, #ping do
				if ping[ip][4] == 'nil' then
					bt_success=false
					ping_success=os.execute('ping -c 1 -w 1 '..ping[ip][1])
				else
					f = assert (io.popen ("hcitool names "..ping[ip][4]))
					bt = f:read()
					if bt==nil then
						bt_success=false
					else
						bt_success=true
					end
					f:close()
				end
				if ping_success or bt_success then
					print(prefix.."ping success "..ping[ip][2])
					if (otherdevices[ping[ip][2]]=='Off') then
						commandArray[ping[ip][2]]='On'
					end
					if (uservariables[ping[ip][3]]) ~= 1 then
						commandArray['Variable:'..ping[ip][3]]= tostring(1)
					end
				else
					print(prefix.."ping fail "..ping[ip][2])
					if (otherdevices[ping[ip][2]]=='On') then
						if (uservariables[ping[ip][3]])==ping[ip][5] then
							commandArray[ping[ip][2]]='Off'
						else
							commandArray['Variable:'..ping[ip][3]]= tostring((uservariables[ping[ip][3]]) + 1)
						end
					end
				end
			end
			if ((otherdevices['iPhoneErik'] == 'On' or otherdevices['iPhoneJinHee'] == 'On') and otherdevices['People'] == 'Off') then
				commandArray['People'] = 'On'
			end
			if ((otherdevices['iPhoneErik'] == 'Off' and otherdevices['iPhoneJinHee'] == 'Off') and otherdevices['People'] == 'On') then
				commandArray['People'] = 'Off'
			end
		end
	end
end

return commandArray
