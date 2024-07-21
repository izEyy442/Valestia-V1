function EnsureTarget()
    if (Config.target.enabled and Config.target.system) then

        local system = Config.target.system


        local options = {
            {
                type = "client",
                event = "kq_outfitbag:targetOpen",
                icon = "fas fa-suitcase",
                label = L('Open Bag'),
                canInteract = function(entity)
                    return IsEntityAMissionEntity(entity) and (Entity(entity).state.public or Entity(entity).state.owner == GetPlayerServerId(PlayerId()))
                end,
                distance = 1.75,
            },
            {
                type = "client",
                event = "kq_outfitbag:targetPickup",
                icon = "fas fa-arrow-up",
                label = L('Pickup the bag'),
                canInteract = function(entity)
                    return IsEntityAMissionEntity(entity) and (Entity(entity).state.owner == GetPlayerServerId(PlayerId()))
                end,
                distance = 1.75,
            },
            {
                type = "client",
                event = "kq_outfitbag:targetMakePublic",
                icon = "fas fa-eye",
                label = L('Make public'),
                canInteract = function(entity)
                    return IsEntityAMissionEntity(entity) and (Entity(entity).state.owner == GetPlayerServerId(PlayerId())) and not Entity(entity).state.public
                end,
                distance = 1.75,
            },
            {
                type = "client",
                event = "kq_outfitbag:targetMakePrivate",
                icon = "fas fa-lock",
                label = L('Make private'),
                canInteract = function(entity)
                    return IsEntityAMissionEntity(entity) and (Entity(entity).state.owner == GetPlayerServerId(PlayerId())) and Entity(entity).state.public
                end,
                distance = 1.75,
            },
        }

        if system == 'ox_target' then
            exports[system]:addModel({GetHashKey(Config.bagObject)}, options)
        else
            exports[system]:AddTargetModel({GetHashKey(Config.bagObject)}, {
                options = options,
                distance = 1.75,
            })
        end
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    EnsureTarget()
end)