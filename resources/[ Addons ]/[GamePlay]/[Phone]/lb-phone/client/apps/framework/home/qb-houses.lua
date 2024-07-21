CreateThread(function()
    if Config.HouseScript ~= "qb-houses" then
        return
    end

    while not loaded do
        Wait(500)
    end

    local QB = exports["qb-core"]:GetCoreObject()

    local allHouses = {}

    RegisterNetEvent("qb-houses:client:setHouseConfig", function(houseConfig)
        allHouses = houseConfig
    end)

    RegisterNetEvent("qb-houses:client:lockHouse", function(bool, house)
        if not allHouses[house] then
            return
        end

        allHouses[house].locked = bool
    end)

    TriggerServerEvent("qb-houses:server:setHouses")

    local function formatKeyHolders(keyholders)
        local formatted = {}
        for i = 1, #keyholders do
            formatted[i] = {
                identifier = keyholders[i].citizenid,
                name = keyholders[i].charinfo and (keyholders[i].charinfo.firstname .. " " .. keyholders[i].charinfo.lastname) or keyholders[i].name
            }
        end

        return formatted
    end

    local function formatHouses(houses)
        local formatted = {}
        for i = 1, #houses do
            local houseData = houses[i]

            formatted[i] = {
                label = houseData.label,
                id = i,
                uniqueId = houseData.name,
                locked = allHouses[houseData.name]?.locked or false,
                keyholders = formatKeyHolders(houseData.keyholders)
            }
        end

        return formatted
    end

    RegisterNUICallback("Home", function(data, cb)
        local action = data.action

        if action == "getHomes" then
            QB.Functions.TriggerCallback('qb-phone:server:GetPlayerHouses', function(houses)
                if not houses then
                    return cb({})
                end

                cb(formatHouses(houses))
            end)
        elseif action == "removeKeyholder" then
            local houseData = data.houseData
            TriggerServerEvent("qb-houses:server:removeHouseKey", houseData.uniqueId, { citizenid = data.identifier, firstname = "", lastname = "" })
            Wait(500)
            QB.Functions.TriggerCallback('qb-phone:server:GetPlayerHouses', function(houses)
                if not houses then
                    return cb({})
                end

                cb(formatKeyHolders(houses[data.id].keyholders))
            end)
        elseif action == "addKeyholder" then
            local houseData = data.houseData
            TriggerServerEvent("qb-houses:server:giveHouseKey", tonumber(data.source), houseData.uniqueId)
            Wait(500)
            QB.Functions.TriggerCallback('qb-phone:server:GetPlayerHouses', function(houses)
                if not houses then
                    return cb({})
                end

                cb(formatKeyHolders(houses[data.id].keyholders))
            end)
        elseif action == "toggleLocked" then
            local houseData = data.houseData
            local house = allHouses[houseData.uniqueId]
            if not house then
                house = { locked = false }
            end

            TriggerServerEvent("qb-houses:server:lockHouse", not house.locked, data.uniqueId)
            cb(not house.locked)
        elseif action == "setWaypoint" then
            local houseData = data.houseData
            local house = allHouses[houseData.uniqueId]
            if not house then
                return cb(false)
            end

            SetNewWaypoint(house.coords.enter.x, house.coords.enter.y)
            cb(true)
        end
    end)
end)