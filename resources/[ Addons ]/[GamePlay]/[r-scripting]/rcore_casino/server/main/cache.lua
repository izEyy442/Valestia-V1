Cache = {}
Cache.Settings = {}
Cache.PedNetIdCache = {}

-- MongoDB Select/Insert/Update
MongoDB = {}

-- Insert
function MongoDB:Insert(tableName, dbObject, onFinish)
    exports.mongodb:insertOne({
        collection = tableName,
        document = dbObject
    }, onFinish)
end

-- Update
function MongoDB:UpdateOne(tableName, whereObject, dbObject, callback)
    exports.mongodb:updateOne({
        collection = tableName,
        query = whereObject,
        update = {
            ["$set"] = dbObject
        }
    }, callback)
end

-- Select
function MongoDB:Select(tableName, whereObject)
    local promise = promise:new()
    local rows = {}
    local success = pcall(function()
        exports.mongodb:find({
            collection = tableName,
            query = whereObject
        }, function(success, result)
            if not success then
                promise:resolve(1)
                return
            end
            for i, document in ipairs(result) do
                table.insert(rows, document)
            end
            promise:resolve(1)
        end)
    end)

    if not success then
        promise:resolve(1)
    end

    Citizen.Await(promise)
    return rows
end

-- Select One
function MongoDB:SelectOne(tableName, whereObject)
    local data = MongoDB:Select(tableName, whereObject)
    if data and #data > 0 then
        return data[1]
    else
        return nil
    end
end

-- Delete
function MongoDB:Delete(tableName, whereObject, callback)
    exports.mongodb:delete({
        collection = tableName,
        query = whereObject
    }, callback)
end

-- ghmattimysql
if Config.Ghmattimysql then
    MySQL = {}
    MySQL.Sync = {}
    MySQL.Async = {}

    MySQL.Async.fetchAll = function(query, table_, cb)
        return exports['ghmattimysql']:execute(query, table_, cb)
    end

    MySQL.Sync.fetchAll = function(query, table_, cb)
        return exports['ghmattimysql']:executeSync(query, table_, cb)
    end

    MySQL.Async.execute = function(query, table_, cb)
        return exports['ghmattimysql']:execute(query, table_, cb)
    end

    MySQL.Sync.execute = function(query, table_, cb)
        return exports['ghmattimysql']:executeSync(query, table_, cb)
    end

    MySQL.Async.fetchScalar = function(query, table_, cb)
        return exports['ghmattimysql']:scalar(query, table_, cb)
    end

    MySQL.Sync.fetchScalar = function(query, table_, cb)
        return exports['ghmattimysql']:scalarSync(query, table_, cb)
    end
end

local function Mysql_InstallGrades()
    if Config.MongoDB then
        print("^1Auto-Install is only avaiable for Mysql. Get help.^7")
        return
    end
    local queries = {}
    local s = Config.JobName
    table.insert(queries, 'DELETE FROM job_grades WHERE job_name="' .. s .. '"')
    table.insert(queries, 'DELETE FROM jobs WHERE name="' .. s .. '"')
    table.insert(queries, 'INSERT IGNORE INTO jobs (name, label) VALUES ("' .. s .. '", "Casino");')
    table.insert(queries,
        'INSERT IGNORE INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES ("' .. s ..
            '", 0, "novice", "novice", 200, "{}", "{}");')
    table.insert(queries,
        'INSERT IGNORE INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES ("' .. s ..
            '", 1, "experienced", "experienced", 400, "{}", "{}");')
    table.insert(queries,
        'INSERT IGNORE INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES ("' .. s ..
            '", 2, "boss", "boss", 600, "{}", "{}");')
    for k, v in pairs(queries) do
        MySQL.Sync.execute(v)
    end
end

