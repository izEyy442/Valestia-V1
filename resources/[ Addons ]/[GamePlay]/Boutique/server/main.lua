ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

-- MYSQL
local Lite = {};
function Lite:Logs(Executed, Message)
    local Started = Executed;
end
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
--MYSQL
CASHOUT = {}
TOTALBUY = {}

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

ESX.RegisterServerCallback('ewen:getPoints', function(source, callback)
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")

        MySQL.Async.fetchAll("SELECT SUM(points) FROM tebex_players_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            if (result[1]["SUM(points)"] ~= nil) then
                callback(result[1]["SUM(points)"])
            else
                callback(0)
            end
        end);
    else
        callback(0)
    end
end)

function OnProcessCheckout(source, price, transaction, onAccepted, onRefused)
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

local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

function CreateRandomPlateText()
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

RegisterNetEvent('BoutiqueBucket:SetEntitySourceBucket')
AddEventHandler('BoutiqueBucket:SetEntitySourceBucket', function(valeur)
    if valeur then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)

RegisterCommand('addPoints', function(source, args)
    if source == 0 then
        local identifier = GetIdentifiers(args[1]);
        if (identifier['fivem']) then
            local Target = ESX.GetPlayerFromId(args[1])
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            LiteMySQL:Insert('tebex_players_wallet', {
                identifiers = after,
                transaction = 'Ajout de Coins via la Console',
                price = 0,
                currency = 'Points',
                points = args[2],
            });
                MomoLogs('https://discord.com/api/webhooks/1226980188558987425/WucRegBqa9Ny0Hf_h9C1XneGtY8RvGO0kuShiGuFYPTCc9Gq_7si2OaT1XgKOUquctuU', "Boutique - GiveCoins","**CONSOLE** vien de GIVE des Coins a :\n**License** : "..Target.."\nNombre de Coins : "..args[2].."", 56108)
            Target.showNotification('Vous avez reçu ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..args[2].. ' Coins')
        else
            print('LE JOUEUR N\'A LIER AUCUN COMPTE FIVEM')
        end
    end
end)

RegisterCommand('VipPoints2', function(source, args)
    if source == 0 then
        local identifier = GetIdentifiers(args[1]);
        if (identifier['fivem']) then
            local Target = ESX.GetPlayerFromId(args[1])
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            local transactionboutique = args[3]
            LiteMySQL:Insert('tebex_players_wallet', {
                identifiers = after,
                transaction = 'Bonus VIP Gold',
                price = 0,
                currency = 'Points',
                points = args[2],
            });
                MomoLogs('https://discord.com/api/webhooks/1226980188558987425/WucRegBqa9Ny0Hf_h9C1XneGtY8RvGO0kuShiGuFYPTCc9Gq_7si2OaT1XgKOUquctuU', "Boutique - GiveCoins","**CONSOLE** vien de GIVE des Coins a :\n**License** : "..Target.."\nNombre de Coins : "..args[2].."", 56108)
            Target.showNotification('Vous avez reçu votre bonus de '..args[2].. ' Coins grâce au Vip !')
        else
            print('LE JOUEUR N\'A LIER AUCUN COMPTE FIVEM')
        end
    end
end)

RegisterCommand('VipPoints3', function(source, args)
    if source == 0 then
        local identifier = GetIdentifiers(args[1]);
        if (identifier['fivem']) then
            local Target = ESX.GetPlayerFromId(args[1])
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            local transactionboutique = args[3]
            LiteMySQL:Insert('tebex_players_wallet', {
                identifiers = after,
                transaction = 'Bonus VIP Diamond',
                price = 0,
                currency = 'Points',
                points = args[2],
            });
                MomoLogs('https://discord.com/api/webhooks/1226980188558987425/WucRegBqa9Ny0Hf_h9C1XneGtY8RvGO0kuShiGuFYPTCc9Gq_7si2OaT1XgKOUquctuU', "Boutique - GiveCoins","**CONSOLE** vien de GIVE des Coins a :\n**License** : "..Target.."\nNombre de Coins : "..args[2].."", 56108)
            Target.showNotification('Vous avez reçu votre bonus de '..args[2].. ' Coins grâce au Vip !')
        else
            print('LE JOUEUR N\'A LIER AUCUN COMPTE FIVEM')
        end
    end
end)

RegisterCommand('tebex_paid', function(source, args, rC)
    if source == 0 then
        print('Command executed by Tebex: '..rC)
        LiteMySQL:Insert('tebex_players_wallet', {
            identifiers = args[1],
            transaction = 'Achat Tebex de '..args[2].. ' Coins',
            price = 0,
            currency = 'EUR',
            points = args[2]
        })
    end
end, false)

-- VEHICULES

RegisterNetEvent('aBoutique:BuyVehicle')
AddEventHandler('aBoutique:BuyVehicle', function(model, price, label)
    if SecurityVehicles[model] == nil then 
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        SeaLogs('', "Un Cheateur à été detecté","**"..GetPlayerName(source).."** à essayé d'acheter ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] Coins', 56108)
        return
    end
    if SecurityVehicles[model].model == model and SecurityVehicles[model].price == price then
        local xPlayer = ESX.GetPlayerFromId(source)
            OnProcessCheckout(source, SecurityVehicles[model].price, string.format("%s", label), function()
                local plate = CreateRandomPlateText()
                LiteMySQL:Insert('owned_vehicles', {
                    owner = xPlayer.identifier,
                    plate = plate,
                    vehicle = json.encode({ model = GetHashKey(model), plate = plate }),
                    type = 'car',
                    state = 1,
                    stored = 1,
                    boutique = 1,
                })
                LiteMySQL:Insert('open_car', {
                    owner = xPlayer.identifier,
                    plate = plate
                });
                ESX.GiveCarKey(xPlayer, plate, true);
                xPlayer.showNotification("Vous avez acheté : " .. label .. " dans la boutique !")
                SeaLogs('', "Boutique - Véhicules","Nom : ".. GetPlayerName(xPlayer.source).. '\nIdentifier : '.. xPlayer.identifier .. '\nA acheté un véhicule\nVéhicule obtenu : **'..label..'**\nPlaque d\'immatriculation : '.. plate, 56108)
        end, function()
            xPlayer.showNotification("Vous ne possédez pas les points nécessaires.")
            return
        end)
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterNetEvent('aBoutique:BuyVehiclePlane')
AddEventHandler('aBoutique:BuyVehiclePlane', function(model, label)
    if SecurityVehiclesPlane[model] == nil then 
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        SeaLogs('', "Un Cheateur à été detecté","**"..GetPlayerName(source).."** à essayé d'acheter ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] Coins', 56108)
        return
    end
    if SecurityVehiclesPlane[model].model == model then
        local xPlayer = ESX.GetPlayerFromId(source)
            OnProcessCheckout(source, SecurityVehiclesPlane[model].price, string.format("%s", label), function()
                local plate = CreateRandomPlateText()
                LiteMySQL:Insert('owned_vehicles', {
                    owner = xPlayer.identifier,
                    plate = plate,
                    vehicle = json.encode({ model = GetHashKey(model), plate = plate }),
                    type = 'aircraft',
                    state = 1,
                    stored = 1,
                    boutique = 1,
                })
                LiteMySQL:Insert('open_car', {
                    owner = xPlayer.identifier,
                    plate = plate
                });
                xPlayer.showNotification("Vous avez acheté : " .. label .. " dans la boutique !")
                SeaLogs('', "Boutique - Bateaux","Nom : ".. GetPlayerName(xPlayer.source).. '\nIdentifier : '.. xPlayer.identifier .. '\nA acheté un véhicule\nVéhicule obtenu : **'..label..'**\nPlaque d\'immatriculation : '.. plate, 56108)
        end, function()
            xPlayer.showNotification("Vous ne possédez pas les points nécessaires.")
            return
        end)
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterNetEvent('aBoutique:BuyVehicleBoat')
AddEventHandler('aBoutique:BuyVehicleBoat', function(model, label)
    if SecurityVehiclesBoat[model] == nil then 
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        SeaLogs('', "Un Cheateur à été detecté","**"..GetPlayerName(source).."** à essayé d'acheter ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] Coins', 56108)
        return
    end
    if SecurityVehiclesBoat[model].model == model then
        local xPlayer = ESX.GetPlayerFromId(source)
            OnProcessCheckout(source, SecurityVehiclesBoat[model].price, string.format("%s", label), function()
                local plate = CreateRandomPlateText()
                LiteMySQL:Insert('owned_vehicles', {
                    owner = xPlayer.identifier,
                    plate = plate,
                    vehicle = json.encode({ model = GetHashKey(model), plate = plate }),
                    type = 'boat',
                    state = 1,
                    stored = 1,
                    boutique = 1,
                })
                LiteMySQL:Insert('open_car', {
                    owner = xPlayer.identifier,
                    plate = plate
                });
                xPlayer.showNotification("Vous avez acheté : " .. label .. " dans la boutique !")
                SeaLogs('', "Boutique - Bateaux","Nom : ".. GetPlayerName(xPlayer.source).. '\nIdentifier : '.. xPlayer.identifier .. '\nA acheté un véhicule\nVéhicule obtenu : **'..label..'**\nPlaque d\'immatriculation : '.. plate, 56108)
        end, function()
            xPlayer.showNotification("Vous ne possédez pas les points nécessaires.")
            return
        end)
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

-- PACKS

RegisterNetEvent('aBoutique:Entreprise')
AddEventHandler('aBoutique:Entreprise', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 5000, string.format("Achat de Pack Entreprise"), function()
        xPlayer.showNotification('Vous avez acquis le Pack Entreprise pour 5000 ~y~Coins\nFaites un ticket sur Discord')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Entreprise***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [5000] Coins', 56108)       
    end, function()
        return
    end)
end)

RegisterNetEvent('aBoutique:Illegal')
AddEventHandler('aBoutique:Illegal', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 4000, string.format("Achat de Pack Illégal (Orga)"), function()
        xPlayer.showNotification('Vous avez acquis le Pack Illégal pour 4000 ~y~Coins\nFaites un ticket sur Discord')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Illégal***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [3500] Coins', 56108)       
    end, function()
        return
    end)
end)

RegisterNetEvent('aBoutique:Illegal2')
AddEventHandler('aBoutique:Illegal2', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 3000, string.format("Achat de Pack Illégal (Gang)"), function()
        xPlayer.showNotification('Vous avez acquis le Pack Illégal pour 3000 ~y~Coins\nFaites un ticket sur Discord')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Illégal***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [3000] Coins', 56108)       
    end, function()
        return
    end)
end)

RegisterNetEvent('aBoutique:BuyCustomMax')
AddEventHandler('aBoutique:BuyCustomMax', function(vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 1000, string.format("Achat de Pack Customisation"), function()
        TriggerClientEvent('aBoutique:BuyCustomMaxClient', xPlayer.source, vehicle)
        xPlayer.showNotification('Vous avez acquis le Pack Customisation pour 1000 ~y~Coins')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Customisation***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [1000] Coins', 56108)    
    end, function()
        return
    end)
end)

RegisterNetEvent('aBoutique:CircuitDrogue')
AddEventHandler('aBoutique:CircuitDrogue', function(vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 5000, string.format("Achat Circuit de drogue personnalisé"), function()
        xPlayer.showNotification('Vous avez acquis un Circuit de drogue personnalisé our 5000 ~y~Coins\nFaites un ticket sur Discord')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter ***Circuit de drogue personnalisé***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [5000] Coins', 56108)    
    end, function()
        return
    end)
end)

RegisterNetEvent('aBoutique:IllegalWeapon')
AddEventHandler('aBoutique:IllegalWeapon', function(vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 25000, string.format("Achat Vente d\'arme Illégal"), function()
        xPlayer.showNotification('Vous avez acquis Vente d\'arme Illégal pour 25 000 ~y~Coins\nFaites un ticket sur Discord')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter ***Vente d\'arme Illégal***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [25000] Coins', 56108)    
    end, function()
        return
    end)
end)

RegisterNetEvent('aBoutique:entreprise')
AddEventHandler('aBoutique:entreprise', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 4000, string.format("Achat Entreprise"), function()
        xPlayer.showNotification('Vous avez acquis une entreprise pour 4000 ~y~Coins\nFaites un ticket sur le Discord')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter ***Entreprise***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [2000] Coins', 56108)    
    end, function()
        return
    end)
end)

RegisterNetEvent('aBoutique:vehunique')
AddEventHandler('aBoutique:vehunique', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 7000, string.format("Achat Véhicule Unique"), function()
        xPlayer.showNotification('Vous avez un Véhicule au choix pour 7000 ~y~Coins\nFaites un ticket sur le Discord')
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter ***Véhicule Unique***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [7000] Coins', 56108)    
    end, function()
        return
    end)
end)

-- CUSTOM ARMES

local Hash = GetHashKey;

local tints = ESX.GetConfig().DefaultWeaponTints

local WEAPON_CUSTOM_PRICE = {
    -- Melee
    {name = 'WEAPON_DAGGER', label = _U('weapon_dagger'), components = {}},
    {name = 'WEAPON_BAT', label = _U('weapon_bat'), components = {}},
    {name = 'WEAPON_BATTLEAXE', label = _U('weapon_battleaxe'), components = {}},
    {
        name = 'WEAPON_KNUCKLE',
        label = _U('weapon_knuckle'),
        components = {
            {name = 'knuckle_base', label = _U('component_knuckle_base'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_BASE"), point = 250},
            {name = 'knuckle_pimp', label = _U('component_knuckle_pimp'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_PIMP"), point = 250},
            {name = 'knuckle_ballas', label = _U('component_knuckle_ballas'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_BALLAS"), point = 250},
            {name = 'knuckle_dollar', label = _U('component_knuckle_dollar'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_DOLLAR"), point = 250},
            {name = 'knuckle_diamond', label = _U('component_knuckle_diamond'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_DIAMOND"), point = 250},
            {name = 'knuckle_hate', label = _U('component_knuckle_hate'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_HATE"), point = 250},
            {name = 'knuckle_love', label = _U('component_knuckle_love'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_LOVE"), point = 250},
            {name = 'knuckle_player', label = _U('component_knuckle_player'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_PLAYER"), point = 250},
            {name = 'knuckle_king', label = _U('component_knuckle_king'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_KING"), point = 250},
            {name = 'knuckle_vagos', label = _U('component_knuckle_vagos'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_VAGOS"), point = 250}
        }
    },
    {name = 'WEAPON_BOTTLE', label = _U('weapon_bottle'), components = {}},
    {name = 'WEAPON_CROWBAR', label = _U('weapon_crowbar'), components = {}},
    {name = 'WEAPON_FLASHLIGHT', label = _U('weapon_flashlight'), components = {}},
    {name = 'WEAPON_GOLFCLUB', label = _U('weapon_golfclub'), components = {}},
    {name = 'WEAPON_HAMMER', label = _U('weapon_hammer'), components = {}},
    {name = 'WEAPON_HATCHET', label = _U('weapon_hatchet'), components = {}},
    {name = 'WEAPON_KNIFE', label = _U('weapon_knife'), components = {}},
    {name = 'WEAPON_MACHETE', label = _U('weapon_machete'), components = {}},
    {name = 'WEAPON_NIGHTSTICK', label = _U('weapon_nightstick'), components = {}},
    {name = 'WEAPON_WRENCH', label = _U('weapon_wrench'), components = {}},
    {name = 'WEAPON_POOLCUE', label = _U('weapon_poolcue'), components = {}},
    {name = 'WEAPON_STONE_HATCHET', label = _U('weapon_stone_hatchet'), components = {}},
    {
        name = 'WEAPON_SWITCHBLADE',
        label = _U('weapon_switchblade'),
        components = {
            {name = 'handle_default', label = _U('component_handle_default'), hash = Hash("COMPONENT_SWITCHBLADE_VARMOD_BASE"), point = 250},
            {name = 'handle_vip', label = _U('component_handle_vip'), hash = Hash("COMPONENT_SWITCHBLADE_VARMOD_VAR1"), point = 250},
            {name = 'handle_bodyguard', label = _U('component_handle_bodyguard'), hash = Hash("COMPONENT_SWITCHBLADE_VARMOD_VAR2"), point = 250}
        }
    },
    -- Handguns
    {
        name = 'WEAPON_APPISTOL',
        label = _U('weapon_appistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_APPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_APPISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_APPISTOL_VARMOD_LUXE"), point = 250}
        }
    },
    {name = 'WEAPON_CERAMICPISTOL', label = _U('weapon_ceramicpistol'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {
        name = 'WEAPON_COMBATPISTOL',
        label = _U('weapon_combatpistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATPISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {name = 'WEAPON_DOUBLEACTION', label = _U('weapon_doubleaction'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {name = 'WEAPON_NAVYREVOLVER', label = _U('weapon_navyrevolver'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {name = 'WEAPON_FLAREGUN', label = _U('weapon_flaregun'), tints = tints, components = {}, ammo = {label = _U('ammo_flaregun'), hash = Hash("AMMO_FLAREGUN")}},
    {name = 'WEAPON_GADGETPISTOL', label = _U('weapon_gadgetpistol'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {
        name = 'WEAPON_HEAVYPISTOL',
        label = _U('weapon_heavypistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_HEAVYPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_HEAVYPISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_REVOLVER',
        label = _U('weapon_revolver'),
        ammo = {label = _U('ammo_rounds'),hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_REVOLVER_CLIP_01"), point = 250},
            {name = 'vip_finish', label = _U('component_vip_finish'), hash = Hash("COMPONENT_REVOLVER_VARMOD_BOSS"), point = 250},
            {name = 'bodyguard_finish', label = _U('component_bodyguard_finish'), hash = Hash("COMPONENT_REVOLVER_VARMOD_GOON"), point = 250}
        }
    },
    {
        name = 'WEAPON_REVOLVER_MK2',
        label = _U('weapon_revolver_mk2'),
        ammo = {label = _U('ammo_rounds'),hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_01"), point = 250},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'compensator', label = _U('component_compensator'), hash = Hash("COMPONENT_AT_PI_COMP_03"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {name = 'WEAPON_MARKSMANPISTOL', label = _U('weapon_marksmanpistol'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {
        name = 'WEAPON_PISTOL',
        label = _U('weapon_pistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_PISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_PISTOL_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_PISTOL_MK2',
        label = _U('weapon_pistol_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_02"), point = 500},
            -- {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_TRACER"), point = 250},
            -- {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_INCENDIARY"), point = 250},
            -- {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT"), point = 250},
            -- {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_PI_RAIL"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH_02"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP_02"), point = 250},
            -- {name = 'compensator', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_COMP"), point = 250},
            -- {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO"), point = 250},
            -- {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_02"), point = 250},
            -- {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_03"), point = 250},
            -- {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_04"), point = 250},
            -- {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_05"), point = 250},
            -- {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_06"), point = 250},
            -- {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_07"), point = 250},
            -- {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_08"), point = 250},
            -- {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_09"), point = 250},
            -- {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_10"), point = 250},
            -- {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_IND_01"), point = 250},
            -- {name = 'camo_slide_finish', label = _U('component_camo_slide_finish'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish2', label = _U('component_camo_slide_finish2'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_02_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish3', label = _U('component_camo_slide_finish3'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_03_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish4', label = _U('component_camo_slide_finish4'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_04_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish5', label = _U('component_camo_slide_finish5'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_05_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish6', label = _U('component_camo_slide_finish6'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_06_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish7', label = _U('component_camo_slide_finish7'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_07_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish8', label = _U('component_camo_slide_finish8'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_08_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish9', label = _U('component_camo_slide_finish9'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_09_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish10', label = _U('component_camo_slide_finish10'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_10_SLIDE"), point = 250},
            -- {name = 'camo_slide_finish11', label = _U('component_camo_slide_finish11'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_IND_01_SLIDE"), point = 250}
        }
    },
    {
        name = 'WEAPON_PISTOL50',
        label = _U('weapon_pistol50'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PISTOL50_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_PISTOL50_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_PISTOL50_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_SNSPISTOL',
        label = _U('weapon_snspistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SNSPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SNSPISTOL_CLIP_02"), point = 500},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_SNSPISTOL_MK2',
        label = _U('weapon_snspistol_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_PI_RAIL_02"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH_03"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP_02"), point = 250},
            {name = 'compensator', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_COMP_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_IND_01"), point = 250},
            {name = 'camo_slide_finish', label = _U('component_camo_slide_finish'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_SLIDE"), point = 250},
            {name = 'camo_slide_finish2', label = _U('component_camo_slide_finish2'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_02_SLIDE"), point = 250},
            {name = 'camo_slide_finish3', label = _U('component_camo_slide_finish3'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_03_SLIDE"), point = 250},
            {name = 'camo_slide_finish4', label = _U('component_camo_slide_finish4'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_04_SLIDE"), point = 250},
            {name = 'camo_slide_finish5', label = _U('component_camo_slide_finish5'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_05_SLIDE"), point = 250},
            {name = 'camo_slide_finish6', label = _U('component_camo_slide_finish6'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_06_SLIDE"), point = 250},
            {name = 'camo_slide_finish7', label = _U('component_camo_slide_finish7'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_07_SLIDE"), point = 250},
            {name = 'camo_slide_finish8', label = _U('component_camo_slide_finish8'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_08_SLIDE"), point = 250},
            {name = 'camo_slide_finish9', label = _U('component_camo_slide_finish9'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_09_SLIDE"), point = 250},
            {name = 'camo_slide_finish10', label = _U('component_camo_slide_finish10'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_10_SLIDE"), point = 250},
            {name = 'camo_slide_finish11', label = _U('component_camo_slide_finish11'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE"), point = 250}
        }
    },
    {name = 'WEAPON_STUNGUN', label = _U('weapon_stungun'), tints = tints, components = {}},
    {name = 'WEAPON_RAYPISTOL', label = _U('weapon_raypistol'), tints = tints, components = {}},
    {
        name = 'WEAPON_VINTAGEPISTOL',
        label = _U('weapon_vintagepistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_VINTAGEPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_VINTAGEPISTOL_CLIP_02"), point = 500},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250}
        }
    },
    -- Shotguns
    {
        name = 'WEAPON_ASSAULTSHOTGUN',
        label = _U('weapon_assaultshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTSHOTGUN_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTSHOTGUN_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250}
        }
    },
    {name = 'WEAPON_AUTOSHOTGUN', label = _U('weapon_autoshotgun'), tints = tints, components = {}, ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")}},
    {
        name = 'WEAPON_BULLPUPSHOTGUN',
        label = _U('weapon_bullpupshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATSHOTGUN',
        label = _U('weapon_combatshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250}
        }
    },
    {name = 'WEAPON_DBSHOTGUN', label = _U('weapon_dbshotgun'), tints = tints, components = {}, ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")}},
    {
        name = 'WEAPON_HEAVYSHOTGUN',
        label = _U('weapon_heavyshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_HEAVYSHOTGUN_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_HEAVYSHOTGUN_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_HEAVYSHOTGUN_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250}
        }
    },
    {name = 'WEAPON_MUSKET', label = _U('weapon_musket'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SHOTGUN")}},
    {
        name = 'WEAPON_PUMPSHOTGUN',
        label = _U('weapon_pumpshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_SR_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_PUMPSHOTGUN_MK2',
        label = _U('weapon_pumpshotgun_mk2'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'shells_default', label = _U('component_shells_default'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_01"), point = 250},
            {name = 'shells_incendiary', label = _U('component_shells_incendiary'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'shells_armor', label = _U('component_shells_armor'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'shells_hollowpoint', label = _U('component_shells_hollowpoint'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'shells_explosive', label = _U('component_shells_explosive'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_MK2"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_SR_SUPP_03"), point = 250},
            {name = 'muzzle_squared', label = _U('component_muzzle_squared'), hash = Hash("COMPONENT_AT_MUZZLE_08"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_SAWNOFFSHOTGUN',
        label = _U('weapon_sawnoffshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE"), point = 250}
        }
    },
    -- SMG & LMG
    {
        name = 'WEAPON_ASSAULTSMG',
        label = _U('weapon_assaultsmg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTSMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTSMG_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATMG',
        label = _U('weapon_combatmg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATMG_CLIP_02"), point = 500},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_COMBATMG_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATMG_MK2',
        label = _U('weapon_combatmg_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_FMJ"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_MG_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_MG_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATPDW',
        label = _U('weapon_combatpdw'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATPDW_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATPDW_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_COMBATPDW_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250}
        }
    },
    {
        name = 'WEAPON_GUSENBERG',
        label = _U('weapon_gusenberg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_GUSENBERG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_GUSENBERG_CLIP_02"), point = 750}
        }
    },
    {
        name = 'WEAPON_MACHINEPISTOL',
        label = _U('weapon_machinepistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MACHINEPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MACHINEPISTOL_CLIP_02"), point = 250},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_MACHINEPISTOL_CLIP_03"), point = 750},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250}
        }
    },
    {
        name = 'WEAPON_MG',
        label = _U('weapon_mg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MG_CLIP_02"), point = 500},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_MG_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_MICROSMG',
        label = _U('weapon_microsmg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MICROSMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MICROSMG_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_MICROSMG_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_MINISMG',
        label = _U('weapon_minismg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MINISMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MINISMG_CLIP_02"), point = 500}
        }
    },
    {
        name = 'WEAPON_SMG',
        label = _U('weapon_smg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SMG_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_SMG_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_02"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SMG_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_SMG_MK2',
        label = _U('weapon_smg_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SMG_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SMG_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_SMG_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_SMG_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_SMG_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_SMG_MK2_CLIP_FMJ"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS_SMG"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_SB_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_SB_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_SMG_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_SMG_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_SMG_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_SMG_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_SMG_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_SMG_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_SMG_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_SMG_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_SMG_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_SMG_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = ("COMPONENT_SMG_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {name = 'WEAPON_RAYCARBINE', label = _U('weapon_raycarbine'), ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")}, tints = tints, components = {}},
    -- Rifles
    {
        name = 'WEAPON_ADVANCEDRIFLE',
        label = _U('weapon_advancedrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ADVANCEDRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ADVANCEDRIFLE_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_ASSAULTRIFLE',
        label = _U('weapon_assaultrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTRIFLE_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_ASSAULTRIFLE_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_ASSAULTRIFLE_MK2',
        label = _U('weapon_assaultrifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_AR_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_AR_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_BULLPUPRIFLE',
        label = _U('weapon_bullpuprifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_BULLPUPRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_BULLPUPRIFLE_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_BULLPUPRIFLE_VARMOD_LOW"), point = 250}
        }
    },
    {
        name = 'WEAPON_BULLPUPRIFLE_MK2',
        label = _U('weapon_bullpuprifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_02_MK2"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_MK2"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_BP_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_BP_BARREL_02"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_CARBINERIFLE',
        label = _U('weapon_carbinerifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_CARBINERIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_CARBINERIFLE_CLIP_02"), point = 250},
            {name = 'clip_box', label = _U('component_clip_box'), hash = Hash("COMPONENT_CARBINERIFLE_CLIP_03"), point = 1000},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_CARBINERIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_CARBINERIFLE_MK2',
        label = _U('weapon_carbinerifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_CR_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_CR_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMPACTRIFLE',
        label = _U('weapon_compactrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMPACTRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMPACTRIFLE_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_COMPACTRIFLE_CLIP_03"), point = 750}
        }
    },
    {
        name = 'WEAPON_MILITARYRIFLE',
        label = _U('weapon_militaryrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MILITARYRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MILITARYRIFLE_CLIP_02"), point = 500},
            {name = 'ironsights', label = _U('component_ironsights'), hash = Hash("COMPONENT_MILITARYRIFLE_SIGHT_01"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250}
        }
    },
    {
        name = 'WEAPON_SPECIALCARBINE',
        label = _U('weapon_specialcarbine'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SPECIALCARBINE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SPECIALCARBINE_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_SPECIALCARBINE_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_SPECIALCARBINE_MK2',
        label = _U('weapon_specialcarbine_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_FMJ"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_SC_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_SC_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    -- Sniper
    {
        name = 'WEAPON_HEAVYSNIPER',
        label = _U('weapon_heavysniper'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_LARGE"), point = 250},
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = Hash("COMPONENT_AT_SCOPE_MAX"), point = 250}
        }
    },
    {
        name = 'WEAPON_HEAVYSNIPER_MK2',
        label = _U('weapon_heavysniper_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_02"), point = 500},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ"), point = 250},
            {name = 'ammo_explosive', label = _U('component_ammo_explosive'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE"), point = 250},
            {name = 'scope_zoom', label = _U('component_scope_zoom'), hash = Hash("COMPONENT_AT_SCOPE_LARGE_MK2"), point = 250},
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = Hash("COMPONENT_AT_SCOPE_MAX"), point = 250},
            {name = 'scope_nightvision', label = _U('component_scope_nightvision'), hash = Hash("COMPONENT_AT_SCOPE_NV"), point = 250},
            {name = 'scope_thermal', label = _U('component_scope_thermal'), hash = Hash("COMPONENT_AT_SCOPE_THERMAL"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_SR_SUPP_03"), point = 250},
            {name = 'muzzle_squared', label = _U('component_muzzle_squared'), hash = Hash("COMPONENT_AT_MUZZLE_08"), point = 250},
            {name = 'muzzle_bell', label = _U('component_muzzle_bell'), hash = Hash("COMPONENT_AT_MUZZLE_09"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_SR_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_SR_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_MARKSMANRIFLE',
        label = _U('weapon_marksmanrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MARKSMANRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MARKSMANRIFLE_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_MARKSMANRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_MARKSMANRIFLE_MK2',
        label = _U('weapon_marksmanrifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'scope_zoom', label = _U('component_scope_zoom'), hash = Hash("COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_MRFL_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_MRFL_BARREL_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_SNIPERRIFLE',
        label = _U('weapon_sniperrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_LARGE"), point = 250},
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = Hash("COMPONENT_AT_SCOPE_MAX"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SNIPERRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    -- Heavy / Launchers
    {name = 'WEAPON_COMPACTLAUNCHER', label = _U('weapon_compactlauncher'), tints = tints, components = {}, ammo = {label = _U('ammo_grenadelauncher'), hash = Hash("AMMO_GRENADELAUNCHER")}},
    {name = 'WEAPON_FIREWORK', label = _U('weapon_firework'), components = {}, ammo = {label = _U('ammo_firework'), hash = Hash("AMMO_FIREWORK")}},
    {name = 'WEAPON_GRENADELAUNCHER', label = _U('weapon_grenadelauncher'), tints = tints, components = {}, ammo = {label = _U('ammo_grenadelauncher'), hash = Hash("AMMO_GRENADELAUNCHER")}},
    {name = 'WEAPON_HOMINGLAUNCHER', label = _U('weapon_hominglauncher'), tints = tints, components = {}, ammo = {label = _U('ammo_rockets'), hash = Hash("AMMO_HOMINGLAUNCHER")}},
    {name = 'WEAPON_MINIGUN', label = _U('weapon_minigun'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MINIGUN")}},
    {name = 'WEAPON_RAILGUN', label = _U('weapon_railgun'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RAILGUN")}},
    {name = 'WEAPON_RPG', label = _U('weapon_rpg'), tints = tints, components = {}, ammo = {label = _U('ammo_rockets'), hash = Hash("AMMO_RPG")}},
    {name = 'WEAPON_RAYMINIGUN', label = _U('weapon_rayminigun'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MINIGUN")}},
    -- Thrown
    {name = 'WEAPON_BALL', label = _U('weapon_ball'), components = {}, ammo = {label = _U('ammo_ball'), hash = Hash("AMMO_BALL")}},
    {name = 'WEAPON_BZGAS', label = _U('weapon_bzgas'), components = {}, ammo = {label = _U('ammo_bzgas'), hash = Hash("AMMO_BZGAS")}},
    {name = 'WEAPON_FLARE', label = _U('weapon_flare'), components = {}, ammo = {label = _U('ammo_flare'), hash = Hash("AMMO_FLARE")}},
    {name = 'WEAPON_GRENADE', label = _U('weapon_grenade'), components = {}, ammo = {label = _U('ammo_grenade'), hash = Hash("AMMO_GRENADE")}},
    {name = 'WEAPON_PETROLCAN', label = _U('weapon_petrolcan'), components = {}, ammo = {label = _U('ammo_petrol'), hash = Hash("AMMO_PETROLCAN")}},
    {name = 'WEAPON_HAZARDCAN', label = _U('weapon_hazardcan'), components = {}, ammo = {label = _U('ammo_petrol'), hash = Hash("AMMO_PETROLCAN")}},
    {name = 'WEAPON_MOLOTOV', label = _U('weapon_molotov'), components = {}, ammo = {label = _U('ammo_molotov'), hash = Hash("AMMO_MOLOTOV")}},
    {name = 'WEAPON_PROXMINE', label = _U('weapon_proxmine'), components = {}, ammo = {label = _U('ammo_proxmine'), hash = Hash("AMMO_PROXMINE")}},
    {name = 'WEAPON_PIPEBOMB', label = _U('weapon_pipebomb'), components = {}, ammo = {label = _U('ammo_pipebomb'), hash = Hash("AMMO_PIPEBOMB")}},
    {name = 'WEAPON_SNOWBALL', label = _U('weapon_snowball'), components = {}, ammo = {label = _U('ammo_snowball'), hash = Hash("AMMO_SNOWBALL")}},
    {name = 'WEAPON_STICKYBOMB', label = _U('weapon_stickybomb'), components = {}, ammo = {label = _U('ammo_stickybomb'), hash = Hash("AMMO_STICKYBOMB")}},
    {name = 'WEAPON_SMOKEGRENADE', label = _U('weapon_smokegrenade'), components = {}, ammo = {label = _U('ammo_smokebomb'), hash = Hash("AMMO_SMOKEGRENADE")}},
    -- Tools
    {name = 'WEAPON_FIREEXTINGUISHER', label = _U('weapon_fireextinguisher'), components = {}, ammo = {label = _U('ammo_charge'), hash = Hash("AMMO_FIREEXTINGUISHER")}},
    {name = 'WEAPON_DIGISCANNER', label = _U('weapon_digiscanner'), components = {}},
    {name = 'GADGET_PARACHUTE', label = _U('gadget_parachute'), components = {}},
    {name = 'WEAPON_TACTICALRIFLE',label = _U('weapon_tactilerifle'),ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},tints = tints,
        components = {
                        {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_TACTICALRIFLE_CLIP_01")},
                        {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_TACTICALRIFLE_CLIP_02")},
                        {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH_REH")},
                        {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP")},
                        {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02")}
                }
    },
    {name = 'WEAPON_PRECISIONRIFLE', label = _U('weapon_precisionrifle'), ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")}, tints = tints,
                components = {
                        {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PRECISIONRIFLE_CLIP_01")},
                }
    },
    {name = 'WEAPON_PENETRATOR', label = _U('weapon_penetrator'), components = {}},	
    {name = 'WEAPON_THROWINGCHAIR', label = _U('weapon_throwingchair'), components = {}},
    {name = 'WEAPON_BIGHAMMER', label = _U('weapon_bighammer'), components = {}},
    {name = 'WEAPON_KATANA', label = _U('weapon_katana'), components = {}},

}

local function CustomPrice(weaponName, customHash)
    for _, v in pairs(WEAPON_CUSTOM_PRICE) do
        if (v.name == weaponName) then
            for _, custom in pairs(v.components) do
                if (GetHashKey(custom.name) == customHash) then
                    return custom
                end
            end
        end
    end
    return false;
end

RegisterNetEvent('tebex:on-process-checkout-weapon-custom')
AddEventHandler('tebex:on-process-checkout-weapon-custom', function(weaponName, customHash)
    local source = source;
    if (source) then
        local xPlayer = ESX.GetPlayerFromId(source)
        if (xPlayer) then
            local CUSTOM = CustomPrice(weaponName, customHash);
            if CUSTOM then 
                if (CUSTOM.point ~= nil) then
                    OnProcessCheckout(source, CUSTOM.point, string.format("%s - %s", weaponName, customHash), function()
                        xPlayer.addWeaponComponent(weaponName, CUSTOM.name)
                        xPlayer.showNotification('Vous avez acheté '..CUSTOM.label.. ' pour '..CUSTOM.point..' ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Coins')
                    end, function()
                        xPlayer.showNotification("Vous ne possédez pas les points nécessaires ("..CUSTOM.point.." Coins)")
                    end)
                end
            end
        end
    end
end)

-- ARMES

RegisterNetEvent('ewen:buyweapon')
AddEventHandler('ewen:buyweapon', function(weapon, price, label)
    xPlayer = ESX.GetPlayerFromId(source)
    OnProcessCheckout(xPlayer.source, SecurityWeapons[weapon].price, string.format("%s", label), function()
        xPlayer.addWeapon(SecurityWeapons[weapon].name, 250)
        SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter une ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] Coins', 56108)
        xPlayer.showNotification("Vous avez acheté : " .. SecurityWeapons[weapon].label .. " dans la boutique !")
    end, function()
        xPlayer.showNotification("Vous ne possédez pas les points nécessaires.")
        return
    end)
end)


-- CAISSE MYSTERE

local labeltype = nil

function random(x, y)
    local u = 0;
    u = u + 1
    if x ~= nil and y ~= nil then
        return math.floor(x + (math.random(math.randomseed(os.time() + u)) * 999999 % y))
    else
        return math.floor((math.random(math.randomseed(os.time() + u)) * 100))
    end
end
eBoutique = eBoutique or {};
eBoutique.Cache = eBoutique.Cache or {}
eBoutique.Cache.Case = eBoutique.Cache.Case or {}
function GenerateLootbox(source, box, list)
    local chance = math.random(7, 75)
    local gift = { category = 1, item = 1 }
    print(chance)

    local identifier = GetIdentifiers(source);
    if (eBoutique.Cache.Case[source] == nil) then
        eBoutique.Cache.Case[source] = {};
        if (eBoutique.Cache.Case[source][box] == nil) then
            eBoutique.Cache.Case[source][box] = {};
        end
    else
        eBoutique.Cache.Case[source] = {};
        if (eBoutique.Cache.Case[source][box] == nil) then
            eBoutique.Cache.Case[source][box] = {};
        else
            eBoutique.Cache.Case[source][box] = {};
        end
    end
    if chance >= 7 and chance <= 27 then
        local rand = random(1, #list[4])
        eBoutique.Cache.Case[source][box][4] = list[4][rand]
        gift.category = 4
        gift.item = list[4][rand]
    elseif chance >= 28 and chance <= 47 then
        local rand = random(1, #list[3])
        eBoutique.Cache.Case[source][box][3] = list[3][rand]
        gift.category = 3
        gift.item = list[3][rand]
    elseif chance >= 48 and chance <= 67 then
        local rand = random(1, #list[2])
        eBoutique.Cache.Case[source][box][2] = list[2][rand]
        gift.category = 2
        gift.item = list[2][rand]
    else
        local rand = random(1, #list[1])
        eBoutique.Cache.Case[source][box][1] = list[1][rand]
        gift.category = 1
        gift.item = list[1][rand]
    end
    local finalList = {}
    for _, category in pairs(list) do
        for _, item in pairs(category) do
            local result = { name = item, time = 150 }
            table.insert(finalList, result)
        end
    end
    table.insert(finalList, { name = gift.item, time = 5000 })
    return finalList, gift.item
end

function ILALARMEOUPAS(xPlayer, weapon)
    for i, v in pairs(xPlayer.loadout) do
        if (GetHashKey(v.name) == weapon) then
            return true;
        end
    end
    return false;
end

RegisterNetEvent('Valestia:process_checkout_case')
AddEventHandler('Valestia:process_checkout_case', function(type)
    local source = source;
    if (source) then
        local identifier = GetIdentifiers(source);
        local xPlayer = ESX.GetPlayerFromId(source)
        if (xPlayer) then
            if MysteryBox.ListBox[type] == nil then return end
            OnProcessCheckout(source, MysteryBox.ListBox[type].price, "Achat d'une caisse ("..MysteryBox.ListBox[type].label..')', function()
                SeaLogs('', "Boutique - Achat","**"..GetPlayerName(source).."** vient d'acheter : ***"..MysteryBox.ListBox[type].label.."***\n **License** : "..xPlayer.identifier, 56108)
                local lists, result = GenerateLootbox(source, type, MysteryBox.Box[type])
                local giveReward = {
                    ["Coins"] = function(_s, license, player)
                        local before, after = result:match("([^_]+)_([^_]+)")
                        local quantity = tonumber(after)
                        if (identifier['fivem']) then
                            local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                            LiteMySQL:Insert('tebex_players_wallet', {
                                identifiers = fivemid,
                                transaction = "Gain de Coins dans une Caisse Mystère ",
                                price = '0',
                                currency = 'Points',
                                points = quantity,
                            });
                        end
                    end,
                    ['custom'] = function() 
                        local before, after = result:match("([^_]+)_([^_]+)")
                        local quantity = tonumber(after)
                        xPlayer.addInventoryItem('jetoncustom', quantity)
                    end,
                    ['vehunique'] = function() 
                        SeaLogs('', "Boutique","**"..GetPlayerName(source).."** vient de gagner véhicule unique"..xPlayer.identifier, 56108)
                        xPlayer.showNotification('Faites un ticket boutique pour obtenir votre véhicule Unique')
                    end,
                    ["helico"] = function(_s, license, player)
                        local plate = CreateRandomPlateText()
                        local HashVeh = GetHashKey(result)
                        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE (`vehicle` LIKE @hash AND `type` = 'aircraft' AND `owner` = @owner) ", {
                            ['@owner'] = xPlayer.identifier,
                            ['@hash'] = '%'..HashVeh..'%'
                        }, function(resultVeh)
                            if resultVeh[1] then
                                xPlayer.showNotification('Vous aviez déjà le véhicule que vous avez gagner\nVotre caisse vous à été rembourser')
                                --xPlayer.addInventoryItem(type, 1)
                                local pointdepd = 0
                                if type == 'caisse_amateur' then
                                    pointdepd = 1500
                                elseif type == 'caisse_intermediaire' then
                                    pointdepd = 2000
                                elseif type == 'caisse_confirme' then
                                    pointdepd = 3500
                                elseif type == 'caisse_expert' then
                                    pointdepd = 4000
                                end
                                local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                                LiteMySQL:Insert('tebex_players_wallet', {
                                    identifiers = after,
                                    transaction = 'Remboursement Caisse',
                                    price = '0',
                                    currency = 'Box',
                                    points = pointdepd,
                                });
                            else
                                LiteMySQL:Insert('owned_vehicles', {
                                    owner = xPlayer.identifier,
                                    plate = plate,
                                    vehicle = json.encode({ model = HashVeh, plate = plate }),
                                    state = 1,
                                    stored = 1,
                                    type = 'aircraft',
                                    boutique = 1
                                })
                                ESX.GiveCarKey(xPlayer, plate);
                                LiteMySQL:Insert('open_car', {
                                    owner = xPlayer.identifier,
                                    plate = plate
                                });
                            end
                        end)
                    end,
                    ["vehicle"] = function(_s, license, player)
                        if result == 'mule' or result == 'BType2' or result == 'Tornado6' then 
                            local plate = CreateRandomPlateText()
                            LiteMySQL:Insert('owned_vehicles', {
                                owner = xPlayer.identifier,
                                plate = plate,
                                vehicle = json.encode({ model = GetHashKey(result), plate = plate }),
                                state = 1,
                                stored = 1,
                                type = 'car',
                            })
                            ESX.GiveCarKey(xPlayer, plate);
                            LiteMySQL:Insert('open_car', {
                                owner = xPlayer.identifier,
                                plate = plate
                            });
                        else
                            local HashVeh = GetHashKey(result)
                            local plate = CreateRandomPlateText()
                            MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE (`vehicle` LIKE @hash AND `type` = 'car' AND `owner` = @owner) ", {
                                ['@owner'] = xPlayer.identifier,
                                ['@hash'] = '%'..HashVeh..'%'
                            }, function(resultVeh)
                                if resultVeh[1] then
                                    xPlayer.showNotification('Vous aviez déjà le véhicule que vous avez gagner\nVotre caisse vous à été rembourser')
                                    --xPlayer.addInventoryItem(type, 1)
                                    local pointdepd = 0
                                    if type == 'caisse_amateur' then
                                        pointdepd = 1500
                                    elseif type == 'caisse_intermediaire' then
                                        pointdepd = 2000
                                    elseif type == 'caisse_confirme' then
                                        pointdepd = 3500
                                    elseif type == 'caisse_expert' then
                                        pointdepd = 4000
                                    end
                                    local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                                    LiteMySQL:Insert('tebex_players_wallet', {
                                        identifiers = after,
                                        transaction = 'Remboursement Caisse',
                                        price = '0',
                                        currency = 'Box',
                                        points = pointdepd,
                                    });
                                else
                                    LiteMySQL:Insert('owned_vehicles', {
                                        owner = xPlayer.identifier,
                                        plate = plate,
                                        vehicle = json.encode({ model = HashVeh, plate = plate }),
                                        state = 1,
                                        stored = 1,
                                        type = 'car',
                                        boutique = 1
                                    })
                                    ESX.GiveCarKey(xPlayer, plate);
                                    LiteMySQL:Insert('open_car', {
                                        owner = xPlayer.identifier,
                                        plate = plate
                                    });
                                end
                            end)
                        end
                    end,
                    ["weapon"] = function(_s, license, player)
                        if (ILALARMEOUPAS(xPlayer, GetHashKey(result))) then
                            xPlayer.showNotification('Vous aviez déjà l\'arme que vous avez gagner\nVotre caisse vous à été rembourser')
                            --xPlayer.addInventoryItem(type, 1)
                            local pointdepd = 0
                            if type == 'caisse_amateur' then
                                pointdepd = 1500
                            elseif type == 'caisse_intermediaire' then
                                pointdepd = 2000
                            elseif type == 'caisse_confirme' then
                                pointdepd = 3500
                            elseif type == 'caisse_expert' then
                                pointdepd = 4000
                            end
                            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                            LiteMySQL:Insert('tebex_players_wallet', {
                                identifiers = after,
                                transaction = 'Remboursement Caisse',
                                price = '0',
                                currency = 'Box',
                                points = pointdepd,
                            });
                        else
                            xPlayer.addWeapon(result, 12)
                        end
                    end,
                    ["money"] = function(_s, license, player)
                        local before, after = result:match("([^_]+)_([^_]+)")
                        local quantity = tonumber(after)
                        xPlayer.addAccountMoney('bank', quantity)
                    end
                }

                local r = MysteryBox.Recompense[result];
                if (r ~= nil) then
                    if (giveReward[r.type]) then
                        giveReward[r.type](source, identifier['license'], xPlayer);
                    end
                else
                    while r == nil do 
                        lists, result = GenerateLootbox(source, type, MysteryBox.Box[type])
                        r = MysteryBox.Recompense[result];
                        Wait(1000)
                    end
                end
                if (identifier['fivem']) then
                    local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                    LiteMySQL:Insert('tebex_players_wallet', {
                        identifiers = after,
                        transaction = r.message,
                        price = '0',
                        currency = 'Box',
                        points = 0,
                    });
                end
                TriggerClientEvent('ewen:caisseopenclientside', source, lists, result, r.message)
                SeaLogs('', "Boutique - Achat","**"..GetPlayerName(source).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
            end, function()
            end)
        end
    end
end)

function SeaLogs(webhook, name, message, color)
    local date = os.date('*t')
    local webhook = 'https://discord.com/api/webhooks/1226980104157138944/Uhdf3Jy0kp5g6K5lXGo6-xw1i8K2r18xRk_DhQXQb3i--xCnhIRs29Rdq6CZfJ_u3wWZ'
  
  if date.day < 10 then date.day = '0' .. tostring(date.day) end
  if date.month < 10 then date.month = '0' .. tostring(date.month) end
  if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
  if date.min < 10 then date.min = '0' .. tostring(date.min) end
  if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

  local time = '\nDate: **`' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. (date.hour) .. ':' .. date.min .. ':' .. date.sec .. '`**'

  local embeds = {
	  {
          ["title"]= message .. time,
		  ["type"]="rich",
		  ["color"] =color,
		  ["footer"]=  {
			  ["text"]= "Valestia Logs",
		 },
	  }
  }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('eBoutique:BuyVIP')
AddEventHandler('eBoutique:BuyVIP', function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if type == 'gold' then
        local identifier = GetIdentifiers(source);
        if (identifier['fivem']) then
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            local patate = 'Bonus Vip Gold'
            OnProcessCheckout(source, 1500, string.format("VIP GOLD 1 Mois"), function()
                ExecuteCommand('addVip '..xPlayer.source..' 2');
                ExecuteCommand('VipPoints2 '..xPlayer.source..' 500');
                xPlayer.showNotification("Vous avez acheté : VIP ~y~GOLD (1 mois) sur la boutique !")
                SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***VIP GOLD (1 mois)***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [1500] Coins', 56108)
            end, function()
                return
            end)
        end
    elseif type == 'diamond' then
        local identifier = GetIdentifiers(source);
        if (identifier['fivem']) then
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            OnProcessCheckout(source, 2250, string.format("VIP Diamond 1 Mois"), function()
                ExecuteCommand('addVip '..xPlayer.source..' 3');
                ExecuteCommand('VipPoints3 '..xPlayer.source..' 1000')
                xPlayer.showNotification("Vous avez acheté : VIP ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~DIAMOND (1 mois) sur la boutique !")
                SeaLogs('', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***VIP DIAMOND (1 mois)***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [2250] Coins', 56108)
            end, function()
                return
            end)
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

Citizen.CreateThread(function()
    Wait(2500)
    for k,v in pairs(MysteryBox.ListBox) do
        ESX.RegisterUsableItem(k, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            TriggerClientEvent('closeall', source)
            Wait(200)
            TriggerClientEvent('closeall', source)
            Wait(200)
            TriggerClientEvent('closeall', source)
            Wait(200)
            TriggerClientEvent('closeall', source)
            Wait(100)
            TriggerEvent('Valestia:process_checkout_case_item', source, k, MysteryBox.ListBox[k].label)
        end)
    end
end)

RegisterNetEvent('Valestia:process_checkout_case_item')
AddEventHandler('Valestia:process_checkout_case_item', function(src, type, label)
    if (src) then
        local identifier = GetIdentifiers(src);
        local xPlayer = ESX.GetPlayerFromId(src)
        if (xPlayer) then
            if MysteryBox.ListBox[type] == nil then return end
            if xPlayer.getInventoryItem(type).count >= 1 then
                xPlayer.removeInventoryItem(type, 1)
                SeaLogs('', "Boutique - Achat","**"..GetPlayerName(src).."** vient d'acheter : ***"..MysteryBox.ListBox[type].label.."***\n **License** : "..xPlayer.identifier, 56108)
                local lists, result = GenerateLootbox(src, type, MysteryBox.Box[type])
                local giveReward = {
                    ["Coins"] = function(_s, license, player)
                        local before, after = result:match("([^_]+)_([^_]+)")
                        local quantity = tonumber(after)
                        if (identifier['fivem']) then
                            local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                            LiteMySQL:Insert('tebex_players_wallet', {
                                identifiers = fivemid,
                                transaction = "Gain de Coins dans une Caisse Mystère ",
                                price = '0',
                                currency = 'Points',
                                points = quantity,
                            });
                        end
                    end,
                    ["helico"] = function(_s, license, player)
                        local plate = CreateRandomPlateText()
                        local HashVeh = GetHashKey(result)
                        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE (`vehicle` LIKE @hash AND `type` = 'aircraft' AND `owner` = @owner) ", {
                            ['@owner'] = xPlayer.identifier,
                            ['@hash'] = '%'..HashVeh..'%'
                        }, function(resultVeh)
                            if resultVeh[1] then
                                xPlayer.showNotification('Vous aviez déjà le véhicule que vous avez gagner\nUne caisse vous à été rembourser !')
                                --xPlayer.addInventoryItem(type, 1)
                                --print(type)
                                local prixsalepd = 0
                                local transactionpd = 'Remboursement caisse mystere'
                                if type == 'caisse_expert' then
                                    prixsalepd = 4000
                                    transactionpd = 'Remboursement (Caisse Expert)'
                                elseif type == 'caisse_confirme' then
                                    prixsalepd = 3500
                                    transactionpd = 'Remboursement (Caisse Confirmé)'
                                elseif type == 'caisse_intermediaire' then
                                    prixsalepd = 2000
                                    transactionpd = 'Remboursement (Caisse Intermediaire)'
                                else
                                    prixsalepd = 1500
                                    transactionpd = 'Remboursement (Caisse Amateur)'
                                end
    
                                local before, after = result:match("([^_]+)_([^_]+)")
                                if (identifier['fivem']) then
                                    local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                                    LiteMySQL:Insert('tebex_players_wallet', {
                                        identifiers = fivemid,
                                        transaction = transactionpd,
                                        price = '0',
                                        currency = 'Points',
                                        points = prixsalepd,
                                    });
                            else
                                LiteMySQL:Insert('owned_vehicles', {
                                    owner = xPlayer.identifier,
                                    plate = plate,
                                    vehicle = json.encode({ model = HashVeh, plate = plate }),
                                    state = 1,
                                    stored = 1,
                                    type = 'aircraft',
                                    boutique = 1
                                })
                                LiteMySQL:Insert('open_car', {
                                    owner = xPlayer.identifier,
                                    plate = plate
                                });
                            end
                        end
                        end)
                    end,
                    ['custom'] = function() 
                        local before, after = result:match("([^_]+)_([^_]+)")
                        local quantity = tonumber(after)
                        xPlayer.addInventoryItem('jetoncustom', quantity)
                    end,
                    ['vehunique'] = function() 
                        SeaLogs('', "Boutique","**"..GetPlayerName(source).."** vient de gagner véhicule unique"..xPlayer.identifier, 56108)
                        xPlayer.showNotification('Faites un ticket boutique pour obtenir votre véhicule Unique')
                    end,
                    ["vehicle"] = function(_s, license, player)
                        if result == 'mule' or result == 'BType2' or result == 'Tornado6' then 
                            local plate = CreateRandomPlateText()
                            LiteMySQL:Insert('owned_vehicles', {
                                owner = xPlayer.identifier,
                                plate = plate,
                                vehicle = json.encode({ model = GetHashKey(result), plate = plate }),
                                state = 1,
                                stored = 1,
                                type = 'car',
                            })
                            LiteMySQL:Insert('open_car', {
                                owner = xPlayer.identifier,
                                plate = plate
                            });
                        else
                            local HashVeh = GetHashKey(result)
                            local plate = CreateRandomPlateText()
                            MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE (`vehicle` LIKE @hash AND `type` = 'car' AND `owner` = @owner) ", {
                                ['@owner'] = xPlayer.identifier,
                                ['@hash'] = '%'..HashVeh..'%'
                            }, function(resultVeh)
                                if resultVeh[1] then
                                    xPlayer.showNotification('Vous aviez déjà le véhicule que vous avez gagner\nUne caisse vous à été rembourser !')
                                    --xPlayer.addInventoryItem(type, 1)
                                    --print(type)
                                    local prixsalepd = 0
                                    local transactionpd = 'Remboursement caisse mystere'
                                    if type == 'caisse_expert' then
                                        prixsalepd = 4000
                                        transactionpd = 'Remboursement (Caisse Expert)'
                                    elseif type == 'caisse_confirme' then
                                        prixsalepd = 3500
                                        transactionpd = 'Remboursement (Caisse Confirmé)'
                                    elseif type == 'caisse_intermediaire' then
                                        prixsalepd = 2000
                                        transactionpd = 'Remboursement (Caisse Intermediaire)'
                                    else
                                        prixsalepd = 1500
                                        transactionpd = 'Remboursement (Caisse Amateur)'
                                    end
        
                                    local before, after = result:match("([^_]+)_([^_]+)")
                                    if (identifier['fivem']) then
                                        local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                                        LiteMySQL:Insert('tebex_players_wallet', {
                                            identifiers = fivemid,
                                            transaction = transactionpd,
                                            price = '0',
                                            currency = 'Points',
                                            points = prixsalepd,
                                        });
                                else
                                    LiteMySQL:Insert('owned_vehicles', {
                                        owner = xPlayer.identifier,
                                        plate = plate,
                                        vehicle = json.encode({ model = HashVeh, plate = plate }),
                                        state = 1,
                                        stored = 1,
                                        type = 'car',
                                        boutique = 1
                                    })
                                    LiteMySQL:Insert('open_car', {
                                        owner = xPlayer.identifier,
                                        plate = plate
                                    });
                                end
                            end
                            end)
                        end
                    end,
                    ["weapon"] = function(_s, license, player)
                        if (ILALARMEOUPAS(xPlayer, GetHashKey(result))) then
                            xPlayer.showNotification('Vous aviez déjà l\'arme que vous avez gagner\nUne caisse vous à été rembourser !')
                            --xPlayer.addInventoryItem(type, 1)
                            local prixsalepd = 0
                            local transactionpd = 'Remboursement caisse mystere'
                            if type == 'caisse_expert' then
                                prixsalepd = 4000
                                transactionpd = 'Remboursement (Caisse Expert)'
                            elseif type == 'caisse_confirme' then
                                prixsalepd = 3500
                                transactionpd = 'Remboursement (Caisse Confirmé)'
                            elseif type == 'caisse_intermediaire' then
                                prixsalepd = 2000
                                transactionpd = 'Remboursement (Caisse Intermediaire)'
                            else
                                prixsalepd = 1500
                                transactionpd = 'Remboursement (Caisse Amateur)'
                            end

                            local before, after = result:match("([^_]+)_([^_]+)")
                            if (identifier['fivem']) then
                                local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                                LiteMySQL:Insert('tebex_players_wallet', {
                                    identifiers = fivemid,
                                    transaction = transactionpd,
                                    price = '0',
                                    currency = 'Points',
                                    points = prixsalepd,
                                });
                        else
                            xPlayer.addWeapon(result, 12)
                        end
                    end
                    end,
                    ["money"] = function(_s, license, player)
                        local before, after = result:match("([^_]+)_([^_]+)")
                        local quantity = tonumber(after)
                        xPlayer.addAccountMoney('bank', quantity)
                    end,
                }
                local r = MysteryBox.Recompense[result];
                if (r ~= nil) then
                    if (giveReward[r.type]) then
                        giveReward[r.type](source, identifier['license'], xPlayer);
                    end
                else
                    while r == nil do 
                        lists, result = GenerateLootbox(source, type, MysteryBox.Box[type])
                        r = MysteryBox.Recompense[result];
                        Wait(1000)
                    end
                end
                if (identifier['fivem']) then
                    local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                    LiteMySQL:Insert('tebex_players_wallet', {
                        identifiers = after,
                        transaction = r.message,
                        price = '0',
                        currency = 'Box',
                        points = 0,
                    });
                end
                TriggerClientEvent('ewen:caisseopenclientside', src, lists, result, r.message)
                SeaLogs('', "Boutique - Achat","**"..GetPlayerName(src).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
            end
        end
    end
end)

RegisterNetEvent('ewen:getFivemID',function()
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
        TriggerClientEvent('ewen:ReceiveFivemId', source, fivemid)
    end
end)

-- EWEN

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

ESX.RegisterUsableItem('jetoncustom', function(source)
    local veh = GetVehiclePedIsIn(GetPlayerPed(source), false)
    local xPlayer = ESX.GetPlayerFromId(source)
    if veh~= 0 then 
        xPlayer.removeInventoryItem('jetoncustom', 1)
        TriggerClientEvent('aBoutique:BuyCustomMaxClient', source)
    else
        xPlayer.showNotification('Vous devez être a l\'intérieur d\'un véhicule pour le customiser')
    end
end)

ESX.RegisterServerCallback('ewen:getHistory', function(source, callback)
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        local count, result = LiteMySQL:Select('tebex_players_wallet'):Where('identifiers', '=', after):Get();
        if (result ~= nil) then
            callback(result)
        else
            print('[Error] retrieve category is nil')
            callback({ })
        end
    end
end)