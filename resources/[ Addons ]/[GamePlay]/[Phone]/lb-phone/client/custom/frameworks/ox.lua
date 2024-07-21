local playerLoaded
AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        playerLoaded = true
    end
end)

CreateThread(function()
    if Config.Framework ~= "ox" then
        return
    end

    RegisterNetEvent("ox:playerLoaded", function()
        playerLoaded = true
    end)

    debugprint("Loading OX")
    while GetResourceState("ox_core") ~= "started" do
        debugprint("Waiting for ox_core to start")
        Wait(500)
    end

    local file = "imports/client.lua"
    local import = LoadResourceFile("ox_core", file)
    local func, err = load(import, ("@@ox_core/%s"):format(file))
    if not func then
        return Citizen.Trace(("^1Error loading %s: %s^7"):format(file, err))
    end
    func()
    debugprint("OX loaded")

    while not playerLoaded do
        Wait(500)
    end
    loaded = true

    ---Check if the player has a phone
    ---@param number string | nil phone number
    ---@return boolean
    function HasPhoneItem(number)
        if not Config.Item.Require then
            return true
        end

        if Config.Item.Unique then
            return HasPhoneNumber(number)
        end

        if GetResourceState("ox_inventory") == "started" then
            return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
        end

        return true
    end

    function HasJob(jobs)
        return false
    end

    -- Garage
    function CreateFrameworkVehicle(vehicleData, coords)
        return false
    end
end)