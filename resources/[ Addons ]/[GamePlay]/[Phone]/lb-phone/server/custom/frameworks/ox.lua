CreateThread(function()
    if Config.Framework ~= "ox" then
        return
    end

    debugprint("Loading OX")
    while GetResourceState("ox_core") ~= "started" do
        debugprint("Waiting for ox_core to start")
        Wait(500)
    end

    local file = "imports/server.lua"
    local import = LoadResourceFile("ox_core", file)
    local func, err = load(import, ("@@ox_core/%s"):format(file))
    if not func then
        return Citizen.Trace(("^1Error loading %s: %s^7"):format(file, err))
    end
    func()
    debugprint("OX loaded")

    ---@param source number
    ---@return string | nil
    function GetIdentifier(source)
        local player = Ox.GetPlayer(source)
        return tostring(player.charid)
    end

    ---Check if a player has a phone with a specific number
    ---@param source any
    ---@param number string
    ---@return boolean
    function HasPhoneItem(source, number)
        if not Config.Item.Require then
            return true
        end

        if Config.Item.Unique then
            return HasPhoneNumber(source, number)
        end

        if GetResourceState("ox_inventory") == "started" then
            return (exports.ox_inventory:Search(source, "count", Config.Item.Name) or 0) > 0
        end

        return true
    end

    ---Get a player's character name
    ---@param source any
    ---@return string # Firstname
    ---@return string # Lastname
    function GetCharacterName(source)
        local player = Ox.GetPlayer(source)
        return player.firstname, player.lastname
    end

    ---Get an array of player sources with a specific job
    ---@param job string
    ---@return table # Player sources
    function GetEmployees(job)
        local employees = {}
        local players = Ox.GetPlayers(false, {
            groups = {job}
        })
        for i = 1, #players do
            employees[#employees+1] = players[i].source
        end
        return players
    end

    ---Get the bank balance of a player
    ---@param source any
    ---@return number
    function GetBalance(source)
        if GetResourceState("pefcl") == "started" then
            return exports.pefcl:getDefaultAccountBalance(source)?.data or 0
        end

        return 0
    end

    ---Add money to a player's bank account
    ---@param source any
    ---@param amount integer
    ---@return boolean # Success
    function AddMoney(source, amount)
        if GetResourceState("pefcl") == "started" then
            return exports.pefcl:addBankBalance(source, { amount = amount, message = "LB Phone" })
        end

        return false
    end

    ---Remove money from a player's bank account
    ---@param source any
    ---@param amount integer
    ---@return boolean # Success
    function RemoveMoney(source, amount)
        if GetResourceState("pefcl") == "started" then
            return exports.pefcl:removeBankBalance(source, { amount = amount, message = "LB Phone" })
        end

        return false
    end

    -- GARAGE APP
    function GetPlayerVehicles(source, cb)
        cb({})
    end

    function GetVehicle(source, cb, plate)
        cb(false)
    end

    function IsAdmin(source)
        return IsPlayerAceAllowed(source, "command.lbphone_admin") == 1
    end
end)