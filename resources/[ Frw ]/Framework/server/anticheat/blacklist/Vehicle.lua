--[[
----
----Created Date: 2:58 Friday February 24th 2023
----Author: vCore3
----Made with ❤
----
----File: [stopcheat]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local _GetEntityOwner = NetworkGetEntityOwner;
local _GetEntiyPopulationType = GetEntityPopulationType;
local _GetEntityType = GetEntityType;
local _GetEntityModel = GetEntityModel;
local debugVehicles = false;

local vehicles = {};

CreateThread(function()

    for i = 1, #Config.BlacklistedVehicles do

        if (type(Config.BlacklistedVehicles[i]) == "string") then

            local hash = GetHashKey(Config.BlacklistedVehicles[i]:lower());

            if (not vehicles[hash]) then

                vehicles[hash] = {

                    hash = hash,
                    name = Config.BlacklistedVehicles[i]

                };

            end

        end

    end

end);

ESX.AddGroupCommand("debugblv", "founder", function(src)

    local xPlayer = ESX.GetPlayerFromId(src);

    if (xPlayer ~= nil and ESX.IsAllowedForDanger(xPlayer)) then

        debugVehicles = not debugVehicles;
        xPlayer.showNotification("Debug vehicles: "..tostring(debugVehicles));

    end

end, { help = "Debug logs for blacklisted vehicles" });

AddEventHandler("entityCreating", function(entityHandle)

    local owner = _GetEntityOwner(entityHandle);
    local populationType = _GetEntiyPopulationType(entityHandle);
    local entityType = _GetEntityType(entityHandle);
    local entityModel = _GetEntityModel(entityHandle);

    if (entityType == 2) then

        if (vehicles[entityModel]) then

            local hash = vehicles[entityModel].hash;
            local xPlayer = ESX.GetPlayerFromId(owner);
            local name = GetPlayerName(owner);
            local identifier = ESX.GetIdentifierFromId(owner);

            if (populationType == 6 or populationType == 7) then

                if (xPlayer) then

                    if (xPlayer.getGroup() == "user") then

                        ESX.Logs.Info(('Player ^4%s^7 (^4%s)^0 has been banned for spawning a blacklisted vehicle ^7(^4%s ^0- ^4%s^7)'):format(xPlayer.getName(), xPlayer.identifier, hash, vehicles[hash].name));
                        DeleteEntity(entityHandle);
                        ExecuteCommand(('ban %s %s %s'):format(xPlayer.source, 0, 'Spawn Blacklist Vehicle ('..hash..' - '..vehicles[hash].name..')'));

                    else

                        if (not exports["vCore3"]:GroupHasPermission(xPlayer.getGroup(), "vehicle_spawn_blacklist")) then
                            DeleteEntity(entityHandle);
                            ESX.Logs.Info(('Admin ^4%s^7 (^4%s)^0 tried to spawn a blacklisted vehicle ^7(^4%s ^0- ^4%s^7)'):format(xPlayer.getName(), xPlayer.identifier, hash, vehicles[hash].name));
                        end

                    end

                else

                    if (type(name) == "string" and type(identifier) == "string") then
                        ESX.Logs.Info(('Player ^4%s^7 ^7(^4%s^7)^0 has been banned for spawning a blacklisted vehicle ^7(^4%s ^0- ^4%s^7)'):format(name, identifier, hash, vehicles[hash].name))
                    end

                    DeleteEntity(entityHandle);
                    ExecuteCommand(('ban %s %s %s'):format(owner, 0, 'Spawn Blacklist Vehicle ('..hash..' - '..vehicles[hash].name..')'));
                    
                end

            else

                if (debugVehicles) then

                    if (type(name) == "string" and type(identifier) == "string") then
                        ESX.Logs.Info(('Player ^4%s^7 ^7(^4%s^7)^0 tried to spawn a blacklisted vehicle ^7(^4%s ^0- ^4%s^7)'):format(name, identifier, hash, vehicles[hash].name));
                    end

                end
                
                DeleteEntity(entityHandle);

            end

        end

    end

end);