local function Mysql_InstallItems()
    if Config.MongoDB then
        print("^1Auto-Install is only avaiable for Mysql. Get help.^7")
        return
    end
    local queries = {}
    local invItems = {
        ["casino_beer"] = "Casino\\'s Beer",
        ["casino_burger"] = "Casino\\'s Burger",
        [Config.ChipsInventoryItem] = "Casino\\'s Chips",
        ["casino_coffee"] = "Casino\\'s Coffee",
        ["casino_coke"] = "Casino\\'s Coke",
        ["casino_donut"] = "Casino\\'s Donut",
        ["casino_ego_chaser"] = "Casino\\'s Ego Chaser",
        ["casino_luckypotion"] = "Casino\\'s Potion",
        ["casino_psqs"] = "Casino\\'s PsQs",
        ["casino_sandwitch"] = "Casino\\'s Sandwitch",
        ["casino_sprite"] = "Casino\\'s Sprite"
    }
    table.insert(queries, 'DELETE FROM items WHERE `name` LIKE \'casino_%\'')
    for k, v in pairs(invItems) do
        table.insert(queries, "INSERT INTO `items` (`name`, `label`, `rare`, `can_remove`) VALUES ('" .. k .. "', '" ..
            v .. "', 0, 1);")
    end

    local hasWeight = MySQL.Sync.fetchAll('SHOW COLUMNS FROM `items` LIKE \'weight\';')

    if hasWeight and #hasWeight == 1 then
        table.insert(queries, 'UPDATE items SET weight=0 WHERE `name` LIKE \'casino_%\'')
    end

    for k, v in pairs(queries) do
        MySQL.Sync.execute(v)
    end
end

local function Mysql_InstallSettings()
    local stockVehicle =
        [[ {"modTrunk":-1,"modSuspension":-1,"podiumName":"SHEAVA","modFrontWheels":-1,"color1":111,"modSeats":-1,"modGrille":-1,"neonColor":[255,0,255],"modSmokeEnabled":1,"plateIndex":0,"bodyHealth":1,"modHydrolic":-1,"modSpoilers":3,"pearlescentColor":111,"modRightFender":-1,"modBrakes":2,"windowTint":6,"modHorns":57,"wheels":5,"modRearBumper":0,"fuelLevel":1,"modAirFilter":-1,"dirtLevel":1,"modTrimB":-1,"modLivery":1,"wheelColor":111,"modHood":0,"modArmor":4,"modTransmission":2,"modPlateHolder":-1,"modSteeringWheel":-1,"modTank":-1,"modOrnaments":-1,"modXenon":1,"modSideSkirt":-1,"modWindows":-1,"modTurbo":1,"tankHealth":1,"tyreSmokeColor":[1,1,1],"modEngine":3,"modDial":-1,"modVanityPlate":-1,"modTrimA":-1,"modAerials":-1,"xenonColor":12,"modFrame":-1,"modDashboard":-1,"modExhaust":0,"modStruts":-1,"modSpeakers":-1,"modArchCover":-1,"modFrontBumper":1,"modEngineBlock":-1,"extras":{"1":false},"modRoof":2,"modAPlate":-1,"modDoorSpeaker":-1,"modShifterLeavers":-1,"neonEnabled":[false,false,false,false],"color2":111,"model":819197656,"modBackWheels":-1,"modFender":-1,"engineHealth":1} ]]
    Cache.Settings = {
        PodiumPriceProps = json.decode(stockVehicle)
    }
    local stockSettings = json.encode(Cache.Settings)
    local queries = {}
    table.insert(queries, 'DROP TABLE IF EXISTS `casino_settings`;')
    table.insert(queries, 'DROP TABLE IF EXISTS `casino_cache`;')
    table.insert(queries,
        'CREATE TABLE `casino_cache` (`ID` int(11) NOT NULL,`Settings` text COLLATE utf8mb4_slovak_ci NOT NULL);')
    table.insert(queries, 'INSERT INTO `casino_cache` (`ID`, `Settings`) VALUES(1, \'' .. stockSettings .. '\');')
    table.insert(queries, 'ALTER TABLE `casino_cache` ADD PRIMARY KEY (`ID`);')
    table.insert(queries, 'ALTER TABLE `casino_cache` MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;')
    for k, v in pairs(queries) do
        MySQL.Sync.execute(v)
    end
end

