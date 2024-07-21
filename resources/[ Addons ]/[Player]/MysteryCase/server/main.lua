if AK4Y.Framework == "esx" then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif AK4Y.Framework == "newEsx" then 
    ESX = exports["es_extended"]:getSharedObject()
end

local lastItems = {}

-- MYSQL
local Lite = {};
function Lite:Logs(Executed, Message)
    local Started = Executed;
end
CASHOUT = {}
LiteMySQL = {};
local Select = {};
local Where = {}
local Wheres = {}
function LiteMySQL:Insert(Table, Content)
    local executed = GetGameTimer();
    local fields = "";
    local keys = "";
    local id = nil;
    for key, _ in pairs(Content) do
        fields = string.format('%s`%s`,', fields, key)
        key = string.format('@%s', key)
        keys = string.format('%s%s,', keys, key)
    end
    MySQL.Async.insert(string.format("INSERT INTO %s (%s) VALUES (%s)", Table, string.sub(fields, 1, -2), string.sub(keys, 1, -2)), Content, function(insertId)
        id = insertId;
    end)
    while (id == nil) do
        Citizen.Wait(1.0)
    end
    Lite:Logs(executed, string.format('^2INSERT %s', Table))
    if (id ~= nil) then
        return id;
    else
        error("InsertId is nil")
    end
