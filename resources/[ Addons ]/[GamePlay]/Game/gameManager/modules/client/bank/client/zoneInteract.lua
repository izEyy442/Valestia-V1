---
--- @author Azagal
--- Create at [23/10/2022] 20:51:36
--- Current project [Valestia-V1]
--- File name [zoneInteract]
---

local atmObjects = {
    "prop_fleeca_atm",
    "prop_atm_01",
    "prop_atm_03",
    "prop_atm_02"
}

local bankPositions = {
    vector3(149.92, -1040.83, 29.37),
    vector3(-1212.980, -330.841, 37.56),
    vector3(-2962.582, 482.627, 15.703),
    vector3(-112.202, 6469.295, 31.626),
    vector3(314.187, -278.621, 54.170),
    vector3(-351.534, -49.529, 49.042),
    vector3(1175.0643310547, 2706.6435546875, 38.094036102295)
}

CreateThread(function()
    for i = 1, #bankPositions do
        local bankPosition = bankPositions[i]
        if (bankPosition ~= nil) then
            local blip = AddBlipForCoord(bankPosition)
            SetBlipSprite(blip, 108)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 25)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("[Public] Fleeca Bank")
            EndTextCommandSetBlipName(blip)
        end
    end

    while true do
        local interval = 500
        local playerCoords = GetEntityCoords(PlayerPedId())

        for i = 1, #bankPositions do
            local bankPosition = bankPositions[i]
            if (bankPosition ~= nil) then
                if (#(bankPosition-playerCoords) < 1.5) then
                    interval = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder a votre compte bancaire")
                    DrawMarker(29, bankPosition.x, bankPosition.y, bankPosition.z-0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 45,110,185, 123, 255, 0, 2, 1, nil, nil, 0)
                    if IsControlJustReleased(0, 38) then
                        Bank:openMenu("bank")
                    end
                end
            end
        end

        for i = 1, #atmObjects do
            local atmObject = atmObjects[i]
            if (atmObject ~= nil) then
                local closestObject = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 1.0, GetHashKey(atmObject), true, true, true)
                if (closestObject ~= 0) then
                    interval = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour insérer votre carte")
                    if IsControlJustReleased(0, 38) then
                        Bank:openMenu("atm")
                    end
                end
            end
        end

        Wait(interval)
    end
end)