local function Mysql_Install()
    if Config.MongoDB then
        print("^1Auto-Install is only avaiable for Mysql. Get help.^7")
        return
    end
    local queries = {}
    table.insert(queries, 'DROP TABLE IF EXISTS `casino_players`;')
    table.insert(queries,
        'CREATE TABLE `casino_players` (`ID` int(11) NOT NULL, `identifier` varchar(128) NOT NULL, `properties` longtext NOT NULL );')
    table.insert(queries, 'ALTER TABLE `casino_players` ADD PRIMARY KEY (`ID`);')
    table.insert(queries, 'ALTER TABLE `casino_players` MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;')
    for k, v in pairs(queries) do
        MySQL.Sync.execute(v)
    end
end

-- cached players
local PlayerCache = {}
local PlayerState = {}

function Cache:RemovePlayerState(playerId)
    PlayerState[playerId] = nil
end

function Cache:GetPlayerState(playerId, stateKey, defaultValue)
    if not playerId or not stateKey then
        return defaultValue
    end
    if not PlayerState[playerId] or not PlayerState[playerId][stateKey] then
        return defaultValue
    end
    return PlayerState[playerId][stateKey]
end

function Cache:ClearPlayerState(playerId)
    PlayerState[playerId] = nil
end

function Cache:SetPlayerState(playerId, stateKey, stateValue)
    if not playerId or not stateKey then
        return
    end
    if PlayerState[playerId] == nil then
        PlayerState[playerId] = {}
    end
    PlayerState[playerId][stateKey] = stateValue
end

function Cache:IncrementPlayerState(playerId, stateKey, incrementValue)
    if not playerId or not stateKey then
        return
    end
    if PlayerState[playerId] == nil then
        PlayerState[playerId] = {}
    end
    if PlayerState[playerId][stateKey] == nil then
        PlayerState[playerId][stateKey] = incrementValue
    else
        PlayerState[playerId][stateKey] = PlayerState[playerId][stateKey] + incrementValue
    end
end

function Cache:PlayerToNet(playerId)
    if playerId == nil then
        return -1
    end
    return Cache.PedNetIdCache[playerId] and Cache.PedNetIdCache[playerId] or -1
end

function Cache:BlacklistContains(identifier)
    local bans = json.decode(Cache.Settings["bans"]) or {}
    for k, v in pairs(bans) do
        if v == identifier then
            return true
        end
    end
    return false
end

function Cache:BlacklistAdd(identifier)
    if Cache:BlacklistContains(identifier) then
        return false
    end
    local bans = json.decode(Cache.Settings["bans"]) or {}
    table.insert(bans, identifier)
    Cache:UpdateSetting("bans", json.encode(bans))
    return true
end

function Cache:BlacklistRemove(identifier)
    if not Cache:BlacklistContains(identifier) then
        return false
    end
    local bans = json.decode(Cache.Settings["bans"]) or {}
    for i = 1, #bans do
        if bans[i] == identifier then
            table.remove(bans, i)
            break
        end
    end
    Cache:UpdateSetting("bans", json.encode(bans))
    return true
end

function Cache:Get(identifier, onFinish, dontCreate)
    DebugStart("Cache:Get")
    if not identifier or identifier == -1 then
        onFinish(nil)
        return
    end
    -- check & return, if already cached
    if PlayerCache[identifier] then
        if onFinish then
            PlayerCache[identifier].activeTime = GetGameTimer()
            onFinish(PlayerCache[identifier])
        end
        return
    end

    -- don't create a new one, if not needed
    if dontCreate then
        onFinish(nil)
        return
    end

    if Config.MongoDB then
        -- fetch from MongoDB if not cached yet
        local row = MongoDB:SelectOne("casino_players", {
            identifier = identifier
        })
        if row then
            PlayerCache[identifier] = json.decode(row.properties)
            PlayerCache[identifier].activeTime = GetGameTimer()
            PlayerCache[identifier].lastSave = GetGameTimer()
        else
            PlayerCache[identifier] = {
                lastSave = GetGameTimer(),
                logins = 0,
                vipUntil = 0,
                firstTime = true,
                activeTime = GetGameTimer()
            }
        end

        if onFinish then
            onFinish(PlayerCache[identifier])
        end
    else
        -- fetch from MYSQL if not cached yet
        MySQL.Async.fetchAll('SELECT * FROM casino_players WHERE identifier = @id LIMIT 1', {
            ['@id'] = identifier
        }, function(result)
            if result[1] and result[1].properties then
                PlayerCache[identifier] = json.decode(result[1].properties)
                PlayerCache[identifier].activeTime = GetGameTimer()
                PlayerCache[identifier].lastSave = GetGameTimer()
            else
                -- create new prop object
                PlayerCache[identifier] = {
                    lastSave = GetGameTimer(),
                    logins = 0,
                    vipUntil = 0,
                    firstTime = true,
                    activeTime = GetGameTimer()
                }
            end

            if onFinish then
                onFinish(PlayerCache[identifier])
            end
        end)
    end
