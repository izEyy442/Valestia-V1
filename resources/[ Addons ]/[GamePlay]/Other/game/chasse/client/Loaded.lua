ESX = nil

getESX = function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(ESX) ESX = ESX end)
        Wait(500)
   end
end

Citizen.CreateThread(function()
    getESX()
end)