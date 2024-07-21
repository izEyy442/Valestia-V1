Config = {
    -- Locale
    Locale = "en", -- en

    -- Map
    MapType = 5,
    -- 1: UncleJust Casino / DLCiplLoader
    -- 2: Gabz Casino
    -- 3: NoPixel Casino
    -- 4: k4mb1 casino
    -- 5: GTA:O Interior (rcore_casino_interior)
    -- 6: Underground Casino PALETO
    -- 7: K4MB1 old enterable casino (casinointerior & casinoexterior)
    -- make sure rcore_casino_interior is disabled when using another map type, and don't forget to remove rcore_casino_interior from dependencies in fxmanifest.lua as well

    --[[
    Gabz Casino
    • copy "\extra\gabz-casino\gabz_vw_vwdlc_int_01.ytyp" to "cfx-gabz-casino\stream\ytyp\"
   
    NoPixel Casino
    • delete \stream\Main\ydr\vw_prop_vw_luckywheel_01a.ydr in NoPixel Casino
    • copy "\extra\nopixel\gbz_vw_vwdlc_int_01.ytyp" inside stream\Main\ytyp in NoPixel Casino
    • copy "\extra\nopixel\vw_vwint01_betting_desks.ydr" inside stream\Main\ydr in NoPixel Casino

    K4MB1 old enterable casino
    • copy "brown_casinoextended.ytyp" to "casinointerior\stream\base k4mb1-old-casino"
    ]]

    -- Xmas trees
    -- • configurable in xmas\xmas_cl.lua and xmas\xmas_sv.lua
    Xmas = true,

    -- Target
    UseTarget = false, -- whether to use target zones or not
    TargetZoneType = 4, -- 1: q_target, 2: bt_target, 3: qb-target, 4: ox_target

    -- Money Or Casino Chips? 
    MoneyInventoryItemName = nil, -- name of the money inventory item, set to nil, if you don't want to use inventory item as the money
    UseOnlyMoney = false, -- set to true if you wanna disable using casino chips and use money instead
    ExchangeRate = 1, -- set value of one casino chip, for example, set to 5, if 1 chip equals to 5$ (minimum: 0.1, rounded by 0.1, 0.5 or 1)
    ChipsInventoryItem = "casino_chips",
    UseBankMoney = true, -- cash or bank?
    DailyWidthdrawLimit = 0, -- how much money can player withdraw from the cashier per day (24 hours), set to 0 to disable

    -- Behave in casino?
    RestrictControls = true, -- don't jump, don't attack inside the Casino

    -- Bar
    BarShowSnacks = true, -- disable, if you want to see only drinks in the bartender menu

    -- Inside Track
    IT_STARTING_SOON_TIME = 0, -- *starting soon screen* duration; def: 0
    IT_MAIN_EVENT_MIN_PLAYERS = 1, -- min. players needed for the main event to start; def: 2
    IT_MAIN_EVENT_ENABLED = true, -- when false, the main event will be disabled, big screen will show only purple idle screen; def: true
    IT_MAIN_EVENT_BETTING_TIME = 60 * 5, -- time for players to place bets for main event, shows horses on screen; def: 60 * 5 (5 minutes)
    IT_MAIN_EVENT_RACE_DURATION = 33, -- length of the main event race; def: 33
    IT_MAIN_EVENT_HORSE_ODDS = {2, 5, 6, 15, 16, 30}, -- limit max horse odds for local game (1 to 30), def: {1, 5, 6, 15, 16, 30}  (2 horses of odds from 1 to 5, 2 horses of odds from 6 to 15, 2 horses of odds from 16 to 30)
    IT_MAIN_EVENT_RACE_MAX_BET = 10000, -- max. bet for the main event race
    IT_MAIN_EVENT_RACE_MIN_BET = 10, -- min. bet for the main event race
    IT_LOCAL_RACE_DURATION = 30, -- length of the local race (orange screen) def: 30
    IT_LOCAL_RACE_HORSE_ODDS = {2, 5, 6, 15, 16, 30}, -- limit max horse odds for local game (1 to 30), def: {1, 5, 6, 15, 16, 30}  (2 horses of odds from 1 to 5, 2 horses of odds from 6 to 15, 2 horses of odds from 16 to 30)
    IT_LOCAL_RACE_MAX_BET = 10000, -- max. bet for the local race
    IT_LOCAL_RACE_MIN_BET = 10, -- min. bet for the local race
    IT_LOCAL_RACE_COOLDOWN = 0, -- how long until they can play another local game, in seconds, (def: 60 * 10)
    IT_MAIN_EVENT_COOLDOWN = 0, -- how long until they can play another main event game, in seconds, (def: 60 * 10)
    -- Win chance of horses are based on their odds, however, if you want to make the game more unlucky, lower the win chance:
    IT_LOCAL_RACE_WIN_CHANCE = 50, -- win chance (from 0 to 100), def: 100, 100 means that it's not *unlucky* at all
    IT_MAIN_EVENT_RACE_WIN_CHANCE = 50, -- win chance (from 0 to 100), def: 100, 100 means that it's not *unlucky* at all

    -- Roulette
    ROULETTE_JUNIOR_ENABLED = true, -- set if you want to have Roulette Junior (blue) table for newbies (low stakes)
    ROULETTE_JUNIOR_COORDS = {1004.790, 57.295, 68.432},

    -- Slots
    SLOTS_1ST_PERSON = true, -- switch to 1st person when spinning slots

    -- Lucky Wheel
    LUCKY_WHEEL_ENABLED = true, -- set to false, if you don't want to use Lucky Wheel
    LUCKY_WHEEL_FREE_DRINKS_FOR = (60 * 60 * 24), -- when someone spins "Free Drinks" at the Lucky Wheel, how long they get free drinks for. def: 24 hours (60 * 60 * 24)
    LUCKY_WHEEL_COOLDOWN = (60 * 60 * 24), -- how long players have to wait for their next spin. def: 24 hours (60 * 60 * 24)
    LUCKY_WHEEL_VEHICLE_ALTERNATIVE = "Money9", -- if player spins Vehicle, but there is no avaiable podium vehicle at the moment, spin to this item. Def: "Money50K" (the second biggest price)
    LUCKY_WHEEL_CAR_WINABLE = true, -- true: players can win the car, false: car is just a decoration
    LUCKY_WHEEL_PAY_TO_SPIN = 0, -- set price for the spin (chips), set 0 for free spins, or set to existing inventory name, for example LUCKY_WHEEL_PAY_TO_SPIN = "wheel_ticket" to pay with an inventory item
    LUCKY_WHEEL_CAR_ONE_WINNER = true, -- set to true, if only one player can win the podium vehicle. the vehicle will disapear from the podium after someone wins it.

    -- Blackjack
    BLACKJACK_JUNIOR_ENABLED = true, -- set if you want to have Blackjack Junior (blue) table for newbies (low stakes)
    BLACKJACK_JUNIOR_COORDS = {1004.183, 53.192, 68.432},

    -- Poker
    POKER_JUNIOR_ENABLED = true, -- set if you want to have Poker Junior (blue) table for newbies (low stakes)
    POKER_JUNIOR_COORDS = {998.439, 61.031, 68.432},

    -- Cashier
    CASHIER_DAILY_BONUS = 1000, -- daily visitor bonus that players can request at the Cashier, set to 0 if you don't want any daily bonuses. def: 1000
    CASHIER_VIP_PRICE = 50000, -- price of the VIP casino membership, def: 50000
    CASHIER_VIP_DURATION = (60 * 60 * 24) * 7, -- VIP for player resets after this time, def: 7 days
    CASHIER_SHOW_SOCIETY_BALANCE = false, -- whether to show avaiable society balance in cashier UI

    -- Casino Settings (don't change unless you're told to :)
    CAS_DOUBLECHECK_COORDS = vector3(984.528, 52.299, 70.238),
    CASINO_ENABLE_AMBIENT_PEDS = true, -- standing peds
    CASINO_ENABLE_AMBIENT_PEDS_SLOTS = true, -- peds playing slots
    CASINO_ENABLE_AMBIENT_PEDS_POKER = true, -- peds playing poker
    CASINO_ENABLE_AMBIENT_PEDS_BLACKJACK = true, -- peds playing blackjack
    CASINO_ENABLE_AMBIENT_PEDS_ROULETTE = true, -- peds playing roulette
    CASINO_AMBIENT_PEDS_DENSITY = 3, -- 1: a few, 2: medium, 3: all peds
    CASINO_SAVE_TIMER = 30000, -- database update interval
    DISABLE_IDLE_CAM = true, -- disable idle cam animations (looking around)
    CASINO_ANIM_TIMEOUT = 750, -- pause between animations (in milliseconds), decrease this number to make interaction animations faster, be careful, smaller number can cause desync in animations if players have high ping. def: 750
    PRICES_CURRENCY = "$", -- $, €, £, ¥, ₽, ₩, ₹ ...
    RADAR_ZOOMLEVEL = 0.0, -- customize the radar zoom, from 0.0 (closest) to higher
    ENTER_CASINO_FADEOUT = 1, -- whether to fadeout the screen when entering (loading) casino or not (0: disabled, 1: only first enter, 2: every time)
    CASHIER_MULTITASK = true, -- multiple players can use the Cashier at the same time
    LOAD_SCENE = true, -- load the whole casino playing area after entering (recommended)
    CLEAR_OBJECTS_ON_ENTER = false, -- destroy all locally created peds/objects after entering the casino, to save up space, set to false
    --
    JOB_PODIUMCAR_OWNERSHIP_CHECK = true,
    JOB_PODIUMCAR_OWNERSHIP_DELETE_ORIGINAL = true,
    JOB_PODIUMCAR_DELETE_ORIGINAL_FUNCTION_CLIENT = function(vehicleId, plateNumber) -- client function that the car dealer executes after delivering the car
        DeleteVehicle(vehicleId)
    end,

    CASINO_BLIPS_SHORT_RANGE = true, -- true: blips are visible only to players near casino, false: blips are always visible
    CASINO_BLIP_ID = 679, -- 679 is the diamond icon [https://docs.fivem.net/docs/game-references/blips/]
    --
    AMBIENT_SOUNDS = true, -- enable casino background interior sound

    Debug = false,

    -- Plate Settings
    PlateLetters = 3,
    PlateNumbers = 3,
    PlateUseSpace = true,

    -- Drinking
    DrunkSystem = 1,
    -- 1 = auto-detect / built-in, resets drunk level after leaving casino
    -- 2 = esx_status
    -- 3 = evidence:client:SetStatus
    -- 4 = rcore_drunk -- https://store.rcore.cz/package/5161129

    -- Other Resources
    EnableGuidebookIntegration = false, -- https://store.rcore.cz/package/5041989

    -- Society
    -- ⚠️ In order to make society work, please follow these instructions: https://documentation.rcore.cz/paid-resources/rcore_casino/society
    EnableSociety = false, -- whether to enable society account
    SocietyName = "society_casino",
    SocietyLimitFromBalance = 10000, -- if society account has less money than this, it will start paying out reduced money, (SocietyLimitPayoutPercentage)
    SocietyLimitPayoutPercentage = 35, -- example: if SocietyLimitPayoutPercentage is 35%, and SocietyLimitFromBalance is 10000 => 1000 payout at the Cashier will be limited to 350, if the society bank account balance is less than 10 000
    -- when enabled, all casino payments (Cashier, Bar, Lucky Wheel) go through the society account, players don't get paid if there's not enough money in the 
    SocietyFramework = "addon_account_data",
    --[[
    'default': default, using events, qb-bossmenu/qb-management for QB, esx_addonaccount:getSharedAccount for ESX
    'okokbanking': editing the society row using mysql, table okokbanking_societies
    'addon_account_data': editing the society row using mysql, table addon_account_data
    '710-Management': using 710-Management export functions
    for more details open /server/main/society.lua
    ]]

    -- Notifications
    NotifySystem = 1,
    --[[
    1: default GTAV style notifications
    2: okokNotify
    3: esx_notify
    4: qb_notify,
    5: ox_notify
    ]]

    -- Job
    BossGrade = 2, -- the max grade (boss) for the casino job
    BossName = "boss",
    JobName = "casino", -- id of the job (not a title, I guess, don't change it)

    -- Teleport In & Out
    LeaveThroughTeleport = false, -- if enabled, people won't be able to leave the casino building, instead, they get prompted once they come near the entrance (useful if your map is too far from Los Santos)
    EnterPosition = vector3(2469.584473, -280.015869, -58.267620),
    EnterCheckpointPosition = vector3(923.470093, 47.249229, 79.8), -- custom marker for entering the casino, for example, in front of your custom Casino building in a different city, etc.
    LeavePosition = vector3(919.127380, 51.120274, 80.898659), -- where the player appears *after leaving*, for example, in front of your custom Casino building in a different city, etc.
    LeaveArea = vector3(2468.992188, -287.276459, -58.267506), -- where the player is prompted to leave the casino, for example, in front of the main doors,

    -- Ui
    UIFontName = nil, -- font for the UI, set to nil, if you don't want to use a custom font, set to a font name (with ""), if you wanna register and use a font that's inside your /stream/fonts folder
    ShowHowToPlayUI = 1, -- How to play/Info about the game UI (Menu that shows after pressing 'E' to play. (0: disabled, 1: only once, 2: every time after pressing 'E')
    ShowChipsHud = true, -- whether to use the built-in chips hud on the top-right corner
    UseNUIHUD = false, -- whether to use chips hud on NUI (you can customize it in 'html/index.html')

    -- Database
    MongoDB = false, -- if you decide to use MongoDB instead of MYSQL, don't forget to edit your MongoDB queries in: server/main/cache.lua, server/main/casino.lua and server/utils/plateGenerator.lua

    -- Mysql Resources
    Ghmattimysql = false, -- if you're using "ghmattimysql" instead of mysql-async

    -- Tweaks
    VoiceTweak = false, -- keep it false, if you don't have amy voice problems inside casino
    VehicleRGBTweak = false -- save podium vehicle colors as RGB array (color1, color2), instead of numbers
}

Framework = {
    -- ⚠️ For Standalone version docs visit https://documentation.rcore.cz/paid-resources/rcore_casino/standalone-version
    -- ⚠️ For Custom framework version docs visit https://documentation.rcore.cz/paid-resources/rcore_casino/custom-framework

    Active = 1, -- Choose 1 for ESX, 2 for QBCore, 3 for Standalone, 4 for Custom, 5 for auto detect
    -- Please follow the installation tutorial: --
    -- https://documentation.rcore.cz/paid-resources/rcore_casino

    -- esx resource name + shared object name
    ES_EXTENDED_RESOURCE_NAME = "Framework",
    ESX_SHARED_OBJECT = "esx:getSharedObject",
    -- esx extra settings
    BUILTIN_HUD_CHIPS = false,
    BUILTIN_HUD_CHIPS_ICON = "casinochip.png",
    -- qbcore resource name + shared object name
    QB_CORE_RESOURCE_NAME = "qb-core",
    QBCORE_SHARED_OBJECT = "QBCore:GetObject",
    -- standalone settings
    STANDALONE_INITIAL_CHIPS = 100000 -- chips that everyone gets after first enter
}

if Framework.Active == 2 then
    Config.PlateLetters = 4
    Config.PlateNumbers = 4
    Config.PlateUseSpace = false
end

Events = {
    QB_PLAYER_LOADED = "QBCore:Client:OnPlayerLoaded",
    QB_PLAYER_JOB_UPDATE = "QBCore:Client:OnJobUpdate",
    QB_BOSS_MENU = "qb-bossmenu:client:OpenMenu",
    -- use "qb-bossmenu:client:OpenMenu" for qb-management and "qb-bossmenu:client:openMenu" for qb-bossmenu

    ES_PLAYER_LOADED = "esx:playerLoaded",
    ES_PLAYER_JOB_UPDATE = "esx:setJob",
    ES_BOSS_MENU = "esx_society:openBossMenu"
}

GameplayKeys = {
    TableGamesMaxBet = 44, -- Choose between: (Tab = 204, E = 46, Q = 44, D = 134, Page Down = 207)
    TableGamesGrabCards = 207,
    RouletteHistoryKey = 204
}

AdminGroup = {
    ["founder"] = true,
}

-- Enable / Disable individual games/activities
GameStates = {{
    activity = "slots",
    title = "Slot Machines",
    enabled = true
}, {
    activity = "luckywheel",
    title = "Lucky Wheel",
    enabled = true
}, {
    activity = "insidetrack",
    title = "Inside Track",
    enabled = true
}, {
    activity = "drinkingbar",
    title = "Drinking Bar",
    enabled = true
}, {
    activity = "roulette",
    title = "Roulette",
    enabled = true
}, {
    activity = "poker",
    title = "Poker",
    enabled = true
}, {
    activity = "blackjack",
    title = "Blackjack",
    enabled = true
}, {
    activity = "cashier",
    title = "Cashier",
    enabled = true
}, {
    activity = "seating",
    title = "Seating",
    enabled = true
}, {
    activity = "cameras",
    title = "Cameras",
    enabled = true
}, {
    activity = "casinoteleporter",
    title = "Casino Teleporter (In)",
    enabled = true
}, {
    activity = "casinoentrance",
    title = "Casino Entrance",
    enabled = true
}}

-- opening hours
-- examples:
-- [1] = {0, 1, 2, 3, 4, 5, 6} -- From 0:00 til 6 AM 
-- [1] = {-1} -- Open all day

Config.OpeningHours = {
    [1] = {-1}, -- Sunday
    [2] = {-1}, -- Monday
    [3] = {-1}, -- Tuesday
    [4] = {-1}, -- Wednesday
    [5] = {-1}, -- Thursday
    [6] = {-1}, -- Friday
    [7] = {-1} -- Saturday
}

Config.ServerTimezoneOffsetHours = 0 -- Adjusts the server time based on the timezone difference

-- customize the blip function here
-- used blip icon ids: 
-- Inside Track: 684, Lucky Wheel: 681, Cashier: 683, Table Games: 680, VIP Area / Exterior Icon: 679, 
-- [https://docs.fivem.net/docs/game-references/blips/]

function SetCasinoBlip(coords, blipIcon, blipName, exterior)
    local blip = AddBlipForCoord(coords)
    --------------
    SetBlipSprite(blip, blipIcon)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.2)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, exterior and Config.CASINO_BLIPS_SHORT_RANGE or false)
    --------------
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipName)
    EndTextCommandSetBlipName(blip)
    if not exterior then
        table.insert(CasinoBlips, blip)
    end
    return blip
end

function RemoveMissionBlip(name)
    if MissionBlips[name] then
        RemoveBlip(MissionBlips[name])
        MissionBlips[name] = nil
    end
end

-- auto-detect framework
if Framework.Active == 5 then
    local esxState = GetResourceState(Framework.ES_EXTENDED_RESOURCE_NAME)
    local qbState = GetResourceState(Framework.QB_CORE_RESOURCE_NAME)

    if esxState == "starting" or esxState == "started" then
        print("^3[Casino] Framework ^2ESX^3 detected.^7")
        Framework.Active = 1
    elseif qbState == "starting" or qbState == "started" then
        print("^3[Casino] Framework ^2QBCore^3 detected.^7")
        Framework.Active = 2
    else
        Framework.Active = 3
    end
end

-- auto detect drunk system
if Config.DrunkSystem == 1 then
    local rcoreDrunkState = GetResourceState("rcore_drunk")
    local esxStatusState = GetResourceState("esx_status")

    if rcoreDrunkState == "starting" or rcoreDrunkState == "started" then
        Config.DrunkSystem = 4
        print("^3[Casino] ^2rcore_drunk^3 detected.^7")
    elseif esxStatusState == "starting" or esxStatusState == "started" then
        Config.DrunkSystem = 2
        print("^3[Casino] ^2esx_status^3 detected.^7")
    elseif Framework.Active == 2 then
        Config.DrunkSystem = 3
        print("^3[Casino] drunk system set to ^2evidence:^3.^7")
    end
end

-- used for translations
Translation = {}
function Translation.Get(str)
    if not Translation[Config.Locale] then
        print(string.format("[%s] The language does not exists: %s", GetCurrentResourceName(), Config.Locale))
        return string.format("The language does not exists: %s", Config.Locale)
    end
    if not Translation[Config.Locale][str] then
        print(string.format("[%s] The translation does not exists: %s", GetCurrentResourceName(), str))
        return string.format("The translation does not exists: %s", str)
    end
    return Translation[Config.Locale][str]
end

-- used for missions
local jobsState = GetResourceState("rcore_casino_jobs")
Config.JobsEnabled = jobsState == "starting" or jobsState == "started"
if Config.JobsEnabled then
    Config.Jobs = exports["rcore_casino_jobs"]:GetJobsConfig()
end
