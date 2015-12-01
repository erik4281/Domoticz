commandArray = {}

dc = next(devicechanged)
ts = tostring(t)
presence = otherdevices['People']
switchpresence = 'People'

if ((ts:sub(1,6) == 'Motion' or ts:sub(1,6) == 'Tamper') and presence == 'Off' and (devicechanged[dc] == 'On' or devicechanged[dc] == 'Open')) then
	sc = ts:sub(7)
	if (sc == 'FrontDoor') then
		commandArray['SwitchHallway'] = 'On'
	end
	prefix="(PING) "
	local ping={}
	local ping_success
	local bt_success
	timeon = uservariables['DepartTimer']
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
			if (otherdevices['ALARM'] == 'On') then
				commandArray['ALARM'] = 'Off'
			end
			if (presence == 'Off') then
				commandArray[switchpresence] = 'On'
			end
			if (otherdevices[ping[ip][2]]=='Off') then
				commandArray[ping[ip][2]]='On'
			end
			if (uservariables[ping[ip][3]]) ~= 1 then
				commandArray['Variable:'..ping[ip][3]]= tostring(1)
			end
		else
			print(prefix.."ping fail "..ping[ip][2])
			if (otherdevices['ALARM'] == 'Off') then
				commandArray['ALARM'] = 'On'
			end
		end
	end
end

return commandArray
