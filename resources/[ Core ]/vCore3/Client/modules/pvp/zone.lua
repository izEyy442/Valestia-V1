--[[
----
----Created Date: 7:24 Tuesday March 14th 2023
----Author: vCore3
----Made with ❤
----
----File: [zone]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local IsInPVP = false;
local vehicleTimer = Shared.Timer(2);
local tasks = {};
local tags = {};
local activeTags = true;

local _vector3 = vector3;
local _GetGamePool = GetGamePool;
local _PlayerPedId = PlayerPedId;
local _GetPedArmour = GetPedArmour;
local _SetPedArmour = SetPedArmour;
local _IsPedAPlayer = IsPedAPlayer;
local _GetEntityCoords = GetEntityCoords;
local _SetEntityCoords = SetEntityCoords;
local _RemoveMpGamerTag = RemoveMpGamerTag;
local _IsMpGamerTagFree = IsMpGamerTagFree;
local _GetVehiclePedIsIn = GetVehiclePedIsIn;
local _SetPedIntoVehicle = SetPedIntoVehicle;
local _IsVehicleSeatFree = IsVehicleSeatFree;
local _IsMpGamerTagActive = IsMpGamerTagActive;
local _SetVehicleEngineOn = SetVehicleEngineOn;
local _CreateFakeMpGamerTag = CreateFakeMpGamerTag;
local _IsControlJustReleased = IsControlJustReleased;
local _GetVehiclePedIsEntering = GetVehiclePedIsEntering;
local _ClearPedTasksImmediately = ClearPedTasksImmediately;
local _GetIsVehicleEngineRunning = GetIsVehicleEngineRunning;
local _GetSeatPedIsTryingToEnter = GetSeatPedIsTryingToEnter;
local _SetEntityNoCollisionEntity = SetEntityNoCollisionEntity;
local _GetOffsetFromEntityInWorldCoords = GetOffsetFromEntityInWorldCoords;

Shared.Events:OnNet("vCore3:Valestia:updatePVPMode", function(isEnabled)

    if (isEnabled) then

        TriggerServerEvent("vCore3:Valestia:playerSwitchPVPMode");
        TriggerEvent("vCore3:Valestia:pvpModeUpdated", true);

        if (not IsInPVP) then

            IsInPVP = true;

            Client.Player:Teleport(3409.5784, -1033.6443, 69.5176, 270.1259);

            SetTimeout(2000, function()

                CreateThread(function()
                    Visual.PromptDuration(5000, "/pvpexit pour sortir de la zone de combat.");

                    while (IsInPVP) do

                        local ms = 0;

                        local ped = _PlayerPedId();
                        local coords = _GetEntityCoords(ped);

                        if ( #(_vector3(3409.5784, -1033.6443, 69.5176) - coords) > 2000 ) then

                            ms = 1000;
                            Game.Notification:ShowSimple("Vous êtes trop éloignez de la zone de combat, redirection...");
                            Client.Player:Teleport(3409.5784, -1033.6443, 69.5176, 270.1259);

                        else

                            ms = 0;

                            SetPlayerStamina(ped, 100);

                            local vehicle = _GetVehiclePedIsIn(ped)
                            local isEngineRunning = _GetIsVehicleEngineRunning(vehicle);

                            --VEHICLE OUT / IN
                            if (_IsControlJustReleased(2, 23)) then

                                if (vehicle ~= 0) then
                                    _SetEntityCoords(ped, _GetOffsetFromEntityInWorldCoords(vehicle, -3.0, 0.0, 0.0));
                                end

                                local enteringVehicle = _GetVehiclePedIsEntering(ped);

                                if (enteringVehicle ~= 0) then

                                    if (#(_GetEntityCoords(enteringVehicle) - coords) < 5) then

                                        if (vehicleTimer:HasPassed()) then

                                            vehicleTimer:Start();
                                            if (_IsVehicleSeatFree(enteringVehicle, -1)) then
                                                _SetPedIntoVehicle(ped, enteringVehicle, -1);
                                            else
                                                _SetPedIntoVehicle(ped, enteringVehicle, _GetSeatPedIsTryingToEnter(ped));
                                            end

                                        else
                                            _ClearPedTasksImmediately(ped);
                                        end

                                    else
                                        _ClearPedTasksImmediately(ped);
                                    end

                                end

                            end

                            --VEHICLE ENGINE
                            if (not isEngineRunning) then
                                _SetVehicleEngineOn(vehicle, true, true, false);
                            end

                            --NO VEHICLE COLISSION WITH PLAYER
                            local vehicles = GetGamePool("CVehicle");

                            for i = 1, #vehicles do
                                _SetEntityNoCollisionEntity(ped, vehicles[i], true);
                                _SetEntityNoCollisionEntity(vehicles[i], ped, true);
                            end

                            --NO KEVLAR
                            if (_GetPedArmour(ped) > 0) then
                                _SetPedArmour(ped, 0);
                                Game.Notification:ShowSimple("~y~Pas de kevlar ici.");
                            end

                            local players = _GetGamePool("CPed");

                            for i = 1, #players do

                                if (players[i] ~= ped) then

                                    if (_IsPedAPlayer(players[i])) then

                                        local pCoords = _GetEntityCoords(players[i]);
                                        local dist = #(coords - pCoords) < 50;
                                        local maxHealth = GetEntityMaxHealth(players[i]);
                                        local health = GetEntityHealth(players[i]);

                                        if (not tasks[players[i]]) then
                                            tasks[players[i]] = {};
                                        end

                                        if (maxHealth/100 >= health and not tasks[players[i]].deathThread) then
                                            tasks[players[i]].deathThread = true;
                                            tasks[players[i]].alpha = 100;

                                            SetTimeout(5200, function()
                                                tasks[players[i]].deathThread = false;
                                                SetEntityAlpha(players[i], 255);
                                            end);

                                            CreateThread(function()
                                                while (tasks[players[i]].deathThread) do

                                                    if (tasks[players[i]].alpha == 100) then
                                                        tasks[players[i]].alpha = 200;
                                                    else
                                                        tasks[players[i]].alpha = 100;
                                                    end

                                                    SetEntityAlpha(players[i], tasks[players[i]].alpha);

                                                    Wait(250);
                                                end
                                            end);

                                        end

                                        if (activeTags) then
                                            if (dist) then

                                                if (_IsMpGamerTagFree(tags[players[i]])) then
                                                    tags[players[i]] = _CreateFakeMpGamerTag(players[i], "", false, false, "", 0);
                                                end

                                                SetMpGamerTagAlpha(tags[players[i]], 0, 255);
                                                SetMpGamerTagAlpha(tags[players[i]], 2, 255);
                                                SetMpGamerTagAlpha(tags[players[i]], 4, 255);
                                                SetMpGamerTagAlpha(tags[players[i]], 7, 255);
                                                SetMpGamerTagColour(tags[players[i]], 7, 55);
                                                SetMpGamerTagHealthBarColour(tags[players[i]], 0);
                                                SetMpGamerTagColour(tags[players[i]], 4, 0);
                                                SetMpGamerTagColour(tags[players[i]], 0, 0);
                                                SetMpGamerTagVisibility(tags[players[i]], 0, true);
                                                SetMpGamerTagVisibility(tags[players[i]], 2, true);

                                                if (tasks[players[i]].deathThread) then

                                                    SetMpGamerTagVisibility(tags[players[i]], 6, true);

                                                else

                                                    SetMpGamerTagVisibility(tags[players[i]], 6, false);

                                                end

                                            else

                                                if (_IsMpGamerTagActive(tags[players[i]])) then
                                                    _RemoveMpGamerTag(tags[players[i]]);
                                                end
                                                tags[players[i]] = nil;

                                            end

                                        else

                                            for pedId, gamerTag in pairs(tags) do
                                                if (_IsMpGamerTagActive(gamerTag)) then
                                                    _RemoveMpGamerTag(gamerTag);
                                                end
                                                tags[pedId] = nil;
                                            end

                                        end

                                    end

                                end

                            end

                        end

                        Wait(ms);

                    end

                end);

            end);

        end

    else

        tasks = {};
        for pedId, gamerTag in pairs(tags) do
            if (_IsMpGamerTagActive(gamerTag)) then
                _RemoveMpGamerTag(gamerTag);
            end
            tags[pedId] = nil;
        end

--        Client.Player:Teleport(484.7577, -916.5621, 26.2264, 253.7124);
        IsInPVP = false;

        TriggerServerEvent("vCore3:Valestia:playerSwitchPVPMode");
        TriggerEvent("vCore3:Valestia:pvpModeUpdated", false);

    end

end);

---@type Timer
local timer = Shared.Timer(30);
local zone = Game.Zone("pvpZone");

local function togglePVP()

    if (timer:HasPassed()) then
        timer:Start();
        Shared.Events:ToServer("vCore3:Valestia:togglePVPMode");
    else
        Game.Notification:ShowSimple(("Vous devez patienter %s avant de pouvoir %s le mode PVP"):format(timer:ShowRemaining(), IsInPVP and "~b~désactiver" or "~b~activer"));
    end

end

zone:Start(function()

    zone:SetTimer(1000);
    zone:SetCoords(vector3(484.7577, -916.5621, 26.2264));

    zone:IsPlayerInRadius(50, function()
        zone:SetTimer(0);
        -- zone:Marker();

        zone:IsPlayerInRadius(2, function()

            -- zone:Text("La zone PVP est en maintenance, merci de votre patience.");
            zone:Text("");
            -- zone:Text(("Appuyez sur ~c~[~b~E~c~]~s~ pour %s~s~ le mode PVP"):format(IsInPVP and "~b~désactiver" or "~b~activer"));
            -- zone:KeyPressed("E", togglePVP);

        end, false, false);

    end, false, false);

end);

RegisterCommand("pvpexit", function()

    if (IsInPVP) then

        togglePVP();

    else

        Game.Notification:ShowSimple("~b~vCore3~s~ est pas débile...");

    end

end);

Game.Blip("pvpZone",
    {
--        coords = { x = 484.7577, y = -916.5621, z = 26.2264 },
        label = "[PVP] Zone PVP",
        sprite = 311,
        color = 49,
    }
);

local menu = RageUI.AddMenu("", "PVP Menu");
local sub = RageUI.AddSubMenu(menu, "", "Aide");
local leaderboardMenu = RageUI.AddSubMenu(menu, "", "Classement");
local leaderboard;
local leaderboard_data = {};

RegisterNetEvent("vCore3:Valestia:receiveLeaderBoard", function(data)
    if (type(data) == "table") then
        leaderboard = data;
        leaderboard_data = {};

        local temp = {};

        for identifier, data in pairs(leaderboard) do

            table.insert(temp, {

                name = data.name,
                identifier = identifier,
                kills = data.kills,
                death = data.death,

            });

        end

        table.sort(temp, function(a, b)
            return a.kills > b.kills;
        end);

        for k, v in pairs(temp) do
            leaderboard_data[k] = v
        end

        leaderboard = temp;

    else
        leaderboard = "ERROR";
    end
end);

menu:IsVisible(function (Items)

    Items:Separator("Zone de combat");
    Items:Line();

    -- Items:Button("Faire apparaitre un véhicule", nil, {}, true, {

    --     onSelected = function()
    --         ExecuteCommand("pvpv");
    --     end

    -- });

    -- Items:Checkbox("Afficher la vie des joueurs", nil, activeTags, {}, {

    --     onSelected = function(Checked)

    --         activeTags = Checked;

    --     end

    -- });

    -- Items:Button("Obtenir de l'aide", nil, {}, true, {}, sub);

    Items:Button("Afficher le classement général", nil, {}, true, {

        onSelected = function()
            TriggerServerEvent("vCore3:Valestia:requestLeaderBoard");
        end

    }, leaderboardMenu);


    Items:Line()

    Items:Button("Quitter la zone", nil, { Color = {

        BackgroundColor = RageUI.ItemsColour.Red

    } }, true, {

        onSelected = togglePVP;

    });

    if (not IsInPVP) then
        menu:Close();
    end

end);

sub:IsVisible(function (Items)

    Items:Separator("Commandes:");
    Items:Line();
    Items:Separator("/pvpv Faire apparaitre un véhicule");
    Items:Separator("/pvpexit Quitter la zone");
    Items:Separator();
    Items:Separator("Binding:");
    Items:Line();
    Items:Separator("Faire un raccourcis clavier:");
    Items:Separator("ex: F8 > bind keyboard F1 pvpv");

end);

local list = {"kills", "Morts", "Ratio", "Top 10 (Kills)"};
local currentSelection = 1;

leaderboardMenu:IsVisible(function (Items)

    if (type(leaderboard) == "table") then

        Items:List(("Trier par:"):format(list[currentSelection]), list, currentSelection, nil, {}, true, {

            onListChange = function(index)
                currentSelection = index;

                if (currentSelection == 1) then

                    table.sort(leaderboard, function(a, b)
                        return a.kills > b.kills;
                    end);

                elseif (currentSelection == 2) then

                    table.sort(leaderboard, function(a, b)
                        return a.death > b.death;
                    end);

                elseif (currentSelection == 3) then

                    table.sort(leaderboard, function(a, b)
                        return (a.kills / a.death) > (b.kills / b.death);
                    end);

                elseif (currentSelection == 4) then

                    table.sort(leaderboard, function(a, b)
                        return a.kills > b.kills;
                    end);

                end

                for k, v in pairs(leaderboard) do
                    leaderboard_data[k] = v
                end

            end

        });

        if (#leaderboard > 0) then

            for i = 1, #leaderboard_data do

                if (type(leaderboard_data[i]) == "table") then

                    if (currentSelection == 4 and i <= 10 or currentSelection ~= 4) then

                        local ratioValue = leaderboard_data[i].kills / leaderboard_data[i].death;
                        local ratio = ratioValue > 0.0 and Shared.Math:Round(ratioValue, 2) or 0.0

                        local data = {};
                        data["kills"] = leaderboard_data[i]["kills"];
                        data["death"] = leaderboard_data[i]["death"];
                        data["ratio"] = ratio;

                        Items:Button(leaderboard_data[i].name, ("Kills: ~b~%s~s~ Morts: ~b~%s~s~ Ratio: ~b~%s~s~"):format(
                            data["kills"], data["death"], data["ratio"]
                        ), {}, true, {});
                    end

                end

            end

        end

    elseif (leaderboard == "ERROR") then
        Items:Separator("Impossible de récupérer le classement.");
    else
        Items:Separator("Chargement du classement...");
    end

end);

Shared:RegisterKeyMapping("vCore3:pvp:menu", {
    label = "pvp_menu_key_desc"
}, "F3", function ()

    if (IsInPVP) then
        menu:Toggle();
    end

end);

local _Hash = GetHashKey;
local _GetSelectedPedWeapon = GetSelectedPedWeapon;

RegisterNetEvent("vCore3:Valestia:pvp:onKill", function()

    local ped = PlayerPedId();
    SetEntityHealth(ped, GetEntityMaxHealth(ped));

    local weapon = _GetSelectedPedWeapon(ped);

    if (weapon ~= _Hash("WEAPON_UNARMED")) then
        SetAmmoInClip(ped, weapon, GetMaxAmmoInClip(ped, weapon, true));
    end

end);