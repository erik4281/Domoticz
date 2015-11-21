commandArray={}

prefix="(PING) "

local ping={}
local ping_success
local bt_success

ping[1]={'10.0.1.121', 'iPhoneErik', 'iPhoneErik', 'DC:9B:9C:BE:D5:08', 10}
ping[2]={'10.0.1.122', 'iPhoneJinHee', 'iPhoneJinHee', 'F0:24:75:D0:AF:C2', 10}

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

return commandArray
