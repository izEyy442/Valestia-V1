-- cashier UI selection
local menu_TradeInListIndex = 1
local menu_AcquireListIndex = 1
local menu_confirmedIndex = -1
local moneyOptions = {0}
local chipsOptions = {0}
local dailyBonusUsed = false
local dailyDesc = nil
local vipItemDescription = nil
local vipItemEnabled = false
local confirmMessage = nil
local moneyPercentage = 100
local withdrawBadge = RageUI.BadgeStyle.None
local withdrawDesc = Translation.Get("CASHIER_TRADEIN_DESC")
local canPurchaseVIP = true
local extraTransferInfo = nil
local maxSocietyMoney = 0

local function RefreshCashierVIPItem()
    vipItemEnabled = true
    if PLAYER_IS_VIP then
        vipItemDescription = string.format(Translation.Get("CASHIER_VIP_PURCHASE_COMPLETE"),
            CommaValue(Config.CASHIER_VIP_PRICE), Config.PRICES_CURRENCY)

        if Config.CASHIER_VIP_DURATION then
            vipItemDescription = vipItemDescription ..
                                     string.format(" " .. Translation.Get("CASHIER_VIP_VALID_FOR"),
                    FormatTimestamp(PLAYER_CACHE.vipUntil - SERVER_TIMER))
        end
        vipItemEnabled = false
    else
        if PLAYER_MONEY < Config.CASHIER_VIP_PRICE then
            vipItemDescription = Translation.Get("CASHIER_VIP_NO_MONEY")
            vipItemEnabled = true
        else
            vipItemDescription = string.format(Translation.Get("CASHIER_VIP_MEMBERSHIP_DESC"),
                CommaValue(Config.CASHIER_VIP_PRICE), Config.PRICES_CURRENCY)
        end
    end

    if not canPurchaseVIP then
        vipItemEnabled = false
        vipItemDescription = Translation.Get("CASHIER_VIP_PASS_ERROR")
    end
end

function ResetCashierUISelection(moneyLimit, societyMoney)
    moneyPercentage = moneyLimit
    if societyMoney then
        maxSocietyMoney = societyMoney
    end
    menu_TradeInListIndex = 1
    menu_AcquireListIndex = 1
    menu_confirmedIndex = -1
    moneyOptions = CashierGetMoneyBalanceOptions(PLAYER_MONEY)
    chipsOptions = CashierGetBalanceOptions(PLAYER_CHIPS, maxSocietyMoney / Config.ExchangeRate)

    withdrawBadge = moneyPercentage == 100 and RageUI.BadgeStyle.None or RageUI.BadgeStyle.Alert
    withdrawDesc = Translation.Get("CASHIER_TRADEIN_DESC")
    if moneyPercentage == 0 then
        withdrawDesc = Translation.Get("SOCIETY_CASHIER_MONEY_LIMIT_3")
    elseif moneyPercentage < 100 then
        withdrawDesc = withdrawDesc .. " " ..
                           string.format(Translation.Get("SOCIETY_CASHIER_MONEY_LIMIT"), moneyPercentage)
    end

    dailyBonusUsed = PLAYER_CACHE.lastDailyBonus and PLAYER_CACHE.lastDailyBonus == SERVER_DATE
    dailyDesc = dailyBonusUsed and Translation.Get("CASHIER_DAILY_BONUS_USED") or
                    string.format(Translation.Get("CASHIER_DAILY_BONUS_DESC"), Config.CASHIER_DAILY_BONUS)
end

