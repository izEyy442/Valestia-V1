-- players inside casino
CasinoPlayers = {}
local CasinoPlayerCount = 0

-- cashiers
local Cashiers = {}

-- seating
local Seatings = {}

-- office chair
local OfficeChairUsed = false

-- jobs
local DigitalWallUsedTimes = 0
local ElectricityUsedTimes = 0

-- other
LUCKY_LEVEL = 0 -- 0 none, 1 lucky player, 2 lucky player & peds
DAY_OF_WEEK = 0 -- *fake* day of the week inside casino
FORCE_CLOSED = false
GetPlayerIdentifier_ = GetPlayerIdentifier

function GetServerTime()
    local currentTimestamp = os.time()
    local modifiedTimestamp = currentTimestamp + ((Config.ServerTimezoneOffsetHours or 0) * 60 * 60)
    return modifiedTimestamp
end

function GetPlayerIdentifierType(playerId, idType)
    for i = 0, 10, 1 do
        local idData = GetPlayerIdentifier_(playerId, i)
        if idData then
            if string.sub(idData, 1, #idType) == idType then
                return idData
            end
        end
    end
    return -1
end

function GetPlayerIdentifier(playerId)
    DebugStart("GetPlayerIdentifier")
    if Framework.Active == 3 then
        return GetPlayerIdentifierType(playerId, "fivem:")
    end
    local p = ESX.GetPlayerFromId(playerId)
    local id = p and p.identifier or -1
    if id == -1 then
        print("^1[Casino] Error finding player identifier of id: " .. tostring(playerId) .. "^7")
    end
    return id
end

-- get cashier instance from coords
local function GetCashierFromCoords(coords)
    if not coords then
        return nil
    end
    DebugStart("GetCashierFromCoords")
    for _, o in pairs(Cashiers) do
        if #(coords - o.coords) < 0.2 then
            return o
        end
    end
    return nil
end

local function GetOrCreateCashierInstance(coords)
    if not coords then
        return
    end
    DebugStart("GetOrCreateCashierInstance")
    local cashier = GetCashierFromCoords(coords)
    if not cashier then
        cashier = {}
        cashier.coords = coords
        cashier.playerId = -1
        table.insert(Cashiers, cashier)
    end
    return cashier
end

local function Cashier_Leave(playerId)
    DebugStart("Cashier_Leave")
    Cache:SetPlayerState(playerId, "Cashier", false)
    if Config.CASHIER_MULTITASK then
        return
    end
    for _, o in pairs(Cashiers) do
        if o.playerId and o.playerId == playerId then
            o.playerId = -1
            BroadcastCasino("Cashier:Quit", o.coords)
        end
    end
end

local function GetCasinoMoneyWithdrawPercentage()
    local moneyLimit = 100
    if Config.EnableSociety then
        local money = GetMoneyFromSociety()
        if money and money <= Config.SocietyLimitFromBalance then
            moneyLimit = Config.SocietyLimitPayoutPercentage
        end
    end
    return moneyLimit
end

local function Cashier_SendSessions(playerId)
    DebugStart("Cashier_SendSessions")
    TriggerClientEvent("Cashier:Sessions", playerId, Cashiers)
end

local function PlayerQuitSeating(playerId)
    DebugStart("PlayerQuitSeating")
    for k, v in pairs(Seatings) do
        if v == playerId then
            Seatings[k] = nil
            BroadcastCasino("Casino:QuitSeating", playerId, k)
            Cache:SetPlayerState(playerId, "Game", nil)
        end
    end
end

local function RecountCasinoPlayers()
    CasinoPlayerCount = tableLength(CasinoPlayers)
    if CasinoPlayerCount == 0 then
        DAY_OF_WEEK = Repeat(DAY_OF_WEEK + 1, 7)
    end
end

local function GetPlayerDailyWidthdrawLimitForToday(playerId)
    if not Config.DailyWidthdrawLimit or Config.DailyWidthdrawLimit <= 0 then
        return 2147483647
    end
    local withdrawLimit = Config.DailyWidthdrawLimit
    local playerIdentifier = GetPlayerIdentifier(playerId)
    local c = Cache:GetNow(playerIdentifier)
    if c then
        local today = os.date("%x", GetServerTime())
        if c.lastWithdraw and c.lastWithdraw == today then
            withdrawLimit = Config.DailyWidthdrawLimit - c.withdraw
        else
            withdrawLimit = Config.DailyWidthdrawLimit
        end
    end
    return withdrawLimit
end

RegisterNetEvent("Cashier:Use")
AddEventHandler("Cashier:Use", function(coords, usedBefore, isDrunk)
    local playerId = source

    if not coords then
        return
    end

    local cashier = GetOrCreateCashierInstance(coords)

    if not cashier then
        return
    end

    if cashier.playerId ~= -1 then
        return
    end

    if not Config.CASHIER_MULTITASK then
        cashier.playerId = playerId
    end

    Cache:SetPlayerState(playerId, "Cashier", true)

    local greetingsType = "WELCOME"
    if usedBefore then
        greetingsType = "WELCOME_BACK"
    end
    if isDrunk then
        greetingsType = "WELCOME_DRUNK"
    end

    local maxMoney = Config.EnableSociety and GetMoneyFromSociety() or 2147483647
    local moneyPercentage = GetCasinoMoneyWithdrawPercentage()
    local canPurchaseVIP = true

    -- daily withdraw
    local dailyWithdraw = GetPlayerDailyWidthdrawLimitForToday(playerId)
    if dailyWithdraw < maxMoney then
        maxMoney = dailyWithdraw
    end

    -- extra data
    local extraData = {}
    if Config.JobsEnabled then
        if IsPlayerAtJob(playerId, Config.Jobs.MONEYLOAD_STARTJOBNAME, nil, Config.Jobs.MONEYLOAD_STARTJOBGRADE,
            Config.Jobs.MONEYLOAD_STARTJOBGRADE) then
            -- player is allowed to request moneyload mission
            extraData.MoneyLoad = {
                missionActive = MoneyLoad.active == true,
                jobMembers = GetJobMembers(Config.Jobs.MONEYLOAD_WORKERJOBNAME, Config.Jobs.MONEYLOAD_WORKERJOBGRADE),
                memberNames = nil
            }
            for k, v in pairs(extraData.MoneyLoad.jobMembers) do
                if not extraData.MoneyLoad.memberNames then
                    extraData.MoneyLoad.memberNames = GetPlayerRealName(v)
                else
                    extraData.MoneyLoad.memberNames = extraData.MoneyLoad.memberNames .. ", " .. GetPlayerRealName(v)
                end
            end
        end
    end

    if Config.CASHIER_VIP_PASS_ITEM and Config.CASHIER_VIP_PASS_ITEM ~= "" and Config.CASHIER_VIP_PASS_ITEM ~= 0 then
        canPurchaseVIP = (GetPlayerCasinoItemCount(playerId, Config.CASHIER_VIP_PASS_ITEM) ~= 0)
    end
    if Config.CASHIER_MULTITASK then
        TriggerClientEvent("Cashier:Use", playerId, coords, playerId, greetingsType, moneyPercentage, canPurchaseVIP,
            maxMoney, extraData)
    else
        BroadcastCasino("Cashier:Use", coords, playerId, greetingsType, moneyPercentage, canPurchaseVIP, maxMoney,
            extraData)
    end
end)

RegisterNetEvent("Cashier:Quit")
AddEventHandler("Cashier:Quit", function()
    local playerId = source
    Cashier_Leave(playerId)
end)

RegisterNetEvent("Casino:UseSeating")
AddEventHandler("Casino:UseSeating", function(seatIndex)
    local playerId = source

    -- stop if already sitting
    for k, v in pairs(Seatings) do
        if v == playerId then
            return
        end
    end

    if not Seatings[seatIndex] then
        BroadcastCasino("Casino:UseSeating", playerId, seatIndex)
        Cache:SetPlayerState(playerId, "Game", {
            type = "Sitting",
            chair = seatIndex
        })
        Seatings[seatIndex] = playerId
    end
end)

RegisterNetEvent("Casino:QuitSeating")
AddEventHandler("Casino:QuitSeating", function()
    local playerId = source
    PlayerQuitSeating(playerId)
end)

RegisterNetEvent("CasinoOffice:EnterChair")
AddEventHandler("CasinoOffice:EnterChair", function(netId)
    local playerId = source
    if not OfficeChairUsed then
        OfficeChairUsed = playerId
        -- resave the current netId of the player's ped
        Cache.PedNetIdCache[playerId] = netId

        BroadcastCasino("CasinoOffice:EnterChair", OfficeChairUsed, netId)
    end
end)

RegisterNetEvent("CasinoOffice:LeaveChair")
AddEventHandler("CasinoOffice:LeaveChair", function()
    local playerId = source
    if OfficeChairUsed ~= playerId then
        return
    end
    OfficeChairUsed = false
    local netId = Cache:PlayerToNet(playerId)
    BroadcastCasino("CasinoOffice:LeaveChair", playerId, netId)
end)

RegisterNetEvent("CasinoOffice:ToggleComputer")
AddEventHandler("CasinoOffice:ToggleComputer", function(toggle)
    local playerId = source
    if OfficeChairUsed ~= playerId then
        return
    end
    local netId = Cache:PlayerToNet(playerId)
    BroadcastCasino("CasinoOffice:ToggleComputer", playerId, toggle, netId)
end)

-- get server time in ms
RegisterNetEvent("Casino:GetTime")
AddEventHandler("Casino:GetTime", function()
    local playerId = source
    TriggerClientEvent("Casino:GetTime", playerId, GetGameTimer())
end)

-- adds casino inventory item
function AddCasinoItem(playerId, item, count)
    DebugStart("AddCasinoItem")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.addInventoryItem(item, count)
    end
end

-- removes casino inventory item
function RemoveCasinoItem(playerId, item, count)
    DebugStart("RemoveCasinoItem")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local invCount = GetPlayerCasinoItemCount(playerId, item)
        if invCount < count then
            count = invCount
        end
        xPlayer.removeInventoryItem(item, count)
    end
end

-- get player casino inventory item count (chips, snacks...)
function GetPlayerCasinoItemCount(playerId, item)
    DebugStart("GetPlayerCasinoItemCount")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        -- QB/Standalone/Custom
        if Framework.Active ~= 1 then
            return xPlayer.getTotalAmount(item)
        end
        -- ESX
        local xItem = xPlayer.getInventoryItem(item)
        if xItem then
            return xItem.count
        end
    end
    return 0
end

-- gets player chips from DB
function GetPlayerChips(playerId)
    DebugStart("GetPlayerChips")
    if Config.UseOnlyMoney then
        return GetPlayerMoney(playerId)
    end
    return GetPlayerCasinoItemCount(playerId, Config.ChipsInventoryItem)
end

-- gets player money from DB
function GetPlayerMoney(playerId)
    DebugStart("GetPlayerMoney")
    if Config.MoneyInventoryItemName then
        return GetPlayerCasinoItemCount(playerId, Config.MoneyInventoryItemName)
    end
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local balance = -1
    if xPlayer then
        if Config.UseBankMoney then
            local account = xPlayer.getAccount("bank")
            if account then
                balance = account.money
            end
        else
            balance = xPlayer.getMoney()
        end
    end
    if type(balance) == 'table' and balance["money"] then
        balance = balance["money"]
    end

    return balance
end

-- add player money
function AddPlayerMoney(playerId, money, ignoreSociety)
    DebugStart("AddPlayerMoney")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        if Config.EnableSociety and not ignoreSociety then
            local societyBalance = GetMoneyFromSociety()
            if societyBalance < money then
                return false
            end
            RemoveMoneyFromSociety(money)
        end
        if Config.MoneyInventoryItemName then
            AddCasinoItem(playerId, Config.MoneyInventoryItemName, money)
        else
            if Config.UseBankMoney then
                xPlayer.addAccountMoney("bank", money)
            else
                xPlayer.addMoney(money)
            end
        end
        return true
    end
    return false
end

-- remove player money
function RemovePlayerMoney(playerId, money)
    DebugStart("RemovePlayerMoney")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        if Config.MoneyInventoryItemName then
            RemoveCasinoItem(playerId, Config.MoneyInventoryItemName, money)
        else
            if Config.UseBankMoney then
                xPlayer.removeAccountMoney("bank", money)
            else
                xPlayer.removeMoney(money)
            end
        end
        if Config.EnableSociety then
            GiveMoneyToSociety(money)
        end
    end
end

-- Is Player admin?
function IsPlayerAdmin(playerId)
    DebugStart("IsPlayerAdmin")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local group = xPlayer.getGroup()
        if type(group) == "table" then
            for k, v in pairs(group) do
                if AdminGroup[group] then
                    return true
                end
            end
            return IsPlayerAceAllowed(playerId, "admin")
        end
        if type(group) == "string" then
            return AdminGroup[group] ~= nil
        end
    end
    return false
end

-- check if player works at casino
function IsPlayerAtJob(playerId, job, GradeArray, MinGrade, MaxGrade)
    DebugStart("IsPlayerAtJob")
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if not xPlayer then
        return false
    end

    local xJob = xPlayer.getJob()
    if not xJob then
        return false
    end

    if not MaxGrade then
        MaxGrade = MinGrade
    end

    local gradeLevel = xJob.grade
    if not gradeLevel then
        gradeLevel = 0
    end

    if GradeArray == nil then
        return xJob.name == job and gradeLevel >= MinGrade and gradeLevel <= MaxGrade
    end
    return xJob.name == job and (GradeArray[xJob.grade_name] or (gradeLevel >= MinGrade and gradeLevel <= MaxGrade))
end

-- resend player their balance
function SendPlayerChipsBalance(playerId, playerChips)
    DebugStart("SendPlayerChipsBalance")
    TriggerClientEvent("Casino:GetChips", playerId, playerChips)
end

-- resend player their money
function SendPlayerMoneyBalance(playerId, playerMoney)
    DebugStart("SendPlayerMoneyBalance")
    TriggerClientEvent("Casino:GetMoney", playerId, playerMoney)
end

local function SendPlayerInventory(playerId)
    DebugStart("SendPlayerInventory")
    local items = {}
    local xPlayer = ESX.GetPlayerFromId(playerId)

    for k, v in pairs(CasinoInventoryItems) do
        if v.itemType == 1 then
            local key = v.key

            local item = xPlayer.getInventoryItem(key)
            local count = item and item.count or 0
            items[key] = count
        end
    end
    TriggerClientEvent("Casino:GetItems", playerId, items)
end

-- pay for spin/bet
function Pay(playerId, item, chips, game)
    DebugStart("Pay")
    if not ESX.GetPlayerFromId(playerId) then
        return -1
    end
    local playerChips = GetPlayerChips(playerId)

    if playerChips == nil then
        print("^1[Casino] Error getting chips of player " .. tostring(playerId) .. "^7")
    end
    -- if playerChips == nil then playerChips = 0 end

    if chips <= 0 or (playerChips - chips) < 0 then
        return -1
    end

    Debug("Player " .. playerId .. " paid " .. chips .. " for item '" .. item .. "' in game '" .. game .. "'")
    -- SetPlayerChips(playerId, playerChips - chips)
    if Config.UseOnlyMoney then
        RemovePlayerMoney(playerId, chips)
    else
        RemoveCasinoItem(playerId, Config.ChipsInventoryItem, chips)
    end

    if game ~= "Cashier" then
        local logMessage = "Paid for: " .. item .. " in " .. game
        AddLogEvent(playerId, logMessage, -chips, true)
    end

    Cache:IncrementPlayerState(playerId, "Score", -chips)
    return playerChips - chips
end

-- win price
function Win(playerId, item, chips, game)
    DebugStart("Win")
    if not ESX.GetPlayerFromId(playerId) then
        return
    end
    local playerChips = GetPlayerChips(playerId)
    local playerIdentifier = GetPlayerIdentifier(playerId)
    if playerChips == nil then
        print("^1[Casino] Error getting chips of player " .. tostring(playerId) .. ", Identifier: " ..
                  tostring(playerIdentifier) .. "^7")
    end

    Debug("Player " .. playerId .. " won " .. chips .. " from item '" .. item .. "' in game '" .. game .. "'")
    -- SetPlayerChips(playerId, playerChips + chips)
    if Config.UseOnlyMoney then
        if not AddPlayerMoney(playerId, chips) then
            print("^1[Casino] Casino couldn't pay player " .. tostring(playerId) ..
                      ", because there is not enough money in the society account! (" .. chips ..
                      "). Player identifier: " .. tostring(playerIdentifier) .. "^7")
        end
    else
        AddCasinoItem(playerId, Config.ChipsInventoryItem, chips)
    end

    if game ~= "Cashier" then
        local logMessage = "Won: " .. item .. " in " .. game
        AddLogEvent(playerId, logMessage, chips, true)
    end

    Cache:IncrementPlayerState(playerId, "Score", chips)
    return playerChips + chips
end

-- broadcast player at table
function BroadcastTable(casinoTable, command, ...)
    DebugStart("BroadcastTable")
    for i = 1, 4 do
        if casinoTable.chairs[i] ~= -1 then
            TriggerClientEvent(command, casinoTable.chairs[i], ...)
        end
    end
end

function BroadcastCasino(eventName, ...)
    for k, v in pairs(CasinoPlayers) do
        TriggerClientEvent(eventName, k, ...)
    end
end

local function LimitCashierRate(playerId)
    local lastTransactionTime = Cache:GetPlayerState(playerId, "CashierTime", 0)
    Cache:SetPlayerState(playerId, "CashierTime", GetGameTimer())

    if GetGameTimer() - lastTransactionTime < 1000 then
        local pname = GetPlayerName(playerId)
        local pid = GetPlayerIdentifier(playerId)
        print(('^1Player %s with id %i [%s] is calling Cashier events too fast.^7'):format(pname, playerId, pid))

        local cashierErrors = Cache:GetPlayerState(playerId, "CashierErrors", 0) + 1
        Cache:SetPlayerState(playerId, "CashierErrors", cashierErrors)
        -- ban if too many errors
        if cashierErrors == 3 then
            TriggerEvent("Casino:Anticheat:Ban", playerId, "Cashier")
        end
        return true
    end
    return false
end

local function GetMaxSocietyAndLimitMoneyAfterTradeForPlayer(playerId)
    -- refresh society money
    local maxMoney = Config.EnableSociety and GetMoneyFromSociety() or 2147483647
    local moneyPercentage = GetCasinoMoneyWithdrawPercentage()
    -- daily withdraw
    if Config.DailyWidthdrawLimit and Config.DailyWidthdrawLimit > 0 then
        local dailyWithdraw = GetPlayerDailyWidthdrawLimitForToday(playerId)
        if dailyWithdraw < maxMoney then
            maxMoney = dailyWithdraw
        end
    end
    return maxMoney
end

-- player wants to trade-in chips
RegisterNetEvent("Casino:TradeInChips")
AddEventHandler("Casino:TradeInChips", function(chips)
    local playerId = source
    local playerChips = GetPlayerChips(playerId)
    -- stop, if not using cashier
    if not Cache:GetPlayerState(playerId, "Cashier", false) then
        return
    end

    if LimitCashierRate(playerId) then
        return
    end

    chips = Clamp(chips, 0, playerChips)
    chips = math.round(chips / 10) * 10
    chips = math.floor(chips)

    local getMoneyPercentage = GetCasinoMoneyWithdrawPercentage()
    local originalChips = chips
    -- stop, if not enough in society
    if getMoneyPercentage <= 0 then
        return
    end

    local useDailyLimit = Config.DailyWidthdrawLimit and Config.DailyWidthdrawLimit > 0
    if useDailyLimit then
        local maxWithdraw = GetPlayerDailyWidthdrawLimitForToday(playerId)
        local realChips = math.ceil(chips * Config.ExchangeRate)
        local reducedMoney = math.floor((chips / 100) * getMoneyPercentage)
        if reducedMoney > maxWithdraw then
            return
        end
    end

    local tradedIn = false
    local paid = Pay(playerId, "Trade In Chips", chips, "Cashier")
    if paid and paid ~= -1 then
        chips = math.ceil(chips * Config.ExchangeRate)
        local reducedMoney = math.floor((chips / 100) * getMoneyPercentage)
        if AddPlayerMoney(playerId, reducedMoney) then
            tradedIn = true
            local playerIdentifier = GetPlayerIdentifier(playerId)
            local c = Cache:GetNow(playerIdentifier)
            -- save it in daily limit
            if useDailyLimit then
                if c then
                    local today = os.date("%x", GetServerTime())
                    if c.lastWithdraw and c.lastWithdraw == today then
                        c.withdraw = c.withdraw + reducedMoney
                    else
                        c.withdraw = reducedMoney
                    end
                    c.lastWithdraw = today
                end
            end
            local moneyNow = GetPlayerMoney(playerId)
            local percentageNow = GetCasinoMoneyWithdrawPercentage()
            local moneyLimitNow = GetMaxSocietyAndLimitMoneyAfterTradeForPlayer(playerId)
            TriggerClientEvent("Casino:TradeResults", playerId, paid, moneyNow, "TRANSACTION_EXCHANGE", percentageNow,
                moneyLimitNow, c)
            AddLogEvent(playerId, "Trade-In Chips", -chips, false)

        else
            -- couldn't add that much money (society?), returning chips
            AddCasinoItem(playerId, Config.ChipsInventoryItem, originalChips)
        end
    end

    if not tradedIn then
        local societyMoney = GetMoneyFromSociety()
        TriggerClientEvent("Casino:TradeResults", playerId, false, societyMoney)
    end
end)

-- player wants to acquire chips
RegisterNetEvent("Casino:AcquireChips")
AddEventHandler("Casino:AcquireChips", function(chips)
    local playerId = source
    -- stop, if not using cashier
    if not Cache:GetPlayerState(playerId, "Cashier", false) then
        return
    end

    if LimitCashierRate(playerId) then
        return
    end

    chips = math.round(chips / 10) * 10
    chips = math.floor(chips)

    local money = GetPlayerMoney(playerId)
    local chipsNow = GetPlayerChips(playerId)
    local realChipsValue = math.ceil(chips * Config.ExchangeRate)
    if money >= realChipsValue and chips >= 10 then
        chipsNow = Win(playerId, "Acquire Chips", chips, "Cashier")
        RemovePlayerMoney(playerId, realChipsValue)
        local percentageNow = GetCasinoMoneyWithdrawPercentage()
        local moneyLimitNow = GetMaxSocietyAndLimitMoneyAfterTradeForPlayer(playerId)
        local playerIdentifier = GetPlayerIdentifier(playerId)
        local c = Cache:GetNow(playerIdentifier)
        TriggerClientEvent("Casino:TradeResults", playerId, chipsNow, money - realChipsValue, "CASH_DESK_REQUEST_CHIPS",
            percentageNow, moneyLimitNow, c)
        AddLogEvent(playerId, "Acquire Chips", chips, false)
    else
        local societyMoney = GetMoneyFromSociety()
        TriggerClientEvent("Casino:TradeResults", playerId, -1, societyMoney)
    end
end)

-- player wants to refresh his balance
RegisterNetEvent("Casino:DailyBonus")
AddEventHandler("Casino:DailyBonus", function()
    local playerId = source
    local identifier = GetPlayerIdentifier(playerId)
    Cache:Get(identifier, function(p)
        if not p then
            return
        end
        local today = os.date("%x", GetServerTime())
        if p.lastDailyBonus and p.lastDailyBonus == today then
            return
        end
        p.lastDailyBonus = today

        local chipsNow = Win(playerId, "Daily Bonus", Config.CASHIER_DAILY_BONUS, "Cashier")
        local money = GetPlayerMoney(playerId)
        local percentageNow = GetCasinoMoneyWithdrawPercentage()
        local moneyLimitNow = GetMaxSocietyAndLimitMoneyAfterTradeForPlayer(playerId)
        TriggerClientEvent("Casino:TradeResults", playerId, chipsNow, money, "VICTIMIZED_REACT", percentageNow,
            moneyLimitNow, p)
    end)
end)

-- player wants to refresh his balance
RegisterNetEvent("Casino:BecomeVIP")
AddEventHandler("Casino:BecomeVIP", function()
    local playerId = source
    local identifier = GetPlayerIdentifier(playerId)

    local money = GetPlayerMoney(playerId)
    if money < Config.CASHIER_VIP_PRICE then
        return
    end

    Cache:Get(identifier, function(p)
        if not p then
            return
        end
        RemovePlayerMoney(playerId, Config.CASHIER_VIP_PRICE)
        if Config.CASHIER_VIP_PASS_ITEM and Config.CASHIER_VIP_PASS_ITEM ~= "" and Config.CASHIER_VIP_PASS_ITEM ~= 0 then
            -- RemoveCasinoItem(playerId, Config.CASHIER_VIP_PASS_ITEM, 1)
        end
        local vipUntil = GetServerTime() + (Config.CASHIER_VIP_DURATION or 2147483647)
        p.vipUntil = vipUntil
        BroadcastCasino("Casino:BecomeVIP", playerId, vipUntil)
    end)
end)

-- player wants to refresh his balance
RegisterNetEvent("Casino:GetChips")
AddEventHandler("Casino:GetChips", function()
    local playerId = source
    local playerChips = GetPlayerChips(playerId)
    SendPlayerChipsBalance(playerId, playerChips)
end)

-- player wants to refresh his money balance
RegisterNetEvent("Casino:GetMoney")
AddEventHandler("Casino:GetMoney", function()
    local playerId = source
    local playerMoney = GetPlayerMoney(playerId)
    SendPlayerMoneyBalance(playerId, playerMoney)
end)

-- player wants to refresh his balance
RegisterNetEvent("Casino:GetItems")
AddEventHandler("Casino:GetItems", function()
    local playerId = source
    SendPlayerInventory(playerId)
end)

RegisterNetEvent("Casino:SaveAmbientPeds")
AddEventHandler("Casino:SaveAmbientPeds", function(buffer)
    local playerId = source
    if not IsPlayerAdmin(playerId) then
        return
    end
    local fileNames = {"peddata.txt", "peddata_gabz.txt", "peddata_gabz.txt", "peddata_k4mb1.txt", "peddata_gtao.txt",
                       "0", "peddata_oldk4mb1.txt"}
    local fileName = fileNames[Config.MapType]
    if not fileName then
        return
    end
    local filePath = "client/interior/" .. fileName
    SaveResourceFile(GetCurrentResourceName(), filePath, buffer, #(buffer))
    print("Ambient peds saved.")
end)

-- replace the podium vehicle props
RegisterNetEvent("Casino:PodiumReplace")
AddEventHandler("Casino:PodiumReplace", function(vehicleModel, vehicleProps)
    local playerId = source
    local identifier = GetPlayerIdentifier(playerId)
    local error = -1

    local hasAbility = IsPlayerAtJob(playerId, Config.JobName, nil, 1, Config.BossGrade) or IsPlayerAdmin(playerId)
    if not hasAbility then
        error = 1
    end
    if hasAbility and Config.JOB_PODIUMCAR_OWNERSHIP_CHECK == true and
        not Cache:PlayerOwnsVehicle(identifier, vehicleProps.plate) then
        error = 2
    end
    TriggerClientEvent("Casino:PodiumReplace", playerId, error)
    if error == -1 then
        if Config.JOB_PODIUMCAR_OWNERSHIP_CHECK and Config.JOB_PODIUMCAR_OWNERSHIP_DELETE_ORIGINAL then
            if Config.MongoDB then
                MongoDB:Delete("player_vehicles", {
                    plate = vehicleProps.plate
                })
            else
                local vehTable = "owned_vehicles" -- ES
                if Framework.Active == 2 then -- QB
                    vehTable = "player_vehicles"
                end

                MySQL.Sync.execute("DELETE FROM " .. vehTable ..
                                       " WHERE (LOWER(plate) = LOWER(@plate) OR UPPER(plate) = UPPER(@plate) OR REPLACE(UPPER(plate), ' ', '') = REPLACE(LOWER(@plate), ' ', '') OR REPLACE(LOWER(plate), ' ', '') = REPLACE(UPPER(@plate), ' ', '')) LIMIT 1",
                    {
                        ['@plate'] = vehicleProps.plate
                    })
            end
        end

        vehicleProps.plate = nil
        vehicleProps.podiumName = vehicleModel
        Cache:UpdateSetting("PodiumPriceProps", json.encode(vehicleProps))
    end
end)

-- replace the podium vehicle props
RegisterNetEvent("Casino:PodiumRemove")
AddEventHandler("Casino:PodiumRemove", function()
    local playerId = source

    if not IsPlayerAtJob(playerId, Config.JobName, nil, Config.BossGrade) then
        return
    end

    Cache:UpdateSetting("PodiumPriceProps", "")
    BroadcastCasino("Casino:PodiumVehicleChanged", "")
end)

-- break electricity
function BreakCasinoElectricity()
    Cache.Settings["ElectricityBroken"] = true
    BroadcastCasino("Casino:ElectricityBroke")
end

function BreakCasinoWall()
    Cache.Settings["WallBroken"] = true
    BroadcastCasino("Casino:WallBroke")
end

-- player tells server he entered casino
function Casino_ResendPlayerProgress(playerId)
    DebugStart("Casino_ResendPlayerProgress")
    local identifier = GetPlayerIdentifier(playerId)
    Cache:Get(identifier, function(p)
        if not p then
            return
        end
        -- transfer old vips to new 
        if p.vip and not p.vipUntil then
            local vipUntil = GetServerTime() + Config.CASHIER_VIP_DURATION
            p.vipUntil = vipUntil
            p.vip = nil
        end

        local playerBalance = {
            money = GetPlayerMoney(playerId),
            chips = GetPlayerChips(playerId)
        }
        local playerAdmin = IsPlayerAdmin(playerId)
        local osTime = GetServerTime()
        TriggerClientEvent("Casino:Progress", playerId, playerBalance, osTime, os.date("%x", osTime), p, GameStates,
            playerAdmin)
        p.firstTime = false
        SendPlayerInventory(playerId)
    end)
end

-- player entered casino, send his progress & balance
RegisterNetEvent("Casino:Enter")
AddEventHandler("Casino:Enter", function()
    local playerId = source
    local stamp = {
        name = "Unnamed",
        identifier = "Unknown"
    }

    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        stamp.name = GetPlayerName(playerId)
        stamp.identifier = xPlayer.identifier
    end

    -- Jobs
    if Config.Jobs and Config.Jobs.Electrician.Enabled then
        if not Cache.Settings["WallBroken"] then
            DigitalWallUsedTimes = DigitalWallUsedTimes + 1
            if DigitalWallUsedTimes >= Config.Jobs.Electrician.Difficulty["FuseBox"].WallDurability then
                BreakCasinoWall()
            end
        end
        if not Cache.Settings["ElectricityBroken"] then
            ElectricityUsedTimes = ElectricityUsedTimes + 1
            if ElectricityUsedTimes >= Config.Jobs.Electrician.Difficulty["FuseBox"].ElectricityDurability then
                BreakCasinoElectricity()
            end
        end
    end

    CasinoPlayers[playerId] = stamp
    RecountCasinoPlayers()
    local identifier = GetPlayerIdentifier(playerId)
    Cache:SetPlayerState(playerId, "EnterTime", GetGameTimer())
    Cache:Get(identifier, function(p)
        if not p then
            return
        end
        p.logins = p.logins + 1
        Slots_SendSessions(playerId)
        LuckyWheel_SendState(playerId)
        DrinkingBar_SendSessions(playerId)
        Cashier_SendSessions(playerId)
        TriggerClientEvent("Casino:UsedSeatings", playerId, Seatings)
        Casino_ResendPlayerProgress(playerId)

        -- send interior properties (podium spinner car, etc..)
        local podiumProps = Cache.Settings["PodiumPriceProps"]
        local wallBroken = Cache.Settings["WallBroken"]
        local electricityBroken = Cache.Settings["ElectricityBroken"]
        local blacklisted = Cache:BlacklistContains(identifier)

        -- jobData
        local jobInfo = {}
        -- jobs
        if Config.Jobs then
            if Config.Jobs.Cleaner.Enabled then
                jobInfo.dirtySteps = Cleaner_GetDirtySteps()
            end
        end

        TriggerClientEvent("Casino:Interior", playerId, podiumProps, wallBroken, electricityBroken, blacklisted, jobInfo)
        TriggerEvent("PlayerJoinedCasino", playerId)
        AddLogEvent(playerId, "Entered Casino")
    end)
end)

function EndEverything(playerId)
    ScenePed_EndForPlayer(playerId)
    InsideTrack_PlayerDropped(playerId)
    LuckyWheel_PlayerDropped(playerId)
    Slots_PlayerDropped(playerId)
    DrinkingBar_PlayerDropped(playerId)
    Roulette_LeaveChair(playerId)
    Poker_LeaveChair(playerId)
    Blackjack_LeaveChair(playerId)
    Cashier_Leave(playerId)
    Cache:RemovePlayerState(playerId)
end

function PrintInfo()
    local mysqlRes = "mysql-async"
    if Config.MongoDB then
        mysqlRes = "mongoDB"
    elseif Config.Ghmattimysql then
        mysqlRes = "ghmattimysql"
    end
    local frameworks = {"ESX", "QB", "Standalone", "Custom"}
    local mapNames = {"DLCiplLoader", "Gabz Casino", "NoPixel Casino", "k4mb1", "GTA:O Interior"}
    local dateTime = os.date("%d.%m.%Y, %I:%M %p", GetServerTime())

    print("^3")
    print("rcore_casino")
    print(string.format("^7framework: ^3%s", frameworks[Framework.Active]))
    print(string.format("^7version: ^3%s", GetResourceMetadata(GetCurrentResourceName(), "version")))
    print(string.format("^7database: ^3%s", mysqlRes))
    print(string.format("^7map: ^3%s", mapNames[Config.MapType]))
    print(string.format("^7society: ^3%s", Config.SocietyName))
    print(string.format("^7casino time: ^3%s", dateTime))
    print("https://documentation.rcore.cz/paid-resources/rcore_casino")
    print("^7")
end

function CheckSociety()
    if not Config.EnableSociety then
        return
    end
    local checkDone = false
    CreateThread(function()
        GiveMoneyToSociety(1)
        Wait(500)
        if GetMoneyFromSociety() == 0 then
            print("^3Casino won't work unless you set up the society account.^7")
        else
            RemoveMoneyFromSociety(1)
        end
        checkDone = true
    end)
    CreateThread(function()
        Wait(3000)
        if not checkDone then
            print("")
            print("^1Error checking the society.^7")
            print("Please check file ^3/server/main/society.lua^7. You may have to change the event names.^7")
        end
    end)
end

function IsCasinoOpenAtCurrentTime()
    if FORCE_CLOSED then
        return false
    end
    if not Config.OpeningHours then
        return true
    end

    local osTime = GetServerTime()
    local currentDay = os.date("%w", osTime) + 1
    local currentHour = math.ceil(os.date("%H", osTime))

    local hours = Config.OpeningHours[currentDay]

    if not hours then
        return false
    end

    -- open all day
    if #hours == 1 and hours[1] == -1 then
        return true
    end

    for k, v in pairs(hours) do
        -- open at current hour
        if v == currentHour then
            return true
        end
    end

    return false
end

function GetCasinoNextOpenTime()
    if not Config.OpeningHours then
        return Translation.Get("OPENINGHOURS_OPEN")
    end

    local osTime = GetServerTime()
    local currentDay = os.date("%w", osTime) + 1
    local currentHour = math.ceil(os.date("%H", osTime))
    local inDays = 0

    function CasinoOpenSoon(cDay, cHour)
        local h = Config.OpeningHours[cDay]
        if not h then
            return false
        end
        local hF = false

        for k, v in pairs(h) do
            if v >= cHour then
                return v
            end
        end
        return false
    end

    local openSoon = CasinoOpenSoon(currentDay + 1, currentHour)

    for i = 1, 7 do
        local day = Repeat(currentDay, 7) + 1
        local hours = Config.OpeningHours[day]

        local openHour = hours and hours[1] or ""
        if openHour == -1 then
            openHour = "00"
        end

        if inDays == 0 and hours and openSoon then
            return string.format(Translation.Get("OPENINGHOURS_TODAY"), openSoon .. ":00")
        elseif inDays == 1 and hours then
            return string.format(Translation.Get("OPENINGHOURS_TOMORROW"), openHour .. ":00")
        elseif inDays > 1 and hours then
            return string.format(Translation.Get("OPENINGHOURS_INXDAYS"), inDays, openHour .. ":00")
        end

        inDays = inDays + 1
        currentDay = currentDay + 1
    end

    return Translation.Get("OPENINGHOURS_NEVEROPEN")
end

-- casino anticheat triggered
AddEventHandler('Casino:Anticheat:Ban', function(playerId, reason)
    local pname = GetPlayerName(playerId)
    local pid = GetPlayerIdentifier(playerId)
    print(('^1Player %s with id %i [%s] should be banned. Reason: %s^7'):format(pname, playerId, pid, reason))
end)

-- Casino: Get player cache
RegisterNetEvent("Casino:GetProgress")
AddEventHandler("Casino:GetProgress", function()
    local playerId = source
    Casino_ResendPlayerProgress(playerId)
end)

-- player wants to refresh his balance
RegisterNetEvent("Casino:Leave")
AddEventHandler("Casino:Leave", function()
    local playerId = source
    if CasinoPlayers[playerId] then
        AddLogEvent(playerId, "Left Casino")
    end
    CasinoPlayers[playerId] = nil
    Cache:ClearPlayerState(playerId)
    RecountCasinoPlayers()
    EndEverything(playerId)
    TriggerEvent("PlayerLeftCasino", playerId)
end)

-- Admin: Update game states
RegisterNetEvent("Casino:AdminUpdateStates")
AddEventHandler("Casino:AdminUpdateStates", function(states)
    local playerId = source
    if not IsPlayerAdmin(playerId) then
        return
    end

    GameStates = states
    TriggerClientEvent("Casino:NewGameStates", -1, states)
end)

-- Admin: Request admin panel
RegisterNetEvent("Casino:AdminShowMenu")
AddEventHandler("Casino:AdminShowMenu", function()
    local playerId = source
    if not IsPlayerAdmin(playerId) then
        return
    end

    TriggerClientEvent("Casino:AdminShowMenu", playerId, GameStates)
end)

-- Admin: Request casino workers
RegisterNetEvent("Casino:AdminShowWorkers")
AddEventHandler("Casino:AdminShowWorkers", function()
    local playerId = source
    if not IsPlayerAdmin(playerId) then
        return
    end

    local casinoworkers = {}
    for _, playerId in ipairs(GetPlayers()) do
        local id = GetPlayerIdentifier(playerId)
        if id and id ~= -1 then
            local name = GetPlayerName(playerId)
            local cache = Cache:GetNow(id, true)
            local o = {
                name = name,
                playerId = playerId,
                actual = 1
            }
            if cache then
                o.actual = cache.jobGrade and (cache.jobGrade + 2) or 1
            end
            table.insert(casinoworkers, o)
        end
    end

    TriggerClientEvent("Casino:AdminShowWorkers", playerId, casinoworkers)
end)

-- Admin: Edit casino worker grade
RegisterNetEvent("Casino:AdminEditWorkerGrade")
AddEventHandler("Casino:AdminEditWorkerGrade", function(playerId, newGrade)
    local playerId = source
    if not IsPlayerAdmin(playerId) then
        return
    end

    local id = GetPlayerIdentifier(playerId)
    if not id or id == -1 then
        return
    end

    -- set unemployed state
    if newGrade == -1 then
        newGrade = nil
    end

    local cache = Cache:GetNow(id)
    if cache then
        cache.jobGrade = newGrade
    end

    Casino_ResendPlayerProgress(playerId)
end)

-- Admin: Kick player
RegisterNetEvent("Casino:AdminKick")
AddEventHandler("Casino:AdminKick", function(kickId)
    local playerId = source
    if not IsPlayerAdmin(playerId) then
        return
    end
    TriggerClientEvent("Casino:BouncerKicked", kickId)
end)

-- Guidebook: Having to ask a server to open a page on a client??? Okay.
RegisterNetEvent("GuideBook:ShowItToMe")
AddEventHandler("GuideBook:ShowItToMe", function(pageKey)
    local playerId = source
    TriggerEvent('rcore_guidebook:openSpecificPage', playerId, pageKey)
end)

-- player wants to get his serverid
RegisterNetEvent("Casino:GetServerId")
AddEventHandler("Casino:GetServerId", function()
    local playerId = source
    TriggerClientEvent("Casino:GetServerId", playerId, playerId)
end)

-- player disconnected, deleting their casino progress
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    if CasinoPlayers[playerId] then
        AddLogEvent(playerId, "Left Casino (Disconnected)")
        RecountCasinoPlayers()
    end

    CasinoPlayers[playerId] = nil
    EndEverything(playerId)
    TriggerEvent("PlayerLeftCasino", playerId)
end)

-- player gets casino info after joining the server
RegisterNetEvent("Casino:GetInfo")
AddEventHandler("Casino:GetInfo", function()
    if not ESX then
        return
    end
    local playerId = source
    local isAdmin = IsPlayerAdmin(playerId)
    TriggerClientEvent("Casino:InitialInfo", playerId, GameStates, isAdmin, playerId)
end)

-- start fuse box
RegisterNetEvent("Casino:StartFuseBox")
AddEventHandler("Casino:StartFuseBox", function()
    local playerId = source
    if not Config.Jobs or not Config.Jobs.Electrician.Enabled then
        return
    end

    -- not a worker
    if not IsPlayerAtJob(playerId, Config.Jobs.Electrician.JobName, nil, Config.Jobs.Electrician.MinGrade,
        Config.Jobs.Electrician.MaxGrade) then
        return
    end

    local wallBroken = Cache.Settings["WallBroken"]
    local electricityBroken = Cache.Settings["ElectricityBroken"]

    if not wallBroken and not electricityBroken then
        return
    end

    -- use one of the circuit boards in inventory
    if Config.Jobs.Electrician.CircuitBoardNeedsPurchase then
        local boards = GetPlayerCasinoItemCount(playerId, Config.Jobs.Electrician.CircuitBoardItemName)
        if boards < 1 then
            TriggerClientEvent("Casino:StartFuseBox", playerId, 0)
            return
        end
        RemoveCasinoItem(playerId, Config.Jobs.Electrician.CircuitBoardItemName, 1)
    end
    -- run circuit board game on client
    TriggerClientEvent("Casino:StartFuseBox", playerId, 1)
end)

-- player fixed fuse box
RegisterNetEvent("Casino:FuseBoxFixed")
AddEventHandler("Casino:FuseBoxFixed", function()
    local playerId = source

    local playerId = source
    if not Config.Jobs or not Config.Jobs.Electrician.Enabled then
        return
    end

    -- not a worker
    if not IsPlayerAtJob(playerId, Config.Jobs.Electrician.JobName, nil, Config.Jobs.Electrician.MinGrade,
        Config.Jobs.Electrician.MaxGrade) then
        return
    end
    DigitalWallUsedTimes = 0
    Cache:UpdateSetting("WallBroken", false)
    Cache:UpdateSetting("ElectricityBroken", false)
    BroadcastCasino("Casino:FuseBoxStateChanged", false, false)
end)

-- player checks for open state
RegisterNetEvent("Casino:CheckOpenState")
AddEventHandler("Casino:CheckOpenState", function()
    local playerId = source
    local isOpen = IsCasinoOpenAtCurrentTime()
    local nextOpenTime = GetCasinoNextOpenTime()
    TriggerClientEvent("Casino:CheckOpenState", playerId, isOpen, nextOpenTime, FORCE_CLOSED)
end)

-- disable maps if not using
local mapDependencies = {}
mapDependencies[1] = "rcore_casino_map"
mapDependencies[5] = "rcore_casino_interior"

for k, v in pairs(mapDependencies) do
    if Config.MapType ~= k and GetResourceState(v) ~= "missing" then
        CreateThread(function()
            while GetResourceState(v) ~= "started" do
                Wait(5000)
            end
            print("^1[Casino] You should disable resource " .. v ..
                      ", because casino has been set to use another map.^7")
            print("^1[Casino] You should remove '" .. v .. "' from dependencies in fxmanifest.lua.^7")
        end)
    end
end

local assets = GetResourceState("rcore_casino_assets")
if assets ~= "started" then
    print("^1[Casino] Please install dependency `rcore_casino_assets`, and make sure it starts before rcore_casino!^7")
end

RegisterCommand("casinoversion", function()
    PrintInfo()
end, false)

PrintInfo()

