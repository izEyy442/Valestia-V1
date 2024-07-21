RegisterNetEvent("ServerEmoteRequest", function(target, emotename, etype)
    local ped = GetPlayerPed(source)
    local xPlayer = ESX.GetPlayerFromId(source) 

    if target == -1 then
        xPlayer.ban(0, '(ServerEmoteRequest)')
      return
   end
   local tped = GetPlayerPed(target)
   local pedcoord = GetEntityCoords(ped)
   local targetcoord = GetEntityCoords(tped)

   local distance = #(pedcoord - targetcoord)

   if distance > 15 then
        xPlayer.ban(0, '(ServerEmoteRequest)')
        return
   end
    TriggerClientEvent("ClientEmoteRequestReceive", target, emotename, etype)
end)

RegisterNetEvent("JEVALIDELADANCE", function(target, requestedemote, otheremote)
    local ped = GetPlayerPed(source)
    local xPlayer = ESX.GetPlayerFromId(source) 

    if target == -1 then
        xPlayer.ban(0, '(JEVALIDELADANCE)')
        return
   end
   local tped = GetPlayerPed(target)
   local pedcoord = GetEntityCoords(ped)
   local targetcoord = GetEntityCoords(tped)

   local distance = #(pedcoord - targetcoord)

   if distance > 10 then
    xPlayer.ban(0, '(JEVALIDELADANCE)')
    return
   end
    TriggerClientEvent("SyncPlayEmote", source, otheremote, target)
    TriggerClientEvent("SyncPlayEmoteSource", target, requestedemote, source)
end)

RegisterNetEvent("ServerEmoteCancel", function(target)
    TriggerClientEvent("SyncCancelEmote", target, source)
end)

RegisterNetEvent("rpemotes:ptfx:sync", function(asset, name, offset, rot, bone, scale, color)
    if type(asset) ~= "string" or type(name) ~= "string" or type(offset) ~= "vector3" or type(rot) ~= "vector3" then
        return
    end
    local srcPlayerState = Player(source).state
    srcPlayerState:set('ptfxAsset', asset, true)
    srcPlayerState:set('ptfxName', name, true)
    srcPlayerState:set('ptfxOffset', offset, true)
    srcPlayerState:set('ptfxRot', rot, true)
    srcPlayerState:set('ptfxBone', bone, true)
    srcPlayerState:set('ptfxScale', scale, true)
    srcPlayerState:set('ptfxColor', color, true)
    srcPlayerState:set('ptfxPropNet', false, true)
    srcPlayerState:set('ptfx', false, true)
end)

RegisterNetEvent("rpemotes:ptfx:syncProp", function(propNet)
    local srcPlayerState = Player(source).state
    if propNet then
        local waitForEntityToExistCount = 0
        while waitForEntityToExistCount <= 100 and not DoesEntityExist(NetworkGetEntityFromNetworkId(propNet)) do
            Wait(10)
            waitForEntityToExistCount = waitForEntityToExistCount + 1
        end

        if waitForEntityToExistCount < 100 then
            srcPlayerState:set('ptfxPropNet', propNet, true)
            return
        end
    end
    srcPlayerState:set('ptfxPropNet', false, true)
end)

