CreateThread(function()
    if Config.Framework ~= "esx" then
        return
    end

    debugprint("Loading ESX")
    local export, ESX = pcall(function()
        return exports.es_extended:getSharedObject()
    end)
    if not export then
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
    debugprint("ESX loaded")

    --- @param source number
    --- @return string | nil
    function GetIdentifier(source)
        return ESX.GetPlayerFromId(source)?.identifier
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

        local xPlayer = ESX.GetPlayerFromId(source)
        local hasItem = xPlayer.getInventoryItem(Config.Item.Name)

        print('CHECK HAS ITEM', hasItem)

        if not hasItem then
            return false
        end

        return MySQL.Sync.fetchScalar("SELECT 1 FROM phone_phones WHERE id=@id AND phone_number=@number", {
            ["@id"] = GetIdentifier(source),
            ["@number"] = number
        }) ~= nil
    end

    ---Get a player's character name
    ---@param source any
    ---@return string # Firstname
    ---@return string # Lastname
    function GetCharacterName(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local firstName, lastName
        if xPlayer.get and xPlayer.get("firstName") and xPlayer.get("lastName") then
            firstName = xPlayer.get("firstName")
            lastName = xPlayer.get("lastName")
        else
            local name = MySQL.Sync.fetchAll("SELECT `firstname`, `lastname` FROM `users` WHERE `identifier`=@identifier", {["@identifier"] = GetIdentifier(source)})
            firstName, lastName = name[1]?.firstname or GetPlayerName(source), name[1]?.lastname or ""
        end

        return firstName, lastName
    end

    ---Get an array of player sources with a specific job
    ---@param job string
    ---@return table # Player sources
    function GetEmployees(job)
        local employees = {}
        if ESX.GetExtendedPlayers then
            local xPlayers = ESX.GetExtendedPlayers("job", job)
            for _, xPlayer in pairs(xPlayers) do
                employees[#employees+1] = xPlayer.source
            end
        else
            local xPlayers = ESX.GetPlayers()
            for _, source in pairs(xPlayers) do
                if ESX.GetPlayerFromId(source).job.name == job then
                    employees[#employees+1] = source
                end
            end
        end
        return employees
    end

    ---Get the bank balance of a player
    ---@param source any
    ---@return integer
    function GetBalance(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then
            return 0
        end
        return xPlayer.getAccount("bank")?.money or 0
    end

    ---Add money to a player's bank account
    ---@param source any
    ---@param amount integer
    ---@return boolean # Success
    function AddMoney(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer or amount < 0 then
            return false
        end

        xPlayer.addAccountMoney("bank", amount)
        return true
    end

    ---Remove money from a player's bank account
    ---@param source any
    ---@param amount integer
    ---@return boolean # Success
    function RemoveMoney(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer or amount < 0 or GetBalance(source) < amount then
            return false
        end

        xPlayer.removeAccountMoney("bank", amount)
        return true
    end

    ---Send a message to a player
    ---@param source number
    ---@param message string
    function Notify(source, message)
        TriggerClientEvent("esx:showNotification", source, message)
    end

    -- GARAGE APP
    function GetPlayerVehicles(source, cb)
        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@owner", {
            ["@owner"] = GetIdentifier(source)
        }, function(vehicles)
            local toSend = {}

            for _, v in pairs(vehicles) do
                if v.stored == nil
                    or GetResourceState("qs-garages") == "started"
                then
                    v.stored = v.state
                end

                if type(v.stored) ~= "boolean" then
                    v.stored = v.stored == 1
                end

                if GetResourceState("cd_garage") == "started" then
                    debugprint("Using cd_garage")
                    v.stored = v.in_garage or v.in_garage == 1
                    v.garage = v.garage_id
                elseif GetResourceState("loaf_garage") == "started" then
                    v.stored = 1
                end

                local newCar = {
                    plate = v.plate,
                    type = v.type,
                    location = v.stored and (v.garage or "Garage") or "out",
                    statistics = {}
                }

                if v.damages then
                    local damages = json.decode(v.damages)
                    if damages?.engineHealth then
                        newCar.statistics.engine = math.floor(damages.engineHealth / 10 + 0.5)
                    end

                    if damages?.bodyHealth then
                        newCar.statistics.body = math.floor(damages.bodyHealth / 10 + 0.5)
                    end
                end

                local vehicle = json.decode(v.vehicle)
                if vehicle.fuel then
                    newCar.statistics.fuel = math.floor(vehicle.fuel + 0.5)
                end

                newCar.model = vehicle.model

                toSend[#toSend+1] = newCar
            end

            cb(toSend)
        end)
    end

    function GetVehicle(source, cb, plate)
        local storedColumn, storedValue = "stored", 1
        if GetResourceState("cd_garage") == "started" then
            storedColumn = "in_garage"
        elseif GetResourceState("qs-inventory") == "started" then
            storedColumn = "state"
        end

        MySQL.Async.fetchAll(([[
            SELECT * FROM owned_vehicles
            WHERE owner=@owner AND plate=@plate AND `type`="car" AND `%s`=@stored
        ]]):format(storedColumn), {
            ["@owner"] = GetIdentifier(source),
            ["@plate"] = plate,
            ["@stored"] = storedValue
        }, function(res)
            if not res[1] then
                return cb(false)
            end

            MySQL.Async.execute(("UPDATE owned_vehicles SET `%s`=0 WHERE plate=@plate"):format(storedColumn), {
                ["@plate"] = plate
            })

            cb(res[1])
        end)
    end

    function IsAdmin(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local isAdmin = xPlayer.getGroup() == "superadmin"

        if not isAdmin then
            return IsPlayerAceAllowed(source, "command.lbphone_admin") == 1
        end

        return isAdmin
    end

    if RegisterCommand then
        RegisterCommand("toggleverified", "admin", function(xPlayer, args, showError)
            local app, username, verified = args.app:lower(), args.username, args.verified

            local allowedApps = {
                ["twitter"] = true,
                ["instagram"] = true,
                ["tiktok"] = true,
                ["birdy"] = true,
                ["trendy"] = true,
                ["instapic"] = true
            }

            if not allowedApps[app] then
                return showError("No such app " .. tostring(app))
            end

            if not username then
                return showError("No username provided")
            end

            if verified ~= 1 and verified ~= 0 then
                return showError("Verified must be 1 or 0")
            end

            ToggleVerified(app, username, verified == 1)
        end, false, {
            help = "Toggle verified for a user profile",
            arguments = {
                {
                    name = "app",
                    help = "The app: trendy, instapic or birdy",
                    type = "any"
                },
                {
                    name = "username",
                    help = "The profile username",
                    type = "any"
                },
                {
                    name = "verified",
                    help = "The verified state, 1 or 0",
                    type = "number"
                }
            }
        })

        RegisterCommand("changepassword", "admin", function(xPlayer, args, showError)
            local app, username, password = args.app:lower(), args.username, args.password

            local allowedApps = {
                ["twitter"] = true,
                ["instagram"] = true,
                ["tiktok"] = true,
                ["birdy"] = true,
                ["trendy"] = true,
                ["instapic"] = true
            }

            if not allowedApps[app] then
                return showError("No such app " .. tostring(app))
            end

            if not username then
                return showError("No username provided")
            end

            if not password then
                return showError("No password provided")
            end

            ChangePassword(app, username, password)
        end, false, {
            help = "Change a user's password",
            arguments = {
                {
                    name = "app",
                    help = "The app: trendy, instapic or birdy",
                    type = "any"
                },
                {
                    name = "username",
                    help = "The profile username",
                    type = "any"
                },
                {
                    name = "password",
                    help = "The new password",
                    type = "any"
                }
            }
        })
    else
        print("^6[LB Phone] ^3[WARNING]^0: RegisterCommand not found, commands not registered. If you wish to use commands, update your ESX. The phone will still work.")
    end

    -- COMPANIES APP
    function GetJob(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.job?.name
    end

    function RefreshCompanies()
        local openJobs = {}
        if ESX.GetExtendedPlayers then
            local xPlayers = ESX.GetExtendedPlayers()
            for _, xPlayer in pairs(xPlayers) do
                local job = xPlayer.job.name
                openJobs[job] = true
            end
        else
            local xPlayers = ESX.GetPlayers()
            for _, source in pairs(xPlayers) do
                local job = ESX.GetPlayerFromId(source).job.name
                openJobs[job] = true
            end
        end

        for i = 1, #Config.Companies.Services do
            local jobData = Config.Companies.Services[i]
            Config.Companies.Services[i].open = openJobs[jobData.job] or false
        end
    end
end)