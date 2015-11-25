commandArray = {}

t = next(devicechanged)
s = tostring(t)
c = s:sub(7)
presenceswitch = otherdevices['People']
presenceswitchname = 'People'

if (s:sub(1,6) == 'Motion' and c == 'FrontDoor' and (devicechanged[t] == 'On' or devicechanged[t] == 'Open')) then
	print ("Door opening, checking presence of phones")
	os.execute ('/home/pi/domoticz/scripts/bash/Hallway/1.sh')
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
			if (presenceswitch == 'Off') then
				commandArray[presenceswitchname] = 'On'
			end
			if (otherdevices[ping[ip][2]]=='Off') then
				commandArray[ping[ip][2]]='On'
			end
			if (uservariables[ping[ip][3]]) ~= 1 then
				commandArray['Variable:'..ping[ip][3]]= tostring(1)
			end
		else
			print(prefix.."ping fail "..ping[ip][2])
			if (presenceswitch == 'Off' and otherdevices['ALARM'] == 'Off') then
				commandArray['ALARM'] = 'On'
			end
		end
	end
end

return commandArray
