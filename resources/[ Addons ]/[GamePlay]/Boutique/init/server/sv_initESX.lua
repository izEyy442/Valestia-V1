ESX = nil
ESXLoaded = false
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
    ESXLoaded = true
end)