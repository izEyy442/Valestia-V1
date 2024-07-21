CreateThread(function()
    if Config.Framework ~= "esx" then
        return
    end

    debugprint("Loading ESX")
    local export, ESX = pcall(function()
        return exports.Framework:getSharedObject()
    end)
    if not export then
        while not ESX do
            TriggerEvent("esx:getSharedObject", function(obj)
                ESX = obj
            end)
            Wait(500)
        end
    end

    local isFirst = true
    RegisterNetEvent("esx:playerLoaded", function(playerData)
        ESX.PlayerData = playerData
        ESX.PlayerLoaded = true

        if not isFirst then
            FetchPhone()
        end

        isFirst = false
    end)

    RegisterNetEvent("esx:onPlayerLogout", LogOut)

    while not ESX.PlayerLoaded do
        Wait(500)
    end

    RegisterNetEvent("esx:setJob", function(job)
        ESX.PlayerData.job = job
    end)

    debugprint("ESX loaded")
    loaded = true

    ---Check if the player has a phone
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

        local inventory = ESX.GetPlayerData()?.inventory
        --local inventory = exports['SilkyHud']:getInventoryItems()

        if not inventory then
            print("^6[LB Phone] ^3[Warning]^0: Unsupported inventory, tell the inventory author to add support for it.")
            return false
        end

        for i = 1, #inventory do
            local item = inventory[i]
            if (item ~= "empty") then
                if item.name == Config.Item.Name and item.count > 0 then
                    return true
                end
            end
        end

        return false
    end

    ---Check if the player has a job
    ---@param jobs table
    ---@return boolean
    function HasJob(jobs)
        local job = ESX.PlayerData.job.name
        for i = 1, #jobs do
            if jobs[i] == job then
                return true
            end
        end
        return false
    end

    ---Create a vehicle
    ---@param vehicleData table
    ---@param coords table
    function CreateFrameworkVehicle(vehicleData, coords)
        vehicleData.vehicle = json.decode(vehicleData.vehicle)
        if vehicleData.damages then
            vehicleData.damages = json.decode(vehicleData.damages)
        end

        while not HasModelLoaded(vehicleData.vehicle.model) do
            RequestModel(vehicleData.vehicle.model)
            Wait(500)
        end

        local vehicle = CreateVehicle(vehicleData.vehicle.model, coords.x, coords.y, coords.z, 0.0, true, false)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleNumberPlateText(vehicle, vehicleData.vehicle.plate)

        ESX.Game.SetVehicleProperties(vehicle, vehicleData.vehicle)

        if vehicleData.damages then
            SetVehicleEngineHealth(vehicle, vehicleData.damages.engineHealth)
            SetVehicleBodyHealth(vehicle, vehicleData.damages.bodyHealth)
        end

        if vehicleData.vehicle.fuel then
            SetVehicleFuelLevel(vehicle, vehicleData.vehicle.fuel)
        end

        SetModelAsNoLongerNeeded(vehicleData.vehicle.model)

        return vehicle
    end

    -- Company app
    function GetCompanyData(cb)
        local jobData = {
            job = ESX.PlayerData.job.name,
            jobLabel = ESX.PlayerData.job.label,
            isBoss = ESX.PlayerData.job.grade_name == "boss"
        }

        if not jobData.isBoss then
            for cId = 1, #Config.Companies.Services do
                local company = Config.Companies.Services[cId]
                if company.job == jobData.job then
                    if not company.bossRanks then
                        break
                    end

                    for i = 1, #company.bossRanks do
                        if company.bossRanks[i] == ESX.PlayerData.job.grade_name then
                            jobData.isBoss = true
                            break
                        end
                    end

                    break
                end
            end
        end

        if jobData.isBoss then
            local moneyPromise = promise.new()
            ESX.TriggerServerCallback("esx_society:getSocietyMoney", function(money)
                jobData.balance = money
                moneyPromise:resolve()
            end, jobData.job)
            Citizen.Await(moneyPromise)

            local employeesPromise = promise.new()
            ESX.TriggerServerCallback("esx_society:getEmployees", function(employees)
                jobData.employees = employees
                for i = 1, #employees do
                    local employee = employees[i]
                    employees[i] = {
                        name = employee.name,
                        id = employee.identifier,

                        gradeLabel = employee.job.grade_label,
                        grade = employee.job.grade,

                        canInteract = employee.job.grade_name ~= "boss"
                    }
                end
                employeesPromise:resolve()
            end, jobData.job)
            Citizen.Await(employeesPromise)

            local gradesPromise = promise.new()
            ESX.TriggerServerCallback("esx_society:getJob", function(job)
                local grades = {}
                for i = 1, #job.grades do
                    local grade = job.grades[i]
                    grades[i] = {
                        label = grade.label,
                        grade = grade.grade
                    }
                end
                jobData.grades = grades
                gradesPromise:resolve()
            end, jobData.job)
            Citizen.Await(gradesPromise)
        end

        cb(jobData)
    end

    function DepositMoney(amount, cb)
        TriggerServerEvent("esx_society:depositMoney", ESX.PlayerData.job.name, amount)
        SetTimeout(500, function()
            ESX.TriggerServerCallback("esx_society:getSocietyMoney", cb, ESX.PlayerData.job.name)
        end)
    end

    function WithdrawMoney(amount, cb)
        TriggerServerEvent("esx_society:withdrawMoney", ESX.PlayerData.job.name, amount)
        SetTimeout(500, function()
            ESX.TriggerServerCallback("esx_society:getSocietyMoney", cb, ESX.PlayerData.job.name)
        end)
    end

    function HireEmployee(source, cb)
        ESX.TriggerServerCallback("esx_society:getOnlinePlayers", function(players)
            for i = 1, #players do
                local player = players[i]
                if player.source == source then
                    ESX.TriggerServerCallback("esx_society:setJob", function()
                        cb({
                            name = player.name,
                            id = player.identifier
                        })
                    end, player.identifier, ESX.PlayerData.job.name, 0, "hire")
                    return
                end
            end
        end)
    end

    function FireEmployee(identifier, cb)
        ESX.TriggerServerCallback("esx_society:setJob", function()
            cb(true)
        end, identifier, "unemployed", 0, "fire")
    end

    function SetGrade(identifier, newGrade, cb)
        ESX.TriggerServerCallback("esx_society:getJob", function(job)
            if newGrade > #job.grades - 1 then
                return cb(false)
            end

            ESX.TriggerServerCallback("esx_society:setJob", function()
                cb(true)
            end, identifier, ESX.PlayerData.job.name, newGrade, "promote")
        end, ESX.PlayerData.job.name)
    end

    --IMPLEMENT DUTY SYSTEM FOR ESX HERE
    -- function ToggleDuty()
    -- end
end)
