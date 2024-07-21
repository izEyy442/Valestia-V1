---
--- @author Kadir#6666
--- Create at [19/04/2023] 12:54:18
--- Current project [Valestia-V1]
--- File name [shopsManager]
---

ShopsManager = ShopsManager or {};

function ShopsManager.GetFromId(shpId)
    return Config["Shops"].list[shpId]
end


ClientCanAccessFood = 1

RegisterNetEvent("Ouvre:BurgerShot", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "burgershot" then
        ClientCanAccessFood = 0
    end
end)

RegisterNetEvent("Ferme:BurgerShot", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "burgershot" then
        ClientCanAccessFood = 1
    end
end)

CreateThread(function()

    while true do
        Wait(20000)
        local xPlayers = ESX.GetPlayers()
        local NumberOfEmployeeBurgerShot = 0
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(i)
            if xPlayer and xPlayer.job.name == "burgershot" then
                NumberOfEmployeeBurgerShot = NumberOfEmployeeBurgerShot +1
            end
        end
        if NumberOfEmployeeBurgerShot == 0 then
            ClientCanAccessFood = 1
        end
    end

end)
