commandArray = {}

motion = devicechanged['MotionFrontDoor']
presenceswitch = otherdevices['People']
presencewitchname = 'People'

if (motion == 'On' and presenceswitch == 'Off') then
	print ("Arriving")
	commandArray[presencewitchname] = 'On'
end

return commandArray