end

function Cache:GetNow(identifier, dontCreate)
    local result = nil
    local promise = promise:new()

    Cache:Get(identifier, function(p)
        result = p
        promise:resolve(result)
    end, dontCreate)

    Citizen.Await(promise)
    return result
end

function Cache:Save(identifier)
    DebugStart("Cache:Save")
    -- props for this player don't exist
    local cache = PlayerCache[identifier]
    if not cache then
        return
    end

    cache.lastSave = GetGameTimer()
    local props = json.encode(cache)

    if Config.MongoDB then
        -- MongoDB
        MongoDB:UpdateOne("casino_players", {
            identifier = identifier
        }, {
            properties = props
        }, function(success, updatedCount)
            if success and updatedCount == 0 then
                MongoDB:Insert("casino_players", {
                    identifier = identifier,
                    properties = props
                })
            end
        end)
    else
        -- Mysql
        local rowsChanged = MySQL.Sync.execute('UPDATE casino_players SET properties = @props WHERE identifier = @id', {
            ['@props'] = props,
            ['@id'] = identifier
        })
        if Config.Ghmattimysql then
            rowsChanged = rowsChanged.affectedRows or 0
        end
        if rowsChanged == 0 then
            MySQL.Sync.execute('INSERT INTO casino_players (identifier, properties) VALUES (@id, @props)', {
                ['@props'] = props,
                ['@id'] = identifier
            })
        end
    end
end

function Cache:AutoSave()
    DebugStart("Cache:AutoSave")
    local time = GetGameTimer()
    for k, v in pairs(PlayerCache) do
        local savedAgo = time - tonumber(v.lastSave)
        -- if player was saved long time ago
        if not v.lastSave or time - tonumber(v.lastSave) >= Config.CASINO_SAVE_TIMER then
            Cache:Save(k)
        end
    end
    Cache:RemoveOldCache()
end

function Cache:RemoveOldCache()
    DebugStart("Cache:RemoveOldCache")
    local timer = GetGameTimer()
    for k, v in pairs(PlayerCache) do
        if v.activeTime and (timer - v.activeTime) > 60000 * 60 then
            PlayerCache[k] = nil
        end
    end
end

function Cache:PlayerOwnsVehicle(identifier, plate)
    DebugStart("Cache:PlayerOwnsVehicle")
    local result = {}

    if Framework.Active == 4 then
        -- implement function that checks for car ownership
        return true
    end

    if Framework.Active == 3 then
        return true
    end

    if Config.MongoDB then
        -- MongoDB
        result = MongoDB:Select("player_vehicles", {
            citizenid = identifier,
            plate = plate
        })
    else
        -- Mysql
        if Framework.Active == 1 then
            result = MySQL.Sync.fetchAll(
                "SELECT * FROM owned_vehicles WHERE owner = @identifier AND (LOWER(plate) = LOWER(@plate) OR UPPER(plate) = UPPER(@plate) OR REPLACE(UPPER(plate), ' ', '') = REPLACE(LOWER(@plate), ' ', '') OR REPLACE(LOWER(plate), ' ', '') = REPLACE(UPPER(@plate), ' ', ''))",
                {
                    ['@identifier'] = identifier,
                    ['@plate'] = plate
                })
        elseif Framework.Active == 2 then
            result = MySQL.Sync.fetchAll("SELECT * FROM player_vehicles WHERE citizenid = @identifier AND (LOWER(plate) = LOWER(@plate) OR UPPER(plate) = UPPER(@plate) OR REPLACE(UPPER(plate), ' ', '') = REPLACE(LOWER(@plate), ' ', '') OR REPLACE(LOWER(plate), ' ', '') = REPLACE(UPPER(@plate), ' ', ''))", {
                ['@identifier'] = identifier,
                ['@plate'] = plate
            })
        end
    end

    return result and #result ~= 0
