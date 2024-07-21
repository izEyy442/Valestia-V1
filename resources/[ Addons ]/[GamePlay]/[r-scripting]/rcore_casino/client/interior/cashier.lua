-- cashier instances
local cashiers = {}
local history = {}

-- session
local s_cashierCoords = nil
local s_myCashier = nil
local s_lastMoneyLimit = 100

-- get cashier instance from coords
local function GetCashierFromCoords(coords)
    if not coords then
        return
    end
    DebugStart("GetCashierFromCoords")
    for _, o in pairs(cashiers) do
        if #(coords - o.coords) < 0.2 then
            return o
        end
    end
    return nil
end

-- generate list of balances (rageui)
function CashierGetBalanceOptions(balance, max)
    DebugStart("CashierGetBalanceOptions")
    if max < balance then
        balance = max
    end
    local options = {}
    local c = 0
    local x = 0

    while x < balance do
        c = c + 1
        if x < 100 then
            x = x + 10
        elseif x < 1000 then
            x = x + 100
        elseif x < 10000 then
            x = x + 500
        elseif x < 100000 then
            x = x + 10000
        elseif x < 1000000 then
            x = x + 100000
        else
            x = x + 1000000
        end

        local option = Clamp(x, 1, balance)
        option = math.ceil(option)
        option = math.round(option / 10) * 10

        if option >= 10 and balance >= option then
            table.insert(options, option)
        end

        if c > 200 then
            break
        end
    end
    if #(options) == 0 then
        table.insert(options, 0)
    end
    return options
end

function CashierGetMoneyBalanceOptions(balance)
    DebugStart("CashierGetBalanceOptions")
    local options = {}
    local c = 0
    local x = 0

    balance = math.ceil(balance / Config.ExchangeRate)

    while x < balance do
        c = c + 1
        if x < 100 then
            x = x + 10
        elseif x < 1000 then
            x = x + 100
        elseif x < 10000 then
            x = x + 500
        elseif x < 100000 then
            x = x + 10000
        elseif x < 1000000 then
            x = x + 100000
        else
            x = x + 1000000
        end

        local option = Clamp(x, 1, balance)
        option = math.ceil(option)
        option = math.round(option / 10) * 10

        if option >= 10 and balance >= option then
            table.insert(options, option)
        end

        if c > 200 then
            break
        end
    end
    if #(options) == 0 then
        table.insert(options, 0)
    end
    return options
end

-- get chips, pay with money
function Cashier_AcquireChips(amount)
    DebugStart("Cashier_AcquireChips")
    BlockPlayerInteraction(1500)
    TriggerServerEvent("Casino:AcquireChips", amount)
end

-- get money, pay with chips
function Cashier_TradeInChips(amount)
    DebugStart("Cashier_TradeInChips")
    BlockPlayerInteraction(1500)
    TriggerServerEvent("Casino:TradeInChips", amount)
end

-- get daily bonus, if enabled
function Cashier_DailyBonus()
    DebugStart("Cashier_DailyBonus")
    if Config.CASHIER_DAILY_BONUS == 0 then
        return
    end
    if PLAYER_CACHE.lastDailyBonus and PLAYER_CACHE.lastDailyBonus == SERVER_DATE then
        return
    end
    BlockPlayerInteraction(2000)
    TriggerServerEvent("Casino:DailyBonus")
end

function Cashier_RequestVIP()
    if PROMPT_ACTIVE then
        return
    end
    Cashier_OnQuit()

    local message = string.format(Translation.Get("CASHIER_VIP_CONFIRM_MSG"), FormatPrice(Config.CASHIER_VIP_PRICE))
    if Config.CASHIER_VIP_DURATION then
        message = message ..
                      string.format(Translation.Get("CASHIER_VIP_CONFIRM_MSG_2"),
                FormatTimestamp(Config.CASHIER_VIP_DURATION))
    end
    FullscreenPrompt(Translation.Get("CASHIER_VIP_CONFIRM_CAPT"), message, function(yes)
        if yes then
            DebugStart("Cashier_RequestVIP")
            TriggerServerEvent("Casino:BecomeVIP")
            ResetCashierUISelection(s_lastMoneyLimit)
        end
    end)
end

function Cashier_OnInteraction(forceCoords)
    if forceCoords then
        s_cashierCoords = forceCoords
    end
    DebugStart("Cashier_OnInteraction")
    if not CAN_INTERACT then
        return
    end
    if PLAYER_DRUNK_LEVEL >= 1.0 then
        return
    end
    BlockPlayerInteraction(2000)

    RequestPlayerMoney(function(money)
        local usedBefore = history[s_cashierCoords] and true or false
        local isDrunk = PLAYER_DRUNK_LEVEL > 0.5
        TriggerServerEvent("Cashier:Use", s_cashierCoords, usedBefore, isDrunk)
    end)
end

function Cashier_OnBecomeVIP()
    DebugStart("Cashier_OnBecomeVIP")
    ResetCashierUISelection(s_lastMoneyLimit)
end

function Cashier_ShowNotifyUI(coords)
    if Config.UseTarget then
        return
    end
    DebugStart("Cashier_ShowNotifyUI")
    local cashier = GetCashierFromCoords(coords)

    if not cashier then
        return
    end

    if cashier.playerId ~= -1 then
        InfoPanel_UpdateNotification(Translation.Get("CASHIER_BEING_USED"))
        return
    end

    InfoPanel_UpdateNotification(Translation.Get("CASHIER_PRESS_TO_USE"))
    s_cashierCoords = coords