local function addKeybindEventHandlers()
    RegisterNetEvent("rp:ServerKeybindExist", function()
        local src = source
        local srcid = GetPlayerIdentifier(source)
        MySQL.query('SELECT * FROM dpkeybinds WHERE `id`=@id;', { id = srcid }, function(dpkeybinds)
            if dpkeybinds[1] then
                TriggerClientEvent("rp:ClientKeybindExist", src, true)
            else
                TriggerClientEvent("rp:ClientKeybindExist", src, false)
            end
        end)
    end)

    RegisterNetEvent("rp:ServerKeybindCreate", function()
        local src = source
        local srcid = GetPlayerIdentifier(source)
        MySQL.insert('INSERT INTO dpkeybinds (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES (@id, @keybind1, @emote1, @keybind2, @emote2, @keybind3, @emote3, @keybind4, @emote4, @keybind5, @emote5, @keybind6, @emote6);'
            ,
            { id = srcid, keybind1 = "num4", emote1 = "", keybind2 = "num5", emote2 = "", keybind3 = "num6", emote3 = "",
                keybind4 = "num7", emote4 = "", keybind5 = "num8", emote5 = "", keybind6 = "num9", emote6 = "" },
            function(created)
                TriggerClientEvent("rp:ClientKeybindGet"
                    , src, "num4", "", "num5", "", "num6", "", "num7", "", "num8", "", "num8", "")
            end)
    end)

    RegisterNetEvent("rp:ServerKeybindGrab", function()
        local src = source
        local srcid = GetPlayerIdentifier(source)
        MySQL.query('SELECT keybind1, emote1, keybind2, emote2, keybind3, emote3, keybind4, emote4, keybind5, emote5, keybind6, emote6 FROM `dpkeybinds` WHERE `id` = @id'
            ,
            { ['@id'] = srcid }, function(kb)
            if kb[1].keybind1 ~= nil then
                TriggerClientEvent("rp:ClientKeybindGet", src, kb[1].keybind1, kb[1].emote1, kb[1].keybind2, kb[1].emote2
                    , kb[1].keybind3, kb[1].emote3, kb[1].keybind4, kb[1].emote4, kb[1].keybind5, kb[1].emote5,
                    kb[1].keybind6, kb[1].emote6)
            else
                TriggerClientEvent("rp:ClientKeybindGet", src, "num4", "", "num5", "", "num6", "", "num7", "", "num8", ""
                    , "num8", "")
            end
        end)
    end)

    RegisterNetEvent("rp:ServerKeybindUpdate", function(key, emote)
        local src = source
        local myid = GetPlayerIdentifier(source)
        if key == "num4" then chosenk = "keybind1"
        elseif key == "num5" then chosenk = "keybind2"
        elseif key == "num6" then chosenk = "keybind3"
        elseif key == "num7" then chosenk = "keybind4"
        elseif key == "num8" then chosenk = "keybind5"
        elseif key == "num9" then chosenk = "keybind6"
        end
        if chosenk == "keybind1" then
            MySQL.update("UPDATE dpkeybinds SET emote1=@emote WHERE id=@id", { id = myid, emote = emote },
                function() TriggerClientEvent("rp:ClientKeybindGetOne", src, key, emote) end)
        elseif chosenk == "keybind2" then
            MySQL.update("UPDATE dpkeybinds SET emote2=@emote WHERE id=@id", { id = myid, emote = emote },
                function() TriggerClientEvent("rp:ClientKeybindGetOne", src, key, emote) end)
        elseif chosenk == "keybind3" then
            MySQL.update("UPDATE dpkeybinds SET emote3=@emote WHERE id=@id", { id = myid, emote = emote },
                function() TriggerClientEvent("rp:ClientKeybindGetOne", src, key, emote) end)
        elseif chosenk == "keybind4" then
            MySQL.update("UPDATE dpkeybinds SET emote4=@emote WHERE id=@id", { id = myid, emote = emote },
                function() TriggerClientEvent("rp:ClientKeybindGetOne", src, key, emote) end)
        elseif chosenk == "keybind5" then
            MySQL.update("UPDATE dpkeybinds SET emote5=@emote WHERE id=@id", { id = myid, emote = emote },
                function() TriggerClientEvent("rp:ClientKeybindGetOne", src, key, emote) end)
        elseif chosenk == "keybind6" then
            MySQL.update("UPDATE dpkeybinds SET emote6=@emote WHERE id=@id", { id = myid, emote = emote },
                function() TriggerClientEvent("rp:ClientKeybindGetOne", src, key, emote) end)
        end
    end)
end

if DPc.SqlKeybinding and MySQL then
    MySQL.update(
        [[
		CREATE TABLE IF NOT EXISTS `dpkeybinds` (
		  `id` varchar(50) NULL DEFAULT NULL,
		  `keybind1` varchar(50) NULL DEFAULT "num4",
		  `emote1` varchar(255) NULL DEFAULT "",
		  `keybind2` varchar(50) NULL DEFAULT "num5",
		  `emote2` varchar(255) NULL DEFAULT "",
		  `keybind3` varchar(50) NULL DEFAULT "num6",
		  `emote3` varchar(255) NULL DEFAULT "",
		  `keybind4` varchar(50) NULL DEFAULT "num7",
		  `emote4` varchar(255) NULL DEFAULT "",
		  `keybind5` varchar(50) NULL DEFAULT "num8",
		  `emote5` varchar(255) NULL DEFAULT "",
		  `keybind6` varchar(50) NULL DEFAULT "num9",
		  `emote6` varchar(255) NULL DEFAULT ""
		) ENGINE=InnoDB COLLATE=latin1_swedish_ci;
		]]     , {}, function(success)
        if success then
            addKeybindEventHandlers()
        end
    end)
end
