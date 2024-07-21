---@diagnostic disable: param-type-mismatch
CreateThread(function()
    if Config.Framework ~= "qb" then
        return
    end

    local lib = exports.loaf_lib:GetLib()

    debugprint("Loading QB")
    local QB = exports["qb-core"]:GetCoreObject()
    local PlayerJob = {}

    while not LocalPlayer.state.isLoggedIn do
        Wait(500)
    end

    debugprint("QB loaded")
    loaded = true

    PlayerJob = QB.Functions.GetPlayerData().job

    RegisterNetEvent("QBCore:Client:OnPlayerUnload", LogOut)
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", FetchPhone)

    RegisterNetEvent("QBCore:Client:OnJobUpdate", function(jobInfo)
        PlayerJob = jobInfo
    end)

    ---Check if a player has a phone
    ---@return boolean
    function HasPhoneItem(number)
        if not Config.Item.Require then
            return true
        end

        if GetResourceState("ox_inventory") == "started" then
            return (exports.ox_inventory:Search("count", Config.Item.Name) or 0) > 0
        end

        if Config.Item.Unique then
            return HasPhoneNumber(number)
        else
            return QB.Functions.HasItem(Config.Item.Name)
        end
    end

    ---Check if the player has a job
    ---@param jobs table
    ---@return boolean
    function HasJob(jobs)
        local job = PlayerJob.name
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
        vehicleData.mods = json.decode(vehicleData.mods)

        local model = tonumber(vehicleData.hash)

        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(500)
        end

        local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, 0.0, true, false)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleNumberPlateText(vehicle, vehicleData.plate)

        QB.Functions.SetVehicleProperties(vehicle, vehicleData.mods)
        TriggerEvent("vehiclekeys:client:SetOwner", QB.Functions.GetPlate(vehicle))

        if GetResourceState("LegacyFuel") == "started" and vehicleData.fuel then
            exports.LegacyFuel:SetFuel(vehicle, vehicleData.fuel)
        end

        SetModelAsNoLongerNeeded(model)

        return vehicle
    end

    -- Company app
    function GetCompanyData(cb)
        local jobData = {
            job = PlayerJob.name,
            jobLabel = PlayerJob.label,
            isBoss = PlayerJob.isboss,
            duty = PlayerJob.onduty
        }

        if jobData.isBoss then
            local moneyPromise = promise.new()
            QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", function(money)
                moneyPromise:resolve(money)
            end, jobData.job)
            jobData.balance = Citizen.Await(moneyPromise)

            local employeesPromise = promise.new()
            QB.Functions.TriggerCallback("qb-bossmenu:server:GetEmployees", function(employees)
                for i = 1, #employees do
                    local employee = employees[i]
                    employees[i] = {
                        name = employee.name,
                        id = employee.empSource,

                        gradeLabel = employee.grade.name,
                        grade = employee.grade.level,

                        canInteract = not employee.isboss
                    }
                end
                employeesPromise:resolve(employees)
            end, jobData.job)
            jobData.employees = Citizen.Await(employeesPromise)

            jobData.grades = {}
            for k, v in pairs(QB.Shared.Jobs[jobData.job].grades) do
                jobData.grades[#jobData.grades + 1] = {
                    label = v.name,
                    grade = tonumber(k)
                }
            end

            table.sort(jobData.grades, function(a, b)
                return a.grade < b.grade
            end)
        end

        cb(jobData)
    end

    function DepositMoney(amount, cb)
        TriggerServerEvent("qb-bossmenu:server:depositMoney", amount)
        SetTimeout(1500, function()
            QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", cb, PlayerJob.name)
        end)
    end

    function WithdrawMoney(amount, cb)
        TriggerServerEvent("qb-bossmenu:server:withdrawMoney", amount)
        SetTimeout(1500, function()
            QB.Functions.TriggerCallback("qb-bossmenu:server:GetAccount", cb, PlayerJob.name)
        end)
    end

    function HireEmployee(source, cb)
        TriggerServerEvent("qb-bossmenu:server:HireEmployee", source)
        lib.TriggerCallback("phone:services:getPlayerData", function(playerData)
            cb({
                name = playerData.name,
                id = playerData.id
            })
        end, source)
    end

    function FireEmployee(source, cb)
        TriggerServerEvent("qb-bossmenu:server:FireEmployee", source)
        cb(PlayerJob.isboss)
    end

    function SetGrade(identifier, newGrade, cb)
        local maxGrade = 0
        for grade, _ in pairs(QB.Shared.Jobs[PlayerJob.name].grades) do
            grade = tonumber(grade)
            if grade and grade > maxGrade then
                maxGrade = grade
            end
        end

        if newGrade > maxGrade then
            return cb(false)
        end

        TriggerServerEvent("qb-bossmenu:server:GradeUpdate", {
            cid = identifier,
            grade = newGrade,
            gradename = QB.Shared.Jobs[PlayerJob.name].grades[tostring(newGrade)].name
        })
        cb(true)
    end

    function ToggleDuty()
        TriggerServerEvent("QBCore:ToggleDuty")
    end

    -- since qb has custom code for death, we need to override the IsPedDeadOrDying native
    local isPedDeadOrDying = IsPedDeadOrDying
    function IsPedDeadOrDying(ped, p1)
        local metadata = QB.Functions.GetPlayerData().metadata
        if metadata.ishandcuffed or metadata.isdead or metadata.inlaststand then
            return true
        end

        return isPedDeadOrDying(ped, p1)
    end

    if Config.Crypto.QBit then
        function GetQBit()
            local promise = promise.new()

            QB.Functions.TriggerCallback("qb-crypto:server:GetCryptoData", function(cryptoData)
                promise:resolve(cryptoData)
            end, "qbit")

            return Citizen.Await(promise)
        end

        function BuyQBit(amount)
            local promise = promise.new()

            QB.Functions.TriggerCallback("qb-crypto:server:BuyCrypto", function(res)
                promise:resolve({ success = type(res) == "table" })
            end, {
                Coins = amount / GetQBit().Worth,
                Price = amount
            })

            return Citizen.Await(promise)
        end

        function SellQBit(amount)
            local promise = promise.new()

            QB.Functions.TriggerCallback("qb-crypto:server:SellCrypto", function(res)
                promise:resolve({ success = type(res) == "table" })
            end, {
                Coins = amount,
                Price = math.floor(amount * GetQBit().Worth + 0.5)
            })

            return Citizen.Await(promise)
        end

        function TransferQBit(amount, toNumber)
            local otherWallet = lib.TriggerCallbackSync("phone:crypto:getOtherQBitWallet", toNumber)
            if not otherWallet then
                return { success = false }
            end

            local qbit = GetQBit()
            if qbit.Portfolio < amount then
                return { success = false }
            end

            local promise = promise.new()

            QB.Functions.TriggerCallback("qb-crypto:server:TransferCrypto", function(res)
                promise:resolve({ success = type(res) == "table" })
            end, {
                Coins = amount,
                WalletId = otherWallet
            })

            return Citizen.Await(promise)
        end
    end
end)