end
-- load cashiers
function Cashier_Load()
    DebugStart("Cashier_Load")
    for _, o in pairs(CashierDatas) do
        if o.enabled then
            local coords = o.coords
            local head = o.heading
            local model = GetHashKey(o.model)
            RequestModelAndWait(model)

            local cashier = {}
            cashier.playerId = -1
            cashier.coords = coords
            cashier.ped = CreatePed(2, model, coords, head, false, false)
            o.ped = cashier.ped
            SetPedBrave(cashier.ped)
            table.insert(cashiers, cashier)

            -- target
            local targetOffset = GetObjectOffsetFromCoords(coords, head, 0.0, 0.2, 0.5)
            CreateTargetZone(vector3(targetOffset.x, targetOffset.y, targetOffset.z), 1.0, 2.0, 0.0, {{
                num = 1,
                type = "client",
                event = "Casino:Target",
                icon = 'fas fa-cash-register',
                label = removePlaceholderText(Translation.Get("CASHIER_PRESS_TO_USE")),
                targeticon = 'fas fa-cash-register',
                canInteract = function(entity, distance, data)
                    return CAN_INTERACT
                end,
                drawColor = {255, 255, 255, 255},
                successDrawColor = {30, 144, 255, 255},
                eventAction = "cashier_enter",
                cashierCoords = coords,
            }})

        end
    end
    SetCasinoBlip(cashiers[1].coords, 683, Translation.Get("BLIP_CASHIER"), false)
end

RegisterNetEvent("Cashier:Use")
AddEventHandler("Cashier:Use", function(coords, playerId, greetings, moneyLimit, canPurchaseVIP, maxMoney, extraData)
    local cashier = GetCashierFromCoords(coords)
    if not cashier then
        return
    end
    cashier.playerId = playerId
    PlayPedAmbientSpeechWithVoiceNative(cashier.ped, greetings, "u_f_m_casinocash_01", "SPEECH_PARAMS_FORCE_NORMAL", 0)
    if playerId == GetMyPlayerId() then
        UnblockPlayerInteraction()
        SetInventoryBusy(true)
        LAST_STARTED_GAME_TYPE = "cashier"
        Cashier_ShowMenu(moneyLimit, canPurchaseVIP, maxMoney, extraData)
        s_lastMoneyLimit = moneyLimit
        s_cashierCoords = coords
        s_myCashier = cashier
        CAN_MOVE = false
    end
end)

RegisterNetEvent("Cashier:Sessions")
AddEventHandler("Cashier:Sessions", function(sessions)
    for _, v in pairs(sessions) do
        local cashier = GetCashierFromCoords(v.coords)
        if not cashier then
            goto continue
        end
        cashier.playerId = v.playerId
        cashier.coords = v.coords

        ::continue::
    end
end)

RegisterNetEvent("Cashier:Quit")
AddEventHandler("Cashier:Quit", function(coords, playerId)
    local cashier = GetCashierFromCoords(coords)
    if playerId == GetMyPlayerId() then
        CAN_MOVE = true
    end

    if not cashier then
        return
    end
    cashier.playerId = -1
end)

-- trade results
RegisterNetEvent("Casino:TradeResults")
AddEventHandler("Casino:TradeResults", function(chipsNow, moneyNow, comment, moneyLimit, societyNow, pCache)
    if chipsNow and chipsNow ~= -1 then
        PLAYER_CHIPS = chipsNow
        PLAYER_MONEY = moneyNow
        s_lastMoneyLimit = moneyLimit
        if pCache and type(pCache) == "table" then
            PLAYER_CACHE = pCache
        end
        Casino_AnimateBalance()
        if s_myCashier ~= nil then
            PlayPedAmbientSpeechWithVoiceNative(s_myCashier.ped, comment, "u_f_m_casinocash_01",
                "SPEECH_PARAMS_FORCE_NORMAL", 0)
            ResetCashierUISelection(moneyLimit, societyNow)
        end
    else
        Cashier_OnQuit()
        local societyMoney = moneyNow
        FullscreenPrompt(Translation.Get("CASHIER_TRADEIN_FAILED_CAPT"), Translation.Get("CASHIER_TRADEIN_FAILED_MSG"),
            nil, string.format(Translation.Get("CASHIER_SOCIETY_BALANCE"), FormatPrice(societyMoney)))
        PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", true)
    end
end)

-- on quit
function Cashier_OnQuit()
    DebugStart("Cashier_OnQuit")
    if Config.CASHIER_MULTITASK then
        local cashier = GetCashierFromCoords(s_cashierCoords)
        if cashier then
            cashier.playerId = -1
        end
    end
    TriggerServerEvent("Cashier:Quit")
    CloseAllMenus()
    CAN_MOVE = true
    SetInventoryBusy(false)
    ForgotLastStartedGameType("cashier")
end

-- destroy all cashiers
function Cashier_Destroy()
    DebugStart("Cashier_Destroy")
    for _, o in pairs(cashiers) do
        ForceDeleteEntity(o.ped)
    end
    cashiers = {}
end