end

function Cache:LoadSettings()
    DebugStart("Cache:LoadSettings")
    if Config.MongoDB then
        local result = MongoDB:SelectOne("casino_cache", {})
        if result then
            Cache.Settings = result.Settings or {}
        else
            Cache.Settings = {
                PodiumPriceProps = {}
            }
        end
    else
        MySQL.Async.fetchAll('SELECT * FROM casino_cache LIMIT 1', nil, function(result)
            if result and #result >= 1 then
                if result[1].Settings ~= "" then
                    Cache.Settings = json.decode(result[1].Settings)
                else
                    Cache.Settings = {}
                end
            else
                print(
                    "^1Casino settings don't exist in your MYSQL database. It won't work without it. Trying to reinstall.^7")
                Mysql_InstallSettings()
            end
        end)
    end
end

function Cache:UpdateSetting(setting, settingContent)
    DebugStart("Cache:UpdateSetting")
    Cache.Settings[setting] = settingContent
    local settingsJson = json.encode(Cache.Settings)
    if Config.MongoDB then
        MongoDB:UpdateOne("casino_cache", {}, {
            ["Settings"] = settingsJson
        })
    else
        MySQL.Async.fetchAll('UPDATE casino_cache SET Settings = @settings', {
            ['@settings'] = settingsJson
        }, function(result)
            Cache:LoadSettings()
        end)
    end
end

function Cache:GiveVehicle(playerId, vehicleProps)
    DebugStart("Cache:GiveVehicle")

    -- engine fix?
    vehicleProps.engineHealth = 1000.0
    vehicleProps.bodyHealth = 1000.0
    vehicleProps.fuelLevel = 100.0

    vehicleProps.podiumName = vehicleProps.podiumName:lower()

    local p = ESX.GetPlayerFromId(playerId)

    if Framework.Active == 4 then
        -- implement function that gives player the podium vehicle
        -- ...
        return
    end

    if Framework.Active == 1 or Framework.Active == 2 then
        vehicleProps.plate = VehiclePlate().GeneratePlate()
        if vehicleProps.plate == nil then
            return
        end
    end

    if Config.MongoDB then
        MongoDB:Insert("player_vehicles", {
            citizenid = p.identifier,
            mods = json.encode(vehicleProps),
            state = 1,
            damages = "{}",
            body = 1000,
            engine = 1000,
            plate = vehicleProps.plate,
            hash = vehicleProps.model
        })
    else
        if Framework.Active == 1 then
            MySQL.Async.execute(
                'INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `stored`) VALUES (@owner, @plate, @vehicle, @stored)',
                {
                    ['@owner'] = p.identifier,
                    ['@plate'] = vehicleProps.plate,
                    ['@vehicle'] = json.encode(vehicleProps),
                    ['@stored'] = 1
                }, nil)
        elseif Framework.Active == 2 then
            MySQL.Async.execute(
                'INSERT INTO `player_vehicles` (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`, `state`) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @garage, @state)',
                {
                    ['@license'] = p.license,
                    ['@citizenid'] = p.identifier,
                    ['@vehicle'] = vehicleProps.podiumName,
                    ['@hash'] = vehicleProps.model,
                    ['@mods'] = json.encode(vehicleProps),
                    ['@plate'] = vehicleProps.plate,
                    ['@state'] = 1,
                    ['@garage'] = "motelgarage"
                }, nil)
        elseif Framework.Active == 3 then
            CreateThread(function()
                Wait(7000)
                -- spawn the vehicle, server side
                local tempVehicle = CreateVehicle(vehicleProps.model, 0, 0, 0, 0, true, true)
                while not DoesEntityExist(tempVehicle) do
                    Wait(0)
                end
                local vehicleType = GetVehicleType(tempVehicle)
                DeleteEntity(tempVehicle)
                local priceEntity = CreateVehicleServerSetter(vehicleProps.model, vehicleType, 915.544189, 52.596317,
                    80.465546, 147.50155639648)
                while not DoesEntityExist(priceEntity) do
                    Wait(0)
                end
                SetVehicleDoorsLocked(priceEntity, 2)
                local priceNet = NetworkGetNetworkIdFromEntity(priceEntity)
                TriggerClientEvent("Casino:StandaloneVehicleSpawned", playerId, priceNet, vehicleProps)
            end)
        end
    end
