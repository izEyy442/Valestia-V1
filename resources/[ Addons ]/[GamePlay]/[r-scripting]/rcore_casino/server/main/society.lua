local function OkOk_GetBalance()
    local balance = nil
    local result = MySQL.Sync.fetchAll('SELECT `value` FROM `okokbanking_societies` WHERE society = @society', {
        ['@society'] = Config.SocietyName
    })

    if result and #result == 1 then
        balance = result[1]["value"]
    end

    if not balance then
        print(string.format("^1[%s][ERROR]^7 Society ^1'%s'^7 in okokbanking_societies does not exist!",
            GetCurrentResourceName(), Config.SocietyName))
        balance = 0
    end

    return balance
end

local function AddonAccount_GetBalance()
    local balance = nil
    local result = MySQL.Sync.fetchAll('SELECT `money` FROM `addon_account_data` WHERE account_name = @society', {
        ['@society'] = Config.SocietyName
    })

    if result and #result == 1 then
        balance = result[1]["money"]
    end

    if not balance then
        print(string.format("^1[%s][ERROR]^7 Society ^1'%s'^7 in addon_account_data does not exist!",
            GetCurrentResourceName(), Config.SocietyName))
        balance = 0
    end
    return balance
end

local function AddonAccount_UpdateBalance(newBalance)
    MySQL.Sync.execute('UPDATE `addon_account_data` SET money = @newBalance WHERE account_name = @society', {
        ['@newBalance'] = tostring(newBalance),
        ['@society'] = Config.SocietyName
    })
end

local function OkOk_UpdateBalance(newBalance)
    MySQL.Sync.execute('UPDATE `okokbanking_societies` SET value = @newBalance WHERE society = @society', {
        ['@newBalance'] = tostring(newBalance),
        ['@society'] = Config.SocietyName
    })
end

local function _710_GetBalance()
    local account = exports['710-Management']:GetManagementAccount(Config.SocietyName)
    if not account then
        return 0
    end
    return account.balance
end

local function _710_AddMoney(money)
    exports['710-Management']:AddAccountMoney(Config.SocietyName, money)
end

local function _710_RemoveMoney(money)
    local b = _710_GetBalance()
    if b < money then
        money = b
    end
    exports['710-Management']:RemoveAccountMoney(Config.SocietyName, money)
end

function RemoveMoneyFromSociety(money)
    if Framework.Active == 3 or Framework.Active == 4 then
        --[[ add your own method to handle society money in here:
        ...
        ]]
        return
    end
    if Config.SocietyFramework == "okokbanking" then
        local b = OkOk_GetBalance()
        b = b - money
        if b < 0 then
            b = 0
        end
        OkOk_UpdateBalance(b)
        return
    elseif Config.SocietyFramework == "710-Management" then
        _710_RemoveMoney(money)
        return
    elseif Config.SocietyFramework == "addon_account_data" then
        local b = AddonAccount_GetBalance()
        b = b - money
        if b < 0 then
            b = 0
        end
        AddonAccount_UpdateBalance(b)
        return
    end
    if Framework.Active == 2 then
        local moneyNow = GetMoneyFromSociety()
        if (moneyNow - money) < 0 then
            money = moneyNow
        end
        xpcall(function()
            local societyMoney = exports["qb-bossmenu"]:GetAccount(Config.SocietyName)
            -- if societyMoney >= money then
            TriggerEvent("qb-bossmenu:server:removeAccountMoney", Config.SocietyName, money)
            -- end
        end, function(error)
            local societyMoney = exports["qb-management"]:GetAccount(Config.SocietyName)
            -- if societyMoney >= money then
            exports["qb-management"]:RemoveMoney(Config.SocietyName, money)
            -- end
        end)
    end

    if Framework.Active == 1 then
        TriggerEvent('esx_addonaccount:getSharedAccount', Config.SocietyName, function(account)
            if account then
                -- if account.money >= money then
                account.removeMoney(money)
                -- end
            else
                print(string.format(
                    "^1[%s][ERROR]^7 Society ^1'%s'^7 does not exist! The Cashier will not work. Either create a society account for casino, or disable society in config.lua.",
                    GetCurrentResourceName(), Config.SocietyName))
            end
        end)
    end
end

function GiveMoneyToSociety(money)
    if Framework.Active == 3 or Framework.Active == 4 then
        --[[ add your own method to handle society money in here:
        ...
        ]]
        return
    end
    if Config.SocietyFramework == "okokbanking" then
        local b = OkOk_GetBalance()
        b = b + money
        OkOk_UpdateBalance(b)
        return
    elseif Config.SocietyFramework == "710-Management" then
        _710_AddMoney(money)
        return
    elseif Config.SocietyFramework == "addon_account_data" then
        local b = AddonAccount_GetBalance()
        b = b + money
        AddonAccount_UpdateBalance(b)
        return
    end
    if Framework.Active == 2 then
        xpcall(function()
            exports["qb-management"]:AddMoney(Config.SocietyName, money)
        end, function(error)
            TriggerEvent("qb-bossmenu:server:addAccountMoney", Config.SocietyName, money)
        end)
    end

    if Framework.Active == 1 then
        TriggerEvent('esx_addonaccount:getSharedAccount', Config.SocietyName, function(account)
            if account then
                account.addMoney(money)
            else
                print(string.format(
                    "^1[%s][ERROR]^7 Society ^1'%s'^7 does not exist! The Cashier will not work. Either create a society account for casino, or disable society in config.lua.",
                    GetCurrentResourceName(), Config.SocietyName))
            end
        end)
    end
end

function GetMoneyFromSociety()
    if not Config.EnableSociety then
        return 2147483647
    end
    if Framework.Active == 3 or Framework.Active == 4 then
        --[[ add your own method to handle society money in here:
        ...
        ]]
        return 1000000
    end
    if Config.SocietyFramework == "okokbanking" then
        return OkOk_GetBalance()
    elseif Config.SocietyFramework == "710-Management" then
        return _710_GetBalance()
    elseif Config.SocietyFramework == "addon_account_data" then
        return AddonAccount_GetBalance()
    end
    local result = nil
    local promise = promise:new()

    if Framework.Active == 2 then
        xpcall(function()
            local societyMoney = exports["qb-bossmenu"]:GetAccount(Config.SocietyName)
            result = societyMoney
            promise:resolve(result)
        end, function(error)
            local societyMoney = exports["qb-management"]:GetAccount(Config.SocietyName)
            result = societyMoney
            promise:resolve(result)
        end)
    end

    if Framework.Active == 1 then
        TriggerEvent('esx_addonaccount:getSharedAccount', Config.SocietyName, function(account)
            if account then
                result = account.money
                promise:resolve(result)
            else
                print(string.format(
                    "^1[%s][ERROR]^7 Society ^1'%s'^7 does not exist! The Cashier will not work. Either create a society account for casino, or disable society in config.lua.",
                    GetCurrentResourceName(), Config.SocietyName))
                result = 0
                promise:resolve(result)
            end
        end)
    end

    Citizen.Await(promise)
    return result
end