end
local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }
function CreateRandomPlateTextForXP()
    local plate = ""
    math.randomseed(GetGameTimer())
    for i = 1, 4 do
        plate = plate .. characters[math.random(1, #characters)]
    end
    plate = plate .. ""
    for i = 1, 4 do
        plate = plate .. math.random(1, 9)
    end
    return plate
end

function LiteMySQL:Update(Table, Column, Operator, Value, Content)
    local executed = GetGameTimer();
    self.affectedRows = nil;
    self.keys = "";
    self.args = {};
    for key, value in pairs(Content) do
        self.keys = string.format("%s`%s` = @%s, ", self.keys, key, key)
        self.args[string.format('@%s', key)] = value;
    end
    self.args['@value'] = Value;
    local query = string.format("UPDATE %s SET %s WHERE %s %s @value", Table, string.sub(self.keys, 1, -3), Column, Operator, Value)
    MySQL.Async.execute(query, self.args, function(affectedRows)
        self.affectedRows = affectedRows;
    end)
    while (self.affectedRows == nil) do
        Citizen.Wait(1.0)
    end
    Lite:Logs(executed, string.format('^4UPDATED %s', Table))
    if (self.affectedRows ~= nil) then
        return self.affectedRows;
    end
end
function LiteMySQL:UpdateWheres(Table, Where, Content)
    local executed = GetGameTimer();
    self.affectedRows = nil;
    self.keys = "";
    self.content = "";
    self.args = {};
    for key, value in pairs(Content) do
        self.content = string.format("%s`%s` = @%s, ", self.content, key, key)
        self.args[string.format('@%s', key)] = value;
    end
    for _, value in pairs(Where) do
        self.keys = string.format("%s `%s` %s @%s AND ", self.keys, value.column, value.operator, value.column)
        self.args[string.format('@%s', value.column)] = value.value;
    end
    local query = string.format('UPDATE %s SET %s WHERE %s', Table, string.sub(self.content, 1, -3), string.sub(self.keys, 1, -5));
    MySQL.Async.execute(query, self.args, function(affectedRows)
        self.affectedRows = affectedRows;
    end)
    while (self.affectedRows == nil) do
        Citizen.Wait(1.0)
    end
    Lite:Logs(executed, string.format('^4UPDATED %s', Table))
    if (self.affectedRows ~= nil) then
        return self.affectedRows;
    end
end
function LiteMySQL:Select(Table)
    self.SelectTable = Table
    return Select;
end
function LiteMySQL:GetSelectTable()
    return self.SelectTable;
end
function Select:All()
    local executed = GetGameTimer();
    local storage = nil;
    MySQL.Async.fetchAll(string.format('SELECT * FROM %s', LiteMySQL:GetSelectTable()), { }, function(result)
        if (result ~= nil) then
            storage = result
        end
    end)
    while (storage == nil) do
        Citizen.Wait(1.0)
    end
    Lite:Logs(executed, string.format('^5SELECTED ALL %s', LiteMySQL:GetSelectTable()))
    return #storage, storage;
end
function Select:Delete(Column, Operator, Value)
    local executed = GetGameTimer();
    local count = 0;
    MySQL.Async.execute(string.format('DELETE FROM %s WHERE %s %s @value', LiteMySQL:GetSelectTable(), Column, Operator), { ['@value'] = Value }, function(affectedRows)
        count = affectedRows
    end)
    while (count == 0) do
        Citizen.Wait(1.0)
    end
    Lite:Logs(executed, string.format('^8DELETED %s WHERE %s %s %s', LiteMySQL:GetSelectTable(), Column, Operator, Value))
    return count;
end
function Select:GetWhereResult()
    return self.whereStorage;
end
function Select:GetWhereConditions(Id)
    return self.whereConditions[Id or 1];
end
function Select:GetWheresResult()
    return self.wheresStorage;
end
function Select:GetWheresConditions()
    return self.wheresConditions;
end
function Select:Where(Column, Operator, Value)
    local executed = GetGameTimer();
    self.whereStorage = nil;
    self.whereConditions = { Column, Operator, Value };
    MySQL.Async.fetchAll(string.format('SELECT * FROM %s WHERE %s %s @value', LiteMySQL:GetSelectTable(), Column, Operator), { ['@value'] = Value }, function(result)
        if (result ~= nil) then
            self.whereStorage = result
        end
    end)
    while (self.whereStorage == nil) do
        Citizen.Wait(1.0)
    end
    Lite:Logs(executed, string.format('^5SELECTED %s WHERE %s %s %s', LiteMySQL:GetSelectTable(), Column, Operator, Value))
    return Where;
end
function Where:Update(Content)
    if (self:Exists()) then
        local Table = LiteMySQL:GetSelectTable();
        local Column = Select:GetWhereConditions(1);
        local Operator = Select:GetWhereConditions(2);
        local Value = Select:GetWhereConditions(3);
        LiteMySQL:Update(Table, Column, Operator, Value, Content)
    else
        error('Not exists')
    end
end
function Where:Exists()
    return Select:GetWhereResult() ~= nil and #Select:GetWhereResult() >= 1
end
function Where:Get()
    local result = Select:GetWhereResult();
    return #result, result;
end
function Select:Wheres(Table)
    local executed = GetGameTimer();
    self.wheresStorage = nil;
    self.keys = "";
    self.args = {};
    for key, value in pairs(Table) do
        self.keys = string.format("%s `%s` %s @%s AND ", self.keys, value.column, value.operator, value.column)
        self.args[string.format('@%s', value.column)] = value.value;
    end
    local query = string.format('SELECT * FROM %s WHERE %s', LiteMySQL:GetSelectTable(), string.sub(self.keys, 1, -5));
    MySQL.Async.fetchAll(query, self.args, function(result)
        if (result ~= nil) then
            self.wheresStorage = result
        end
    end)
    while (self.wheresStorage == nil) do
        Citizen.Wait(1.0)
    end
    Lite:Logs(executed, string.format('^5SELECT %s WHERE %s', LiteMySQL:GetSelectTable(), json.encode(self.args)))
    return Wheres;
end
function Wheres:Exists()
    return Select:GetWheresResult() ~= nil and #Select:GetWheresResult() >= 1
end
function Wheres:Get()
    local result = Select:GetWheresResult();
    return #result, result;
end

function GetAllSourceIdentifiers(src)
    local steam, fivem = "0", "0"
    local ste, fiv = "license:", "fivem:"
    for _, v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len(ste)) == ste then
            steam = string.sub(v, #ste + 1)
        end
        if string.sub(v, 1, string.len(fiv)) == fiv then
            fivem = string.sub(v, #fiv + 1)
        end
    end
    return steam, fivem
end

TOTALBUY = {}

function GetIdentifiers(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    else
        error("source is nil")
    end
end

ESX.RegisterServerCallback('ValestiaCase:getPlayerDetails', function(source, cb)
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")

        MySQL.Async.fetchAll("SELECT SUM(points) FROM tebex_players_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            if (result[1]["SUM(points)"] ~= nil) then
                cb(result[1]["SUM(points)"])
            else
                cb(0)
            end
        end);
    else
        cb(0)
    end
end)


function OnProcessCheckout2(source, price, transaction, onAccepted, onRefused)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        MySQL.Async.fetchAll("SELECT SUM(points) FROM tebex_players_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            local current = tonumber(result[1]["SUM(points)"]);
            if (current ~= nil) then
                if (current >= price) then
                    LiteMySQL:Insert('tebex_players_wallet', {
                        identifiers = after,
                        transaction = transaction,
                        price = '0',
                        currency = 'Points',
                        points = -price,
                    });

                    if CASHOUT[xPlayer.identifier] ~= nil then 
                        if CASHOUT[xPlayer.identifier] + price >= 5000 then
                            local newCashout = CASHOUT[xPlayer.identifier] + price - 5000
                            TOTALBUY[xPlayer.identifier] = TOTALBUY[xPlayer.identifier]+price
                            CASHOUT[xPlayer.identifier] = newCashout
                            Wait(500)
                            MySQL.Async.execute('UPDATE tebex_fidelite SET havebuy = @havebuy, totalbuy = @totalbuy WHERE license = @license',{
                                ['@license'] = xPlayer.identifier,
                                ['@havebuy'] = tonumber(CASHOUT[xPlayer.identifier]),
                                ['@totalbuy'] = tonumber(TOTALBUY[xPlayer.identifier])
                            })
                            xPlayer.addInventoryItem('caisse_fidelite', 1)
                            if CASHOUT[xPlayer.identifier] < 5001 then 
                                --xPlayer.showAdvancedNotification('Boite Mail', 'Boutique Valestia', 'Félicitation vous avez gagner votre bonus fidélité ! \nOuvre ton inventaire ;)\nVous avez déjà '..CASHOUT[xPlayer.identifier]..'/5000 points pour obtenir la récompense fidélité', 'CHAR_MP_FM_CONTACT', 2)
                            end
                                if CASHOUT[xPlayer.identifier] >= 5000 then
                                CASHOUT[xPlayer.identifier] = CASHOUT[xPlayer.identifier] - 5000
                                Wait(500)
                                MySQL.Async.execute('UPDATE tebex_fidelite SET havebuy = @havebuy, totalbuy = @totalbuy WHERE license = @license',{
                                    ['@license'] = xPlayer.identifier,
                                    ['@havebuy'] = tonumber(CASHOUT[xPlayer.identifier]),
                                    ['@totalbuy'] = tonumber(TOTALBUY[xPlayer.identifier])
                                })
                                xPlayer.addInventoryItem('caisse_fidelite', 1)
                                if CASHOUT[xPlayer.identifier] < 5001 then 
                                    --xPlayer.showAdvancedNotification('Boite Mail', 'Boutique Valestia', 'Félicitation vous avez gagner votre bonus fidélité ! \nOuvre ton inventaire ;)\nVous avez déjà '..CASHOUT[xPlayer.identifier]..'/5000 points pour obtenir la récompense fidélité', 'CHAR_MP_FM_CONTACT', 2)
                                end
                                if CASHOUT[xPlayer.identifier] >= 5000 then
                                    CASHOUT[xPlayer.identifier] = CASHOUT[xPlayer.identifier] - 5000
                                    Wait(500)
                                    MySQL.Async.execute('UPDATE tebex_fidelite SET havebuy = @havebuy, totalbuy = @totalbuy WHERE license = @license',{
                                        ['@license'] = xPlayer.identifier,
                                        ['@havebuy'] = tonumber(CASHOUT[xPlayer.identifier]),
                                        ['@totalbuy'] = tonumber(TOTALBUY[xPlayer.identifier])
                                    })
                                    xPlayer.addInventoryItem('caisse_fidelite', 1)
                                    if CASHOUT[xPlayer.identifier] < 5001 then 
                                        --xPlayer.showAdvancedNotification('Boite Mail', 'Boutique Valestia', 'Félicitation vous avez gagner votre bonus fidélité ! \nOuvre ton inventaire ;)\nVous avez déjà '..CASHOUT[xPlayer.identifier]..'/5000 points pour obtenir la récompense fidélité', 'CHAR_MP_FM_CONTACT', 2)
                                    end
                                    if CASHOUT[xPlayer.identifier] >= 5000 then
                                        CASHOUT[xPlayer.identifier] = CASHOUT[xPlayer.identifier] - 5000
                                        Wait(500)
                                        MySQL.Async.execute('UPDATE tebex_fidelite SET havebuy = @havebuy, totalbuy = @totalbuy WHERE license = @license',{
                                            ['@license'] = xPlayer.identifier,
                                            ['@havebuy'] = tonumber(CASHOUT[xPlayer.identifier]),
                                            ['@totalbuy'] = tonumber(TOTALBUY[xPlayer.identifier])
                                        })
                                        xPlayer.addInventoryItem('caisse_fidelite', 1)
                                        if CASHOUT[xPlayer.identifier] < 5001 then 
                                           --xPlayer.showAdvancedNotification('Boite Mail', 'Boutique Valestia', 'Félicitation vous avez gagner votre bonus fidélité ! \nOuvre ton inventaire ;)\nVous avez déjà '..CASHOUT[xPlayer.identifier]..'/5000 points pour obtenir la récompense fidélité', 'CHAR_MP_FM_CONTACT', 2)
                                        end
                                    end
                                end
                            end
                        else
                            TOTALBUY[xPlayer.identifier] = TOTALBUY[xPlayer.identifier]+price
                            CASHOUT[xPlayer.identifier] = CASHOUT[xPlayer.identifier] + price
                            MySQL.Async.execute('UPDATE tebex_fidelite SET havebuy = @havebuy, totalbuy = @totalbuy WHERE license = @license',{
                                ['@license'] = xPlayer.identifier,
                                ['@havebuy'] = tonumber(CASHOUT[xPlayer.identifier]),
                                ['@totalbuy'] = tonumber(TOTALBUY[xPlayer.identifier])
                            })
                            --xPlayer.showAdvancedNotification('Boite Mail', 'Boutique Valestia', 'Il vous reste '..CASHOUT[xPlayer.identifier]..'/5000 points à utiliser\nAvant de toucher votre bonus fidélité !', 'CHAR_MP_FM_CONTACT', 2)
                        end
                    end
                    onAccepted();
                    TriggerClientEvent("hello:bro", source)
                else
                    onRefused();
                    xPlayer.showNotification('Vous ne disposez pas des points nécessaires pour effectuer votre achat. Veuillez visiter notre boutique.')
                end
            else
                onRefused();
            end
        end);
    else
        onRefused();
    end
end

ESX.RegisterServerCallback('ValestiaCase:selectedCaseOpen', function(source, cb, caseData, itemData)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenId = xPlayer.identifier
    local identifier = GetIdentifiers(source);

    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")

        MySQL.Async.fetchAll("SELECT SUM(points) FROM tebex_players_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            local point = tonumber(result[1]["SUM(points)"])
            if (point >= caseData.price) then
                if (point ~= nil) then
                    cb(point)
                else
                    cb(0)
                end
                if point ~= nil then    
                    if caseData.priceType == "Coins" then 
                        if point >= caseData.price then
                            OnProcessCheckout2(source, caseData.price, string.format("Achat caisse mystère"), function()
                            end, function()
                                return
                            end)
                        else
                            cb(false)
                        end
                    end
                else
                    cb(false)
                end
            end
        end);
    else
        cb(false)
    end

end)

ESX.RegisterServerCallback('ValestiaCase:collectItem', function(source, cb, itemData, caseData)  
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local citizenId = xPlayer.identifier

    local firstName = GetPlayerName(_source)
    local lastName = ""
    
    local itemValue = itemData.itemType
    local itemType = itemData.giveItemType
    local itemName = itemData.itemName
    local itemCount = itemData.itemCount
    local itemLabel = itemData.label
    local itemImage = itemData.image
    local caseName = caseData.label

    local lastRegister = false 
    local serverNotify = false
    for k, v in pairs(AK4Y.LastItemCategories) do 
        if v == itemValue then 
            lastRegister = true
        end
    end  
    for k, v in pairs(AK4Y.ServerNotifyCategories) do 
        if v == itemValue then 
            serverNotify = true
        end
    end  
    
    -- if serverNotify then 
    --     TriggerClientEvent('ValestiaCase:serverNotif', -1, {firstName = firstName, lastName = lastName, itemLabel = itemLabel, itemImage = itemImage})
    -- end

    if lastRegister then 
        local idData = #lastItems + 1
    
        if #lastItems > 9 then 
            local lowestIndex = 99999
            for k, v in pairs(lastItems) do
                local indexim = v.id
                if indexim < lowestIndex then 
                    lowestIndex = indexim
                end
            end
            for k, v in pairs(lastItems) do 
                if v.id == lowestIndex then 
                    lastItems[k] = nil
                end
            end
        end
    
        local indexData = #lastItems + 1
        lastItems[indexData] = {}
        lastItems[indexData]["id"] = idData
        lastItems[indexData]["itemLabel"] = itemLabel
        lastItems[indexData]["itemImage"] = itemImage
        lastItems[indexData]["itemType"] = itemValue
        lastItems[indexData]["caseName"] = caseName
        lastItems[indexData]["firstname"] = firstName
        lastItems[indexData]["lastname"] = lastName
    end

    
    if itemType == "item" then 
        xPlayer.addInventoryItem(itemName, itemCount)
    elseif itemType == "weapon" then 
        if AK4Y.WeaponsAreItem then 
            for i = 1, count, 1 do 
                xPlayer.addInventoryItem(itemName, 1)
            end
        else
            xPlayer.addWeapon(itemName, itemCount)
        end
    elseif itemType == "vehicle" then
        for i = 1, itemCount do 
            local plate = CreateRandomPlateTextForXP()
            local vehicleData = {}
            vehicleData.model = GetHashKey(itemName)
            vehicleData.plate = plate
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @state, @stored, @boutique)', {
                ['@owner']   = xPlayer.identifier,
                ['@plate']   = plate,
                ['@vehicle'] = json.encode(vehicleData),
                ['@state']   = 0,
                ['@stored']  = 1,
                ['@boutique']  = 1
            }, function(rowsChange) end)
            ESX.GiveCarKey(xPlayer, plate);
        end
    elseif itemType == "money" then 
        xPlayer.addAccountMoney('bank', itemCount)
    elseif itemType == "coins" then 
        local identifier = GetIdentifiers(source);
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        LiteMySQL:Insert('tebex_players_wallet', {
            identifiers = after,
            transaction = 'Gain de coins via une caisse',
            price = 0,
            currency = 'Points',
            points = itemCount,
        });

    end
    SendToDiscord("CitizenID: ``"..citizenId.."``\nITEM: ``"..itemName.."``\nCOUNT: ``"..itemCount.."``\nITEM TYPE: ``"..itemType.."``\nITEM COLLECTED!")
    callBackData = {
        state = true,
        lastItems = lastItems,
    }
    cb(callBackData)  
end)

ESX.RegisterServerCallback('ValestiaCase:sellItem', function(source, cb, caseData, itemData)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenId = xPlayer.identifier  
    if caseData.priceType == "Coins" then 
        local identifier = GetIdentifiers(source);
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")

        MySQL.Async.execute('INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@identifiers, @transaction, @price, @currency, @points)', {
            ['@identifiers']   = after,
            ['@transaction']   = 'Gain de coins via une caisse',
            ['@price'] = 0,
            ['@currency']   = 'Points',
            ['@points']  = itemData.sellCredit
        }, function(rowsChange) end)
        cb(true)
    end
    SendToDiscord("CitizenID: ``"..citizenId.."``\nCREDIT: ``"..itemData.sellCredit.."``\nPRICE TYPE: ``"..caseData.priceType.."``\nITEM SELLED!")
end)


local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

ESX.RegisterServerCallback('ValestiaCase:sendInput', function(source, cb, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local citizenId = xPlayer.identifier
    local inputData = data.input
    local result = ExecuteSql("SELECT * FROM ValestiaCase_codes WHERE code = '"..inputData.."'")
    if result[1] ~= nil then
        ExecuteSql("DELETE FROM ValestiaCase_codes WHERE code = '"..inputData.."'")
        ExecuteSql("UPDATE ValestiaCase SET goldcoin = goldcoin + '"..result[1].creditCount.."' WHERE citizenid = '"..citizenId.."'")
        SendToDiscord("CitizenID: ``"..citizenId.."``\nCODE: ``"..inputData.."``\nCREDIT: ``"..result[1].creditCount.."``\nCode used!")
        cb(result[1].creditCount)
    else
        cb(false)
    end
end)

-- RegisterNetEvent('ValestiaCase:addGoldCoin')
-- AddEventHandler('ValestiaCase:addGoldCoin', function(amount)
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--     local citizenId = xPlayer.identifier
--     local deger = tonumber(amount)
--     ExecuteSql("UPDATE ValestiaCase SET goldcoin = goldcoin + '"..deger.."' WHERE citizenid = '"..citizenId.."'")
--     -- SendToDiscord("CitizenID: ``"..citizenId.."``\n``"..deger.."``\n**Gold Coin ADDED!**")
-- end)

-- RegisterNetEvent('ValestiaCase:addSilverCoin')
-- AddEventHandler('ValestiaCase:addSilverCoin', function(amount)
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--     local citizenId = xPlayer.identifier
--     local deger = tonumber(amount)
--     ExecuteSql("UPDATE ValestiaCase SET silvercoin = silvercoin + '"..deger.."' WHERE citizenid = '"..citizenId.."'")
--     SendToDiscord("CitizenID: ``"..citizenId.."``\n``"..deger.."``\n**Silver Coin ADDED!**")
-- end)

RegisterCommand('purchase_caseopening_credit', function(source, args)
	local src = source
    if src == 0 then
        local dec = json.decode(args[1])
        local tbxid = dec.transid
        local credit = dec.credit
        while inProgress do
            Wait(1000)
        end
        inProgress = true
        local result = ExecuteSql("SELECT * FROM ValestiaCase_codes WHERE code = '"..tbxid.."'")
        if result[1] == nil then
            ExecuteSql("INSERT INTO ValestiaCase_codes (code, creditCount) VALUES ('"..tbxid.."', '"..credit.."')")
            SendToDiscord("Code: ``"..tbxid.."``\nCredit: ``"..credit.."``\nsuccessfuly into your database!")
        end
        inProgress = false  
    end
end)



local DISCORD_NAME = "AK4Y Scripts"
local DISCORD_IMAGE = "https://steamuserimages-a.akamaihd.net/ugc/848220336390493472/73E4DDF575623F925D0E727FBB0AE67EBFF6902E/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true"
Discord_Webhook = "https://discord.com/api/webhooks/1226972621883707494/OsWdYhkswuT99JsJZfUw_q5g6mx-C0Odt_0RlkGZQZeQvcZ8VfuJR9mvbgaU-Lq7HF-a"
function SendToDiscord(name, message, color)
	if Discord_Webhook == "CHANGE_WEBHOOK" then
	else
		local connect = {
            {
                ["color"] = color,
                ["title"] = "**".. name .."**",
                ["description"] = message,
                ["footer"] = {
                ["text"] = "AK4Y CASEOPENING",
                },
            },
	    }
		PerformHttpRequest(Discord_Webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatarrl = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	end
end

function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if AK4Y.Mysql == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.query(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif AK4Y.Mysql == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif AK4Y.Mysql == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end


RegisterNetEvent("ewen:boutiquecashout")
AddEventHandler("ewen:boutiquecashout", function()
    local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer) then
		MySQL.Async.fetchAll('SELECT * FROM `tebex_fidelite` WHERE `license` = @license', {
			['@license'] = xPlayer.identifier
		}, function(result)
			if result[1] then
				CASHOUT[xPlayer.identifier] = result[1].havebuy
				TOTALBUY[xPlayer.identifier] = result[1].totalbuy
			else
				MySQL.Async.execute('INSERT INTO tebex_fidelite (license, havebuy, totalbuy) VALUES (@license, @havebuy, @totalbuy)', {
					['@license'] = xPlayer.identifier,
					['@havebuy'] = 0,
					['@totalbuy'] = 0,
				}, function()
				end)
				CASHOUT[xPlayer.identifier] = 0
				TOTALBUY[xPlayer.identifier] = 0
			end
		end)
	end
end)

AddEventHandler('playerDropped', function (reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then
        if CASHOUT[xPlayer.identifier] then
			CASHOUT[xPlayer.identifier] = nil
			TOTALBUY[xPlayer.identifier] = nil
        end
    end
end)