end

local function Framework_Check()
    -- check for inventory items
    if not Config.UseOnlyMoney then
        if Framework.Active == 1 then
            if ESX and ESX.GetItemLabel then
                local label = ESX.GetItemLabel(Config.ChipsInventoryItem)
                if not label then
                    print("^3[Casino][Warning] It looks like the '" .. Config.ChipsInventoryItem ..
                              "' inventory item doesn't exist! Import the included .sql file in your MYSQL database, or install the inventory items manually in your inventory system.^0")
                end
            end
        elseif Framework.Active == 2 then
            local invState = GetResourceState("qb-inventory")
            if (invState == "starting" or invState == "started") and ESX and ESX.QBCore and ESX.QBCore.Shared and
                ESX.QBCore.Shared.Items and not ESX.QBCore.Shared.Items[Config.ChipsInventoryItem] then
                print("^3[Casino][Warning] It looks like the '" .. Config.ChipsInventoryItem ..
                          "' inventory item doesn't exist! Please follow the installation instructions at https://documentation.rcore.cz/paid-resources/rcore_casino/installing-on-qbcore^0")
            end
        end
    end
    -- replace "society_casino" to "casino" for SocietyName, if "casino" exists
    if Framework.Active == 2 and Config.SocietyName == "society_casino" and Config.EnableSociety then
        local mState = GetResourceState("qb-management")
        if (mState == "starting" or mState == "started") and ESX and ESX.QBCore and ESX.QBCore.Shared and
            ESX.QBCore.Shared.Jobs and not ESX.QBCore.Shared.Jobs["society_casino"] and ESX.QBCore.Shared.Jobs["casino"] then
            print(
                "^3[Casino][Warning] It looks like the society 'society_casino' doesn't exist, but society 'casino' does, changing Config.SocietyName to 'casino' in config.lua^0")
            Config.SocietyName = "casino"
        end
    end
end

local function Mysql_Check()
    if Config.MongoDB then
        return
    end
    local s = Config.JobName
    local result = MySQL.Sync.fetchAll('SHOW TABLES LIKE "casino_players";', {})
    if result and #result == 0 then
        print("Casino Mysql isn't created yet. Creating now.")
        Mysql_Install()
    end
    result = MySQL.Sync.fetchAll('SHOW TABLES LIKE "casino_cache";', {})
    if result and #result == 0 then
        print("Casino Cache Mysql isn't created yet. Creating now.")
        Mysql_InstallSettings()
    end
    if Framework.Active == 1 and Config.EnableSociety then
        result = MySQL.Sync.fetchAll('SELECT * from addon_account where name=@name;', {
            ["@name"] = Config.SocietyName
        })
        if result and #result == 0 then
            MySQL.Sync.execute('INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES (@name, @name, \'1\')', {
                ["@name"] = Config.SocietyName
            })
            print(string.format(
                "^1[%s][Warning!]^7 Society ^1'%s'^7 has been created in mysql! The server needs to be restarted in order to work properly!",
                GetCurrentResourceName(), Config.SocietyName))
        end
    end
end

local function Society_Check()
    local s = Config.SocietyName
    if Framework.Active == 1 then
        local result = MySQL.Sync.fetchAll('SELECT * FROM `addon_account` WHERE name = \'' .. s .. '\'')
        if result and #result ~= 1 then
            MySQL.Sync.execute(
                "INSERT IGNORE INTO `addon_account` (`name`, `label`, `shared`) VALUES ('" .. s .. "', '" .. s ..
                    "', '1');")
            print("Society account '" .. s .. "' was just created. Restart addonaccount or the server to make it work.")
        end
    end