-- show cashier ui
function Cashier_ShowMenu(moneyLimit, vipAllowed, maxMoney, extraData)
    print(json.encode(extraData))
    canPurchaseVIP = vipAllowed
    maxSocietyMoney = maxMoney
    ResetCashierUISelection(moneyLimit, maxSocietyMoney)
    InfoPanel_UpdateNotification(nil)

    local cashierMenu = RageUI.CreateMenu("", Translation.Get("CASHIER_CAPT"), 25, 25, "shopui_title_casino_banner",
        "shopui_title_casino_banner")
    local exchangeRateDesc = nil
    if Config.ExchangeRate ~= 1 then
        exchangeRateDesc = string.format(Translation.Get("CASHIER_EXCHANGE_RATE_DESC"),
            FormatPrice(math.ceil(10 * Config.ExchangeRate)))
    end

    function RageUI.PoolMenus:CashierUI()
        cashierMenu:IsVisible(function(i)
            RefreshCashierVIPItem()
            if not Config.UseOnlyMoney then
                i:AddList(Translation.Get("CASHIER_ACQUIRE_CAPT"), moneyOptions, menu_AcquireListIndex,
                    (menu_AcquireListIndex == menu_confirmedIndex and confirmMessage or
                        Translation.Get("CASHIER_ACQUIRE_DESC")), {
                        IsDisabled = moneyOptions[menu_AcquireListIndex] == 0 or not CAN_INTERACT
                    }, function(Index, onSelected, onListChange)
                        if (onListChange) then
                            menu_AcquireListIndex = Index;
                            menu_confirmedIndex = -1
                        end
                        if onSelected then
                            if not CAN_INTERACT then
                                return
                            end
                            if moneyOptions[Index] == nil then
                                return
                            end
                            if menu_confirmedIndex ~= Index then
                                menu_confirmedIndex = Index
                                local amount = CommaValue(moneyOptions[Index])
                                local realChipsValue = math.ceil(moneyOptions[Index] * Config.ExchangeRate)

                                confirmMessage = string.format(Translation.Get("CASHIER_YOU_SURE_ACQUIRE"), amount,
                                    FormatPrice(realChipsValue))

                                if Config.ExchangeRate ~= 1 then
                                    confirmMessage = string.format(Translation.Get("CASHIER_TRANSFER_INFO"),
                                        CommaValue(amount), FormatPrice(realChipsValue)) .. confirmMessage
                                end
                                return
                            end
                            Cashier_AcquireChips(moneyOptions[Index])
                        end
                    end)
                i:AddList(Translation.Get("CASHIER_TRADEIN_CAPT"), chipsOptions, menu_TradeInListIndex,
                    (menu_TradeInListIndex == menu_confirmedIndex and confirmMessage or withdrawDesc), {
                        IsDisabled = chipsOptions[menu_TradeInListIndex] == 0 or moneyPercentage <= 0 or
                            not CAN_INTERACT,
                        LeftBadge = withdrawBadge
                    }, function(Index, onSelected, onListChange)
                        if (onListChange) then
                            menu_TradeInListIndex = Index;
                            menu_confirmedIndex = -1
                        end
                        if onSelected then
                            if not CAN_INTERACT then
                                return
                            end
                            if chipsOptions[Index] == nil then
                                return
                            end

                            if menu_confirmedIndex ~= Index then
                                menu_confirmedIndex = Index
                                local amount = CommaValue(chipsOptions[Index])
                                local realChipsValue = math.ceil(chipsOptions[Index] * Config.ExchangeRate)
                                confirmMessage = string.format(Translation.Get("CASHIER_YOU_SURE_TRADE_IN"), amount)

                                if Config.ExchangeRate ~= 1 then
                                    confirmMessage = string.format(Translation.Get("CASHIER_TRANSFER_INFO"),
                                        CommaValue(amount), FormatPrice(realChipsValue)) .. confirmMessage
                                end

                                if moneyPercentage < 100 then
                                    local reducedMoney = math.ceil((realChipsValue / 100) * moneyPercentage)
                                    confirmMessage = confirmMessage .. " " ..
                                                         string.format(Translation.Get("SOCIETY_CASHIER_MONEY_LIMIT_2"),
                                            CommaValue(reducedMoney), Config.PRICES_CURRENCY, amount, moneyPercentage)
                                end
                                return
                            end
                            Cashier_TradeInChips(chipsOptions[Index])
                        end
                    end)
            end

            if Config.CASHIER_DAILY_BONUS ~= 0 then
                i:AddButton(Translation.Get("CASHIER_DAILY_BONUS_CAPT"), dailyDesc, {
                    IsDisabled = dailyBonusUsed,
                    RightLabelColor = RageUI.ItemsColour.White
                }, nil, function()
                    Cashier_DailyBonus()
                end)
            end

            i:AddButton(Translation.Get("CASHIER_VIP_MEMBERSHIP_CAPT"), vipItemDescription, {
                IsDisabled = vipItemEnabled == false,
                RightLabelColor = RageUI.ItemsColour.White,
                RightBadge = RageUI.BadgeStyle.CasinoVIP
            }, nil, function()
                Cashier_RequestVIP()
            end)

            local canOrderDelivery = extraData.MoneyLoad and Config.JobsEnabled and
                                         Config.Jobs.MONEYLOAD_STARTFROMCASHIERUI and
                                         IsAtJob(Config.JobName, nil, Config.Jobs.MONEYLOAD_STARTJOBGRADE,
                    Config.Jobs.MONEYLOAD_STARTJOBGRADE)

            if MONEYLOAD_TAKE or canOrderDelivery then
                i:AddSeparator("Mission Options")
            end

            if MONEYLOAD_TAKE then
                i:AddButton(Translation.Get("MONEYLOAD_CASHIER_CAPTION"),
                    string.format(Translation.Get("MONEYLOAD_CASHIER_DESC"), FormatPrice(MONEYLOAD_TAKE)), {
                        IsDisabled = dailyBonusUsed,
                        RightLabelColor = RageUI.ItemsColour.White,
                        RightBadge = RageUI.BadgeStyle.Package
                    }, nil, function()
                        MONEYLOAD_TAKE = nil
                        TriggerServerEvent("CasinoMission:MoneyLoad:DeliverMoney")
                        Cashier_OnQuit()
                        RemoveMissionBlip("cashier")
                        -- give take animation
                        Citizen.CreateThread(function()
                            RequestAnimDictAndWait("mp_common")
                            if HasAnimDictLoaded("mp_common") then
                                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_b", 3.0, 3.0, -1, 0, 0, true, true,
                                    true)
                                for k, v in pairs(CashierDatas) do
                                    if v.enabled and v.ped then
                                        PlayPedAmbientSpeechWithVoiceNative(v.ped, "WELCOME_BACK_WINNER",
                                            "u_f_m_casinocash_01", "SPEECH_PARAMS_FORCE_NORMAL", 0)
                                        TaskPlayAnim(v.ped, "mp_common", "givetake2_a", 3.0, 3.0, -1, 0, 0, true, true,
                                            true)
                                        break
                                    end
                                end
                            end
                        end)
                    end)
            else
                if canOrderDelivery then
                    local oderAllowed = true
                    local orderDesc = string.format(Translation.Get("MONEYLOAD_CASHIER_ORDER_DELIVERY_DESC"),
                        FormatPrice(Config.Jobs.MONEYLOAD_TAKE))
                    if #extraData.MoneyLoad.jobMembers > 0 then
                        orderDesc = orderDesc .. " " ..
                                        string.format(Translation.Get("MONEYLOAD_CASHIER_MEMBERLIST"),
                                extraData.MoneyLoad.memberNames)
                    else
                        oderAllowed = false
                        orderDesc = Translation.Get("MONEYLOAD_CASHIER_MEMBERLIST_EMPTY")
                    end
                    if extraData.MoneyLoad.missionActive then
                        oderAllowed = false
                        orderDesc = Translation.Get("MONEYLOAD_CASHIER_ORDER_DELIVERY_ALREADYACTIVE")
                    end

                    i:AddButton(Translation.Get("MONEYLOAD_CASHIER_ORDER_DELIVERY"), orderDesc, {
                        IsDisabled = not oderAllowed,
                        RightLabelColor = RageUI.ItemsColour.White,
                        RightBadge = RageUI.BadgeStyle.Package
                    }, nil, function()
                        Cashier_OnQuit()
                        TriggerServerEvent("CasinoMission:MoneyLoad:Order")
                    end)
                end
            end

            if exchangeRateDesc then
                i:AddSeparator(exchangeRateDesc, RageUI.ItemsColour.Yellow)
            end

            if Config.EnableSociety and Config.CASHIER_SHOW_SOCIETY_BALANCE then
                i:AddSeparator(string.format(Translation.AVAIABLE_SOCIETY_BALANCE, FormatPrice(maxMoney)),
                    RageUI.ItemsColour.Yellow)
            end

        end, function(Panels)
        end)
    end
    RageUI.Visible(cashierMenu, true)
