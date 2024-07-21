DrugsHandler.Anim = {}
DrugsHandler.Anim.Synchronised = {}

function SynchronisedScene()
    return DrugsHandler.Anim.Synchronised 
end

DrugsHandler.Anim.Synchronised = {
    Defaults = {
        SceneConfig = {
          position      = vector3(0.0,0.0,0.0),
          rotation      = vector3(0.0,0.0,0.0),
          rotOrder      = 2,
          useOcclusion  = false,
          loop          = false,
          unk1          = 1.0,
          animTime      = 0,
          animSpeed     = 1.0, 
        },
        PedConfig = {
            blendIn       = 1.0,
            blendOut      = 1.0,
            duration      = 0,
            flag          = 0,
            speed         = 1.0,
            unk1          = 0,
        },
        EntityConfig = {
            blendIn       = 1.0,
            blendOut      = 1.0,
            flags         = 1,
        }
    },
    Create = function(sceneConfig)    
        return NetworkCreateSynchronisedScene(sceneConfig.position,sceneConfig.rotation,sceneConfig.rotOrder,sceneConfig.useOcclusion,sceneConfig.loop,sceneConfig.unk1,sceneConfig.animTime,sceneConfig.animSpeed)
    end,
    SceneConfig = function(pos,rot,rotOrder,useOcclusion,loop,unk1,animTime,animSpeed)
        local DefaultValue = function(v1,v2) 
            if v1 ~= nil then 
                return v1 
            else 
                return DrugsHandler.Anim.Synchronised.Defaults["SceneConfig"][v2]; 
            end
        end
        local value = {}
        value.position     = DefaultValue(pos,"position")
        value.rotation     = DefaultValue(rot,"rotation")
        value.rotOrder     = DefaultValue(rotOrder,"rotOrder")
        value.useOcclusion = DefaultValue(useOcclusion,"useOcclusion")
        value.loop         = DefaultValue(loop,"loop")
        value.unk1         = DefaultValue(p9,"unk1")
        value.animTime     = DefaultValue(animTime,"animTime")
        value.animSpeed    = DefaultValue(animSpeed,"animSpeed")
        return value
    end,
    AddPed = function(pedConfig)
        return NetworkAddPedToSynchronisedScene(pedConfig.ped,pedConfig.scene,pedConfig.animDict,pedConfig.animName,pedConfig.blendIn,pedConfig.blendOut,pedConfig.duration,pedConfig.flag,pedConfig.speed,pedConfig.unk1)
    end,
    PedConfig = function(ped,scene,animDict,animName,blendIn,blendOut,duration,flag,speed,unk1)
        local DefaultValue = function(v1,v2) if v1 ~= nil then return v1 else return DrugsHandler.Anim.Synchronised.Defaults["PedConfig"][v2]; end; end
        local value = {}
        value.ped          = ped
        value.scene        = scene
        value.animDict     = animDict
        value.animName     = animName
        value.blendIn      = DefaultValue(blendIn,"blendIn")
        value.blendOut     = DefaultValue(blendOut,"blendOut")
        value.duration     = DefaultValue(duration,"duration")
        value.flag         = DefaultValue(flag,"flag")
        value.speed        = DefaultValue(speed,"speed")
        value.unk1         = DefaultValue(unk1,"unk1")
        return value
    end,
    AddEntity = function(entityConfig)
        return NetworkAddEntityToSynchronisedScene(entityConfig.entity,entityConfig.scene,entityConfig.animDict,entityConfig.animName,entityConfig.blendIn,entityConfig.blendOut,entityConfig.flags)
    end,
    EntityConfig = function(entity,scene,animDict,animName,blendIn,blendOut,flags)
        local DefaultValue = function(v1,v2) 
            if v1 ~= nil then 
                return v1 
            else 
                return DrugsHandler.Anim.Synchronised.Defaults["EntityConfig"][v2] 
            end 
        end
        local value = {}
        value.entity       = entity
        value.scene        = scene
        value.animDict     = animDict
        value.animName     = animName
        value.blendIn      = DefaultValue(blendIn,"blendIn")
        value.blendOut     = DefaultValue(blendOut,"blendOut")
        value.flags        = DefaultValue(flags,"flags")
        return value
    end,
    Start = function(scene)
        NetworkStartSynchronisedScene(scene)
    end,
    Stop = function(scene)
        NetworkStopSynchronisedScene(scene)
    end
}

local sceneObjects  = {}
local Scenes = SynchronisedScene()
local startTime

function SceneHandler(action, pos)
    local plyPed = PlayerPedId()
    local pPos = GetEntityCoords(plyPed)
    action.location = pos
    local sceneType = action.act
    local doScene = action.scene
    local actPos = action.location - action.offset
    local actRot = action.rotation
    local animDict = DrugsHandler.SceneDicts[sceneType][doScene]
    local actItems = DrugsHandler.ScenesList[sceneType][doScene]
    local actAnims = DrugsHandler.AnimsList[sceneType][doScene]
    local plyAnim = DrugsHandler.PlayerAnims[sceneType][doScene]
    while not HasAnimDictLoaded(animDict) do 
        RequestAnimDict(animDict)
        Wait(0)
    end
    local count = 1
    local objectCount = 0
    FreezeEntityPosition(PlayerPedId(), true)
    for k,v in pairs(actItems) do
        local hash = GetHashKey(v)
        while not HasModelLoaded(hash) do RequestModel(hash)
            Wait(0) 
        end
        sceneObjects[k] = CreateObject(hash,actPos,true)
        SetModelAsNoLongerNeeded(hash)
        objectCount = objectCount + 1
        while not DoesEntityExist(sceneObjects[k]) do 
            Wait(0)
        end
        SetEntityCollision(sceneObjects[k],false,false)
    end
    local scenes = {}
    local sceneConfig = Scenes.SceneConfig(actPos,actRot,2,false,false,1.0,0,1.0)
    for i=1,math.max(1,math.ceil(objectCount/3)),1 do
        scenes[i] = Scenes.Create(sceneConfig)
    end
    local pedConfig = Scenes.PedConfig(plyPed,scenes[1],animDict,plyAnim)
    Scenes.AddPed(pedConfig)
    for k,animation in pairs(actAnims) do      
        local targetScene = scenes[math.ceil(count/3)]
        local entConfig = Scenes.EntityConfig(sceneObjects[k],targetScene,animDict,animation)
        Scenes.AddEntity(entConfig)
        count = count + 1
    end
    local extras = {}
    if action.extraProps then
        for k,v in pairs(action.extraProps) do
            RequestAndWaitModel(v.model)
            local obj = CreateObject(GetHashKey(v.model), actPos + v.pos, true,true,true)
            while not DoesEntityExist(obj) do Wait(0); end
            SetEntityRotation(obj,v.rot)
            FreezeEntityPosition(obj,true)
            extras[#extras+1] = obj
        end
    end
    startTime = GetGameTimer()
    treatmentTimeout = true 
    for i=1,#scenes,1 do
        Scenes.Start(scenes[i])
    end
    Wait(action.time)
    for i=1,#scenes,1 do
        Scenes.Stop(scenes[i])
    end
    treatmentTimeout = false 
    for k,v in pairs(extras) do
        DeleteObject(v)
    end
    RemoveAnimDict(animDict)
    FreezeEntityPosition(PlayerPedId(), false)
    for k,v in pairs(sceneObjects) do 
        NetworkFadeOutEntity(v, false, false)
    end
end

