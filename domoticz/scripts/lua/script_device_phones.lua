commandArray = {}

if (otherdevices['iPhoneErik'] == 'On' or otherdevices['iPhoneJinHee'] == 'On') then
	commandArray['Phones'] = 'On'
end
if (otherdevices['iPhoneErik'] == 'Off' and otherdevices['iPhoneJinHee'] == 'Off') then
	commandArray['Phones'] = 'Off'
end

return commandArray
