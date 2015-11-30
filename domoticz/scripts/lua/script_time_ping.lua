commandArray={}

debug=false

prefixe="(PING) "

local ping={}
local ping_success
local bt_success

ping[1]={'192.168.1.1', 'Device 1', 'Teller 1', 'nil', 5}                 -- android
ping[2]={'192.168.1.2', 'Device 2', 'Teller 2', 'aa:bb:cc:dd:ee:ff', 5}   -- iphone
ping[3]={'192.168.1.3', 'Device 3', 'Teller 3', 'nil', 5}                 -- android

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
if (debug==true) then
print(prefixe.."ping success "..ping[ip][2])
end
if (otherdevices[ping[ip][2]]=='Off') then
commandArray[ping[ip][2]]='On'
end
if (uservariables[ping[ip][3]]) ~= 1 then
commandArray['Variable:'..ping[ip][3]]= tostring(1)
end
else
if (debug==true) then
print(prefixe.."ping fail "..ping[ip][2])
end
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
