local Trees = {}

-- got tree datas
RegisterNetEvent("Casino:LoadXmas")
AddEventHandler("Casino:LoadXmas", function(trees)
    Trees = trees
    CreateThread(function()
        local treeModel = GetHashKey("ch_prop_ch_diamond_xmastree")
        RequestModelAndWait(treeModel)
        for k, v in pairs(Trees) do
            v.entity = CreateObject(treeModel, v.position, false, false, false)
        end
        SetModelAsNoLongerNeeded(treeModel)
    end)
end)

-- got reward from using tree
RegisterNetEvent("Casino:XmasUseTree")
AddEventHandler("Casino:XmasUseTree", function(treeId, randomItem, randomAmount, cooldown)
    Trees[treeId].cooldownUntil = cooldown
    InfoPanel_UpdateNotification(nil)
    if randomItem == Config.ChipsInventoryItem then
        randomItem = Translation.Get("CHIPS")
    end
    local m = string.format(Translation.Get("XMAS_YOU_GOT_X"), randomItem, randomAmount)
    local tree = Trees[treeId]
    CreateThread(function()
        local animDict = "missfbi_s4mop"
        local animName = "plant_bomb_a"
        local offset = GetObjectOffsetFromCoords(tree.position.x, tree.position.y, tree.position.z,
            tree.heading + 180.0, -0.5, -1.7, 0.2)
        RequestAnimDictAndWait(animDict)
        local s = PlaySynchronizedScene(offset, vector3(0.0, 0.0, tree.heading + 180.0), animDict, animName, false)
        Wait(3000)
        ScenePed_AnnounceEnd()
        ClearPedTasks(PlayerPedId())
        FullscreenPrompt(Translation.Get("XMAS_TREE"), m, nil, nil)
        PlaySoundFrontend(-1, "Enter_1st", "GTAO_Magnate_Boss_Modes_Soundset", true)
    end)
end)

-- destroy all trees after leaving
function Xmas_Destroy()
    for k, v in pairs(Trees) do
        if v.entity and DoesEntityExist(v.entity) then
            ForceDeleteEntity(v.entity)
        end
    end
end

-- get tree from coords
function Xmas_GetTree(position)
    for k, v in pairs(Trees) do
        if #(v.position - position) < 2.2 then
            return v
        end
    end
    return nil
end

-- show *press E* notify
function Xmas_ShowNotify(tree)
    if tree.cooldownUntil and SERVER_TIMER < tree.cooldownUntil then
        local cooldown = tree.cooldownUntil - SERVER_TIMER
        if cooldown < (60 * 60 * 24) * 7 then
            local untilFormatted = FormatTimestamp(cooldown)
            InfoPanel_UpdateNotification(string.format(Translation.Get("XMAS_ALREADY_GOT_COOLDOWN"), untilFormatted))
        else
            InfoPanel_UpdateNotification(Translation.Get("XMAS_ALREADY_GOT"))
        end
        return
    end
    InfoPanel_UpdateNotification(Translation.Get("XMAS_PRESS_E"))
end

-- *E* pressed on tree
function Xmas_Action(tree)
    BlockPlayerInteraction(1000)
    TriggerServerEvent("Casino:XmasUseTree", tree.id)
end