end

local function Start()
    Mysql_Check()
    Cache:LoadSettings()
    CreateThread(function()
        Wait(1000)
        Framework_Check()
        if Config.EnableSociety then
            if Framework.Active == 1 then
                local esx_society = false
                -- wait for esx_society to start
                local t = GetGameTimer() + 10000
                while GetGameTimer() < t and not esx_society do
                    TriggerEvent("esx_society:getSocieties", function()
                        esx_society = true
                    end)
                    Wait(500)
                end
                Wait(100)
                if esx_society then
                    print(string.format("^3[%s][INFO]^7 Society ^3'%s'^7 registered.", GetCurrentResourceName(),
                        Config.SocietyName))
                else
                    print(string.format(
                        "^1[%s][ERROR] Looks like society option is enabled, but esx_society doesn't exist, or the resource was renamed.",
                        GetCurrentResourceName()))
                end
            end

            -- register society
            local j = Config.JobName
            local s = Config.SocietyName
            -- TriggerEvent('esx_society:registerSociety', s, 'Diamond Casino', s, s, s, { type = 'public' })
            TriggerEvent('esx_society:registerSociety', j, j, s, s, s, {
                type = 'private'
            })
            Wait(1000)
            CheckSociety()
        end
        Config.CASINO_SAVE_TIMER = Clamp(Config.CASINO_SAVE_TIMER, 1000, 1000 * 60 * 60)
        while true do
            Cache:AutoSave()
            Wait(Config.CASINO_SAVE_TIMER)
        end
    end, true)

end

if MySQL and MySQL.ready then
    MySQL.ready(function()
        Start()
    end)
else
    CreateThread(function()
        Wait(3000)
        Start()
    end)
end

RegisterCommand("casinoinstall", function(source, args, rawCommand)
    if source ~= 0 and not IsPlayerAdmin(source) then
        return
    end
    if Framework.Active ~= 1 then
        return
    end
    local installType = args[1]

    if installType == "job" then
        Mysql_InstallGrades()
    elseif installType == "items" then
        Mysql_InstallItems()
    elseif installType == "society" then
        Society_Check()
    else
        print("Wrong install type. Enter 'casinoinstall job/items/society'")
    end
end)

RegisterCommand("casinogivevehicle", function(source, args, rawCommand)
    if source ~= 0 and not IsPlayerAdmin(source) then
        return
    end
    local playerId = args[1]
    if not playerId or not tonumber(playerId) then
        print("usage: /casinogivevehicle PLAYERID")
        return
    end
    local podiumProps = Cache.Settings["PodiumPriceProps"]
    if (type(podiumProps) ~= "table") then
        podiumProps = json.decode(podiumProps)
    end
    Cache:GiveVehicle(tonumber(playerId), podiumProps)
end)

RegisterCommand("casinoban", function(source, args, rawCommand)
    if source ~= 0 and not IsPlayerAdmin(source) then
        return
    end
    local playerId = args[1]
    local id = nil
    if not playerId then
        print("usage: /casinoban PLAYERID or IDENTIFIER")
        return
    end
    if tonumber(playerId) then
        id = GetPlayerIdentifier(tonumber(playerId))
        if not id or id == -1 then
            print("player not connected")
            return
        end
    else
        id = playerId
    end
    if Cache:BlacklistAdd(id) then
        print(id .. " banned from casino.")
        if tonumber(playerId) then
            TriggerClientEvent("Casino:BouncerKicked", playerId)
        end
    else
        print(id .. " already banned.")
    end
end)

RegisterCommand("casinounban", function(source, args, rawCommand)
    if source ~= 0 and not IsPlayerAdmin(source) then
        return
    end
    local playerId = args[1]
    local id = nil
    if not playerId then
        print("usage: /casinounban PLAYERID or IDENTIFIER")
        return
    end
    if tonumber(playerId) then
        id = GetPlayerIdentifier(tonumber(playerId))
        if not id or id == -1 then
            print("player not connected")
            return
        end
    else
        id = playerId
    end
    if Cache:BlacklistRemove(id) then
        print(id .. " unbanned from casino.")
    else
        print(id .. " not banned.")
    end
end)
