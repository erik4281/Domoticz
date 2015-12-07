commandArray = {}

if (otherdevices['iPhoneErik'] == 'On' or otherdevices['iPhoneJinHee'] == 'On') then
	if (otherdevices['Phones' == 'Off') then
		commandArray['Phones'] = 'On'
	end
	if (otherdevices['People' == 'Off') then
		commandArray['People'] = 'On'
	end
end
if (otherdevices['iPhoneErik'] == 'Off' and otherdevices['iPhoneJinHee'] == 'Off') then
	if (otherdevices['Phones' == 'On') then
		commandArray['Phones'] = 'Off'
	end
	if (otherdevices['People' == 'On') then
		commandArray['People'] = 'Off'
	end
end

return commandArray