end

-- opens up sitting menu (choose from snacks to eat/drink while sitting at the bar)
function DrinkingBar_ShowSittingMenu()
    InfoPanel_UpdateNotification(nil)
    local sittingMenu = RageUI.CreateMenu("", Translation.Get("BAR_SNACKS_CAPT"), 25, 25, "shopui_title_casino_banner",
        "shopui_title_casino_banner")
    function RageUI.PoolMenus:DrinksUI()
        sittingMenu:IsVisible(function(i)
            for x = 1, #CasinoInventoryItems do
                local v = CasinoInventoryItems[x]
                if v.itemType == 1 then
                    local key = v.key
                    if PLAYER_ITEMS[key] and PLAYER_ITEMS[key] > 0 then
                        i:AddButton(v.title, Translation.Get("BAR_SNACKS_DESC"), {
                            IsDisabled = false,
                            RightLabel = PLAYER_ITEMS[key],
                            RightLabelColor = RageUI.ItemsColour.White
                        }, nil, function()
                            SittingMenu_SnackSelected(key)
                        end)
                    end
                end
            end
        end, function(Panels)
        end)
    end
    RageUI.Visible(sittingMenu, true)
end

function DrinkingBar_ShowMenu()
    -- CAN_MOVE = false
    InfoPanel_UpdateNotification(nil)
    local drinksMenu = RageUI.CreateMenu("", Translation.Get("BAR_MENU_TITLE"), 25, 25, "shopui_title_casino_banner",
        "shopui_title_casino_banner")
    function RageUI.PoolMenus:DrinksUI()
        drinksMenu:IsVisible(function(i)

            if Config.BarShowSnacks then
                i:AddSeparator(Translation.Get("BAR_SNACKS_SEPARATOR_DRINKS"))
            end

            for x = 1, #CasinoInventoryItems do
                local v = CasinoInventoryItems[x]
                local k = v.key
                if v.itemType == 2 then
                    local price = FormatPrice(v.price)
                    local forFree = v.luckyWheelAffected and PLAYER_CACHE.freeDrinksUntil and SERVER_TIMER <
                                        PLAYER_CACHE.freeDrinksUntil
                    if forFree then
                        price = Translation.Get("BAR_SNACKS_PRICE_FREE")
                    end
                    local itemDescription = PLAYER_MONEY >= v.price and Translation.Get("BAR_MENU_DESC") or
                                                string.format(Translation.Get("BAR_MENU_NO_MONEY"), price)
                    local itemDisabled = (forFree == false and PLAYER_MONEY < v.price)
                    if v.vip and not PLAYER_IS_VIP then
                        itemDisabled = true
                        itemDescription = Translation.Get("BUYING_ITEMS_VIP_RESTRICTION")
                    end
                    i:AddButton(v.title, itemDescription, {
                        IsDisabled = itemDisabled,
                        RightLabel = price,
                        RightLabelColor = RageUI.ItemsColour.GreenLight
                    }, nil, function()
                        DrinksMenu_DrinkSelected(k)
                    end)
                end
            end

            if Config.BarShowSnacks then
                i:AddSeparator(Translation.Get("BAR_SNACKS_SEPARATOR_SNACKS"))

                for x = 1, #CasinoInventoryItems do
                    local v = CasinoInventoryItems[x]
                    local k = v.key

                    if v.itemType == 1 and x ~= 10 then
                        local price = FormatPrice(v.price)
                        i:AddButton(v.title, PLAYER_MONEY >= v.price and Translation.Get("BAR_MENU_DESC2") or
                            string.format(Translation.Get("BAR_MENU_NO_MONEY"), price), {
                            IsDisabled = PLAYER_MONEY < v.price,
                            RightLabel = FormatPrice(v.price),
                            RightLabelColor = RageUI.ItemsColour.OrangeLight
                        }, nil, function()
                            DrinksMenu_DrinkSelected(k)
                        end)
                    end
                end
            end

        end, function(Panels)
        end)
    end
    RageUI.Visible(drinksMenu, true)
