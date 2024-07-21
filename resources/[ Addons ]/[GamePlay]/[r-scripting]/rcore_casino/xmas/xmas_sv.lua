XMAS_TREES = {}

table.insert(XMAS_TREES, {
    position = vector3(0.0, 0.0, 0.0),
    heading = 0.0,
    rewardMin = 100, -- min. amount
    rewardMax = 1000, -- max amount
    rewardChooseFrom = {Config.ChipsInventoryItem}, -- choose reward randomly from these inventory items
    cooldown = (60 * 60 * 24) -- 24 hours
})
table.insert(XMAS_TREES, {
    position = vector3(0.0, 0.0, 0.0),
    heading = 0.0,
    rewardMin = 100,
    rewardMax = 1000,
    rewardChooseFrom = {Config.ChipsInventoryItem},
    cooldown = (60 * 60 * 24)
})

-- load tree coords from map preset
if Config.MapType == 1 then
    XMAS_TREES[1].position = vector3(922.34417, 39.01713, 71.1567)
    XMAS_TREES[1].heading = -45.0
    XMAS_TREES[2].position = vector3(967.36065, 48.62191, 69.686)
    XMAS_TREES[2].heading = 140.0
elseif Config.MapType == 2 or Config.MapType == 3 then
    XMAS_TREES[1].position = vector3(958.52392, 35.96862, 70.84322)
    XMAS_TREES[1].heading = -45.0
    XMAS_TREES[2].position = vector3(1008.65563, 46.41557, 69.3734)
    XMAS_TREES[2].heading = 160.0
elseif Config.MapType == 4 then
    XMAS_TREES[1].position = vector3(944.8862, 48.21997, 79.9)
    XMAS_TREES[1].heading = 40.0
    XMAS_TREES[2].position = vector3(968.13952, 50.96340, 80.45)
    XMAS_TREES[2].heading = 240.0
elseif Config.MapType == 5 then
    XMAS_TREES[1].position = vector3(2466.7766, -286.4762, -59.5143)
    XMAS_TREES[1].heading = -45.0
    XMAS_TREES[2].position = vector3(2503.8876, -251.5882, -60.8853)
    XMAS_TREES[2].heading = 160.0
end

-- load xmas trees for player
RegisterNetEvent("Casino:LoadXmas")
AddEventHandler("Casino:LoadXmas", function()
    local playerId = source
    local identifier = GetPlayerIdentifier(playerId)
    local cache = Cache:GetNow(identifier)
    local cooldowns = json.decode(cache.xmasCooldowns) or {}
    local trees = {}

    -- load player cooldowns for trees
    for i = 1, #XMAS_TREES do
        local v = XMAS_TREES[i]
        local x = {
            position = v.position,
            heading = v.heading,
            id = i
        }
        if cooldowns[i] then
            x.cooldownUntil = cooldowns[i]
        end
        table.insert(trees, x)
    end

    TriggerClientEvent("Casino:LoadXmas", playerId, trees)
end)

-- use xmas tree
RegisterNetEvent("Casino:XmasUseTree")
AddEventHandler("Casino:XmasUseTree", function(treeId)
    local playerId = source

    if not Config.Xmas then
        return
    end

    -- tree doesn't exist
    local tree = XMAS_TREES[treeId]
    if not tree then
        return
    end

    -- load player
    local identifier = GetPlayerIdentifier(playerId)
    local cache = Cache:GetNow(identifier)
    local cooldowns = json.decode(cache.xmasCooldowns) or {}

    -- in cooldown
    if cooldowns and cooldowns[treeId] and os.time() < cooldowns[treeId] then
        return
    end

    -- save cooldown
    local cooldown = os.time() + tree.cooldown
    cooldowns[treeId] = cooldown
    cache.xmasCooldowns = json.encode(cooldowns)

    -- send reward
    local randomItem = GetRandomItem(tree.rewardChooseFrom)
    local randomAmount = math.ceil(RandomNumber(tree.rewardMin, tree.rewardMax))
    TriggerClientEvent("Casino:XmasUseTree", playerId, treeId, randomItem, randomAmount, cooldown)
    Wait(3000)
    AddCasinoItem(playerId, randomItem, randomAmount)
end)
