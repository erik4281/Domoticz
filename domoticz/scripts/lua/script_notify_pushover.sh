function notifyMe(iPriority, sTitle, sBody, sSound, sDevice)
   -- iPriority = -2,-1,0,1,2
   -- sDevice = name of device, empty is all
   -- Check for optional sound and device parameter
   if sSound == nil then sSound = '' end
   if sDevice == nil then sDevice = '' end
   local sUserKey = '[KEY]'
   local sToken = '[TOKEN]'
   local sMsg = 'curl --data "token=' .. sToken .. '&user=' .. sUserKey .. '&title=' .. sTitle .. '&message=' .. sBody .. '&priority=' .. tostring(iPriority) .. '&sound=' .. sSound .. '&device=' .. sDevice .. '" https://api.pushover.net/1/messages.json'
   os.execute(sMsg)
end