end

function GameStates_ShowMenu()
    InfoPanel_UpdateNotification(nil)
    CloseAllMenus()
    local statesMenu = RageUI.CreateMenu("", Translation.Get("GAME_STATE_MENU_TITLE"), 25, 25,
        "shopui_title_casino_banner", "shopui_title_casino_banner")

    function RageUI.PoolMenus:CashierUI()
        statesMenu:IsVisible(function(i)
            for n = 1, #GameStates do
                local v = GameStates[n]
                i:AddButton(v.title, nil, {
                    IsDisabled = false,
                    RightLabelColor = RageUI.ItemsColour.White,
                    RightBadge = v.enabled and RageUI.BadgeStyle.Tick or RageUI.BadgeStyle.Lock
                }, nil, function()
                    if v.enabled then
                        v.enabled = false
                    else
                        v.enabled = true
                    end
                    TriggerServerEvent("Casino:AdminUpdateStates", GameStates)
                end)
            end
            i:AddSeparator(" ")
            i:AddButton(Translation.Get("BTN_CLOSE"), nil, {
                IsDisabled = false,
                RightLabelColor = RageUI.ItemsColour.White,
                RightBadge = RageUI.BadgeStyle.Alert
            }, nil, function()
                CloseAllMenus()
            end)

        end, function(Panels)
        end)
    end
    RageUI.Visible(statesMenu, true)
end

-- standalone: manage casino workers menu
function Workers_ShowMenu(workers)
    InfoPanel_UpdateNotification(nil)
    CloseAllMenus()

    local gradeOptions = {"Unemployed", "Grade 0", "Grade 1", "Grade 2 (Boss)"}
    local workersMenu = RageUI.CreateMenu("", "Casino Workers", 25, 25, "shopui_title_casino_banner",
        "shopui_title_casino_banner")

    function RageUI.PoolMenus:CashierUI()
        workersMenu:IsVisible(function(i)
            for k, v in pairs(workers) do
                i:AddList(v.name, gradeOptions, v.actual, nil, {
                    IsDisabled = false
                }, function(Index, onSelected, onListChange)
                    if (onListChange) then
                        v.actual = Index
                        local newGrade = v.actual - 2
                        TriggerServerEvent("Casino:AdminEditWorkerGrade", v.playerId, newGrade)
                    end
                    if onSelected then
                        CloseAllMenus()
                    end
                end)
            end
        end, function(Panels)
        end)
    end
    RageUI.Visible(workersMenu, true)
end

function CloseAllMenus()
    RageUI.CloseAll()
end

function OnMenusClosed()
    -- print("Menus were closed.")
end
