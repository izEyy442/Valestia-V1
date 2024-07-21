--[[
----
----Created Date: 2:14 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Vehicles]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type GameVehicle
GameVehicle = Class.new(function(class)

    ---@class GameVehicle: BaseObject
    local self = class;

    function self:Constructor()
        self.currentVehicle = nil;

        self.doors = {
            {
                index = -1, 
                state = false
            },
            {
                index = 0, 
                state = false
            },
            {
                index = 1, 
                state = false
            },
            {
                index = 2, 
                state = false
            },
            {
                index = 3, 
                state = false
            },
            {
                index = 4, 
                state = false
            },
            {
                index = 5, 
                state = false
            }

        };

        self:PlayerEventEntering();
        Shared:Initialized("Game.Vehicle");
    end

    ---@return number
    function self:GetCurrentVehicle()
        return self.currentVehicle;
    end

    ---@param vehicle number
    function self:SetCurrentVehicle(vehicle)
        self.currentVehicle = vehicle;
    end

    ---Check if the player is in a vehicle
    ---@private
    function self:PlayerEventEntering()
        Client:SubscribeToGameEvent("CEventNetworkPlayerEnteredVehicle", function(args)
            if (args[1] == Client.Player:GetId()) then

                if (args[2] == Client.Player:GetVehicle()) then
                
                    if (not self:GetCurrentVehicle() or self:GetCurrentVehicle() ~= args[1]) then
                        
                        self:SetCurrentVehicle(args[1]);
                        Shared.Events:Trigger(Enums.Vehicles.Events.EnteringVehicle, self:GetCurrentVehicle());
                        Shared.Events:ToServer(Enums.Vehicles.Events.PlayerEnteredVehicle, GetVehicleNumberPlateText(args[2]));

                        CreateThread(function()
                            while true do
                                if (not Client.Player:GetVehicle()) then
                                    Shared.Events:Trigger(Enums.Vehicles.Events.LeftVehicle, self:GetCurrentVehicle());
                                    self:ResetDoors();
                                    self:SetCurrentVehicle(nil);
                                    break;
                                end
                                Wait(100);
                            end
                        end);

                    elseif (self:GetCurrentVehicle() == args[1]) then
                        Shared.Events:Trigger(Enums.Vehicles.Events.SwitchVehicleSeat, self:GetCurrentVehicle());
                    end

                end

            end
        end);
    end

    ---@param vehicle number
    ---@param callback function
    function self:RequestControl(vehicle, callback)
        CreateThread(function()
            if (DoesEntityExist(vehicle)) then

                while not NetworkHasControlOfEntity(vehicle) and DoesEntityExist(vehicle) do
                    NetworkRequestControlOfEntity(vehicle);
                    Wait(0);
                end

                if (callback) then callback(); end

            end
        end);
    end

    ---When player switch seat
    ---@param callback fun(vehicle: number)
    function self:PlayerSwitchSeat(callback)
        Shared.Events:On(Enums.Vehicles.Events.SwitchVehicleSeat, callback);
    end

    ---When player is entering a vehicle
    ---@param callback fun(vehicle: number)
    function self:PlayerEntering(callback)
        Shared.Events:On(Enums.Vehicles.Events.EnteringVehicle, callback);
    end

    ---When player is leaving a vehicle
    ---@param callback fun(vehicle: number): void
    function self:PlayerLeft(callback)
        Shared.Events:On(Enums.Vehicles.Events.LeftVehicle, callback);
    end

    ---Toggle the engine of the vehicle
    ---@param vehicle number
    function self:ToggleEngine(vehicle)
        local veh = vehicle or Client.Player:GetVehicle();
        SetVehicleEngineOn(veh, not GetIsVehicleEngineRunning(veh), false, true);
    end

    ---@param coords table | vector3
    ---@param distance number
    function self:GetInArea(coords, distance)
        local vehiclesInPool = GetGamePool("CVehicle")
        local vehicles = {}
        for _, vehicle in pairs(vehiclesInPool) do
            local vehicleDist = #(vector3(coords.x, coords.y, coords.z) - GetEntityCoords(vehicle))

            if vehicleDist <= distance then
                vehicles[#vehicles + 1] = vehicle
            end
        end
        return vehicles
    end

    ---@param coords vector3 | table
    ---@param distance number
    ---@return number, number @vehicle, distance
    function self:GetClosest(coords, distance)
        local vehicles = self:GetInArea(coords, distance or 50);
        local closestVehicle;
        local closestDistance = -1;

        for i = 1, #vehicles do

            local vehicle = vehicles[i];
            local vehicleCoords = GetEntityCoords(vehicle);
            local vehicleDist = #(vector3(coords.x, coords.y, coords.z) - vehicleCoords);

            if (closestDistance == -1 or vehicleDist < closestDistance) then
                closestVehicle = vehicle;
                closestDistance = vehicleDist;
            end

        end

        return closestVehicle, closestDistance;
    end

    ---@param vehicle number
    function self:IsVehicleEmpty(vehicle)
        local passengers = GetVehicleNumberOfPassengers(vehicle)
        local driverSeatFree = IsVehicleSeatFree(vehicle, -1)

        return passengers == 0 and driverSeatFree
    end

    ---@param coords table | vector3
    ---@param maxDistance number
    function self:IsSpawnPointClear(coords, maxDistance)
        local vehicles = self:GetInArea(coords, maxDistance);
        local vehicleCount = 0;
        for _, _ in pairs(vehicles) do
            vehicleCount = (vehicleCount + 1);
        end
        return vehicleCount == 0
    end

    ---@return number, vector3
    function self:GetInDirection()
        local playerPed = Client.Player:GetPed();
        local playerCoords = GetEntityCoords(playerPed);
        local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0);
        local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(playerCoords, inDirection, 10, playerPed, 0);
        local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle);

        if (hit == 1 and GetEntityType(entityHit) == 2) then
            local entityCoords = GetEntityCoords(entityHit);
            return entityHit, entityCoords;
        end

        return nil;
    end

    ---crédits https://github.com/esx-framework/esx-legacy
    ---@param vehicle number
    function self:GetProperties(vehicle)
        if DoesEntityExist(vehicle) then
            local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            local hasCustomPrimaryColor = GetIsVehiclePrimaryColourCustom(vehicle)
            local customPrimaryColor = nil
            if hasCustomPrimaryColor then
                local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
                customPrimaryColor = {r, g, b}
            end

            local hasCustomSecondaryColor = GetIsVehicleSecondaryColourCustom(vehicle)
            local customSecondaryColor = nil
            if hasCustomSecondaryColor then
                local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
                customSecondaryColor = {r, g, b}
            end
            local extras = {}

            for extraId = 0, 12 do
                if DoesExtraExist(vehicle, extraId) then
                    local state = IsVehicleExtraTurnedOn(vehicle, extraId)
                    extras[tostring(extraId)] = state
                end
            end

            local doorsBroken, windowsBroken, tyreBurst = {}, {}, {}
            local numWheels = tostring(GetVehicleNumberOfWheels(vehicle))

            local TyresIndex = { -- Wheel index list according to the number of vehicle wheels.
                ['2'] = {0, 4}, -- Bike and cycle.
                ['3'] = {0, 1, 4, 5}, -- Vehicle with 3 wheels (get for wheels because some 3 wheels vehicles have 2 wheels on front and one rear or the reverse).
                ['4'] = {0, 1, 4, 5}, -- Vehicle with 4 wheels.
                ['6'] = {0, 1, 2, 3, 4, 5} -- Vehicle with 6 wheels.
            }

            if TyresIndex[numWheels] then
                for _, idx in pairs(TyresIndex[numWheels]) do
                    if IsVehicleTyreBurst(vehicle, idx, false) then
                        tyreBurst[tostring(idx)] = true
                    else
                        tyreBurst[tostring(idx)] = false
                    end
                end
            end

            for windowId = 0, 7 do -- 13
                if not IsVehicleWindowIntact(vehicle, windowId) then
                    windowsBroken[tostring(windowId)] = true
                else
                    windowsBroken[tostring(windowId)] = false
                end
            end

            local numDoors = GetNumberOfVehicleDoors(vehicle)
            if numDoors and numDoors > 0 then
                for doorsId = 0, numDoors do
                    if IsVehicleDoorDamaged(vehicle, doorsId) then
                        doorsBroken[tostring(doorsId)] = true
                    else
                        doorsBroken[tostring(doorsId)] = false
                    end
                end
            end

            return {
                model = GetEntityModel(vehicle),
                doorsBroken = doorsBroken,
                windowsBroken = windowsBroken,
                tyreBurst = tyreBurst,
                plate = Shared.Math:Trim(GetVehicleNumberPlateText(vehicle)),
                plateIndex = GetVehicleNumberPlateTextIndex(vehicle),

                bodyHealth = Shared.Math:Round(GetVehicleBodyHealth(vehicle), 1),
                engineHealth = Shared.Math:Round(GetVehicleEngineHealth(vehicle), 1),
                tankHealth = Shared.Math:Round(GetVehiclePetrolTankHealth(vehicle), 1),

                fuelLevel = Shared.Math:Round(GetVehicleFuelLevel(vehicle), 1),
                dirtLevel = Shared.Math:Round(GetVehicleDirtLevel(vehicle), 1),
                color1 = colorPrimary,
                color2 = colorSecondary,
                customPrimaryColor = customPrimaryColor,
                customSecondaryColor = customSecondaryColor,

                pearlescentColor = pearlescentColor,
                wheelColor = wheelColor,

                wheels = GetVehicleWheelType(vehicle),
                windowTint = GetVehicleWindowTint(vehicle),
                xenonColor = GetVehicleXenonLightsColor(vehicle),

                neonEnabled = {IsVehicleNeonLightEnabled(vehicle, 0), IsVehicleNeonLightEnabled(vehicle, 1),
                            IsVehicleNeonLightEnabled(vehicle, 2), IsVehicleNeonLightEnabled(vehicle, 3)},

                neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
                extras = extras,
                tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),

                modSpoilers = GetVehicleMod(vehicle, 0),
                modFrontBumper = GetVehicleMod(vehicle, 1),
                modRearBumper = GetVehicleMod(vehicle, 2),
                modSideSkirt = GetVehicleMod(vehicle, 3),
                modExhaust = GetVehicleMod(vehicle, 4),
                modFrame = GetVehicleMod(vehicle, 5),
                modGrille = GetVehicleMod(vehicle, 6),
                modHood = GetVehicleMod(vehicle, 7),
                modFender = GetVehicleMod(vehicle, 8),
                modRightFender = GetVehicleMod(vehicle, 9),
                modRoof = GetVehicleMod(vehicle, 10),

                modEngine = GetVehicleMod(vehicle, 11),
                modBrakes = GetVehicleMod(vehicle, 12),
                modTransmission = GetVehicleMod(vehicle, 13),
                modHorns = GetVehicleMod(vehicle, 14),
                modSuspension = GetVehicleMod(vehicle, 15),
                modArmor = GetVehicleMod(vehicle, 16),

                modTurbo = IsToggleModOn(vehicle, 18),
                modSmokeEnabled = IsToggleModOn(vehicle, 20),
                modXenon = IsToggleModOn(vehicle, 22),

                modFrontWheels = GetVehicleMod(vehicle, 23),
                modBackWheels = GetVehicleMod(vehicle, 24),

                modPlateHolder = GetVehicleMod(vehicle, 25),
                modVanityPlate = GetVehicleMod(vehicle, 26),
                modTrimA = GetVehicleMod(vehicle, 27),
                modOrnaments = GetVehicleMod(vehicle, 28),
                modDashboard = GetVehicleMod(vehicle, 29),
                modDial = GetVehicleMod(vehicle, 30),
                modDoorSpeaker = GetVehicleMod(vehicle, 31),
                modSeats = GetVehicleMod(vehicle, 32),
                modSteeringWheel = GetVehicleMod(vehicle, 33),
                modShifterLeavers = GetVehicleMod(vehicle, 34),
                modAPlate = GetVehicleMod(vehicle, 35),
                modSpeakers = GetVehicleMod(vehicle, 36),
                modTrunk = GetVehicleMod(vehicle, 37),
                modHydrolic = GetVehicleMod(vehicle, 38),
                modEngineBlock = GetVehicleMod(vehicle, 39),
                modAirFilter = GetVehicleMod(vehicle, 40),
                modStruts = GetVehicleMod(vehicle, 41),
                modArchCover = GetVehicleMod(vehicle, 42),
                modAerials = GetVehicleMod(vehicle, 43),
                modTrimB = GetVehicleMod(vehicle, 44),
                modTank = GetVehicleMod(vehicle, 45),
                modDoorR = GetVehicleMod(vehicle, 47),
                modLivery = GetVehicleMod(vehicle, 48),
                modLightbar = GetVehicleMod(vehicle, 49)
            }
        else
            return
        end
    end

    ---crédits https://github.com/esx-framework/esx-legacy
    ---@param vehicle number
    ---@param props table
    function self:SetProperties(vehicle, props)

        if DoesEntityExist(vehicle) then

            local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            SetVehicleModKit(vehicle, 0)

            if props.plate then
                SetVehicleNumberPlateText(vehicle, props.plate)
            end

            if props.plateIndex then
                SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
            end

            if props.bodyHealth then
                SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
            end

            if props.engineHealth then
                SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
            end

            if props.tankHealth then
                SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0)
            end

            if props.fuelLevel then
                Shared.Storage:Get("FuelSys"):Get("SetFuel")(vehicle, (props.fuelLevel + 0.0))
            end

            if props.dirtLevel then
                SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
            end

            if props.customPrimaryColor then
                SetVehicleCustomPrimaryColour(vehicle, props.customPrimaryColor[1], props.customPrimaryColor[2],
                    props.customPrimaryColor[3])
            end

            if props.customSecondaryColor then
                SetVehicleCustomSecondaryColour(vehicle, props.customSecondaryColor[1], props.customSecondaryColor[2],
                    props.customSecondaryColor[3])
            end

            if props.color1 then
                SetVehicleColours(vehicle, props.color1, colorSecondary)
            end

            if props.color2 then
                SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2)
            end

            if props.pearlescentColor then
                SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
            end

            if props.wheelColor then
                SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor)
            end

            if props.wheels then
                SetVehicleWheelType(vehicle, props.wheels)
            end

            if props.windowTint then
                SetVehicleWindowTint(vehicle, props.windowTint)
            end

            if props.neonEnabled then
                SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
                SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
                SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
                SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
            end

            if props.extras then
                for extraId, enabled in pairs(props.extras) do
                    if enabled then
                        SetVehicleExtra(vehicle, tonumber(extraId), 0)
                    else
                        SetVehicleExtra(vehicle, tonumber(extraId), 1)
                    end
                end
            end

            if props.neonColor then
                SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
            end

            if props.xenonColor then
                SetVehicleXenonLightsColor(vehicle, props.xenonColor)
            end

            if props.modSmokeEnabled then
                ToggleVehicleMod(vehicle, 20, true)
            end

            if props.tyreSmokeColor then
                SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
            end

            if props.modSpoilers then
                SetVehicleMod(vehicle, 0, props.modSpoilers, false)
            end

            if props.modFrontBumper then
                SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
            end

            if props.modRearBumper then
                SetVehicleMod(vehicle, 2, props.modRearBumper, false)
            end
            if props.modSideSkirt then
                SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
            end

            if props.modExhaust then
                SetVehicleMod(vehicle, 4, props.modExhaust, false)
            end

            if props.modFrame then
                SetVehicleMod(vehicle, 5, props.modFrame, false)
            end

            if props.modGrille then
                SetVehicleMod(vehicle, 6, props.modGrille, false)
            end

            if props.modHood then
                SetVehicleMod(vehicle, 7, props.modHood, false)
            end

            if props.modFender then
                SetVehicleMod(vehicle, 8, props.modFender, false)
            end

            if props.modRightFender then
                SetVehicleMod(vehicle, 9, props.modRightFender, false)
            end

            if props.modRoof then
                SetVehicleMod(vehicle, 10, props.modRoof, false)
            end

            if props.modEngine then
                SetVehicleMod(vehicle, 11, props.modEngine, false)
            end

            if props.modBrakes then
                SetVehicleMod(vehicle, 12, props.modBrakes, false)
            end

            if props.modTransmission then
                SetVehicleMod(vehicle, 13, props.modTransmission, false)
            end

            if props.modHorns then
                SetVehicleMod(vehicle, 14, props.modHorns, false)
            end

            if props.modSuspension then
                SetVehicleMod(vehicle, 15, props.modSuspension, false)
            end

            if props.modArmor then
                SetVehicleMod(vehicle, 16, props.modArmor, false)
            end

            if props.modTurbo then
                ToggleVehicleMod(vehicle, 18, props.modTurbo)
            end

            if props.modXenon then
                ToggleVehicleMod(vehicle, 22, props.modXenon)
            end

            if props.modFrontWheels then
                SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
            end

            if props.modBackWheels then
                SetVehicleMod(vehicle, 24, props.modBackWheels, false)
            end

            if props.modPlateHolder then
                SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
            end

            if props.modVanityPlate then
                SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
            end

            if props.modTrimA then
                SetVehicleMod(vehicle, 27, props.modTrimA, false)
            end

            if props.modOrnaments then
                SetVehicleMod(vehicle, 28, props.modOrnaments, false)
            end

            if props.modDashboard then
                SetVehicleMod(vehicle, 29, props.modDashboard, false)
            end

            if props.modDial then
                SetVehicleMod(vehicle, 30, props.modDial, false)
            end

            if props.modDoorSpeaker then
                SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
            end

            if props.modSeats then
                SetVehicleMod(vehicle, 32, props.modSeats, false)
            end

            if props.modSteeringWheel then
                SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
            end

            if props.modShifterLeavers then
                SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
            end

            if props.modAPlate then
                SetVehicleMod(vehicle, 35, props.modAPlate, false)
            end

            if props.modSpeakers then
                SetVehicleMod(vehicle, 36, props.modSpeakers, false)
            end

            if props.modTrunk then
                SetVehicleMod(vehicle, 37, props.modTrunk, false)
            end

            if props.modHydrolic then
                SetVehicleMod(vehicle, 38, props.modHydrolic, false)
            end

            if props.modEngineBlock then
                SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
            end

            if props.modAirFilter then
                SetVehicleMod(vehicle, 40, props.modAirFilter, false)
            end

            if props.modStruts then
                SetVehicleMod(vehicle, 41, props.modStruts, false)
            end

            if props.modArchCover then
                SetVehicleMod(vehicle, 42, props.modArchCover, false)
            end

            if props.modAerials then
                SetVehicleMod(vehicle, 43, props.modAerials, false)
            end

            if props.modTrimB then
                SetVehicleMod(vehicle, 44, props.modTrimB, false)
            end

            if props.modTank then
                SetVehicleMod(vehicle, 45, props.modTank, false)
            end

            if props.modWindows then
                SetVehicleMod(vehicle, 46, props.modWindows, false)
            end

            if props.modLivery then
                SetVehicleMod(vehicle, 48, props.modLivery, false)
                SetVehicleLivery(vehicle, props.modLivery)
            end

            if props.windowsBroken then
                for k, v in pairs(props.windowsBroken) do
                    if v then
                        SmashVehicleWindow(vehicle, tonumber(k))
                    end
                end
            end

            if props.doorsBroken then
                for k, v in pairs(props.doorsBroken) do
                    if v then
                        SetVehicleDoorBroken(vehicle, tonumber(k), true)
                    end
                end
            end

            if props.tyreBurst then
                for k, v in pairs(props.tyreBurst) do
                    if v then
                        SetVehicleTyreBurst(vehicle, tonumber(k), true, 1000.0)
                    end
                end
            end

        end

    end

    function self:Repair(vehicle)

        if (not DoesEntityExist(vehicle)) then
            return
        end

        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleOnGroundProperly(vehicle)

        self:SetProperties(vehicle, {
            engineHealth = 1000.0,
            dirtLevel = 0.0
        })

    end

    ---@param index number
    ---@return boolean
    function self:GetDoor(index)
        for i = 1, #self.doors do
            if self.doors[i].index == index then
                return self.doors[i].state;
            end
        end
    end

    ---@param index number
    ---@param state boolean
    function self:SetDoor(index, state)
        
        for i = 1, #self.doors do
            if self.doors[i].index == index then
                self.doors[i].state = state;
                break;
            end
        end

    end

    function self:ResetDoors()

        self.doors = {
            {
                index = -1, 
                state = false
            },
            {
                index = 0, 
                state = false
            },
            {
                index = 1, 
                state = false
            },
            {
                index = 2, 
                state = false
            },
            {
                index = 3, 
                state = false
            },
            {
                index = 4, 
                state = false
            },
            {
                index = 5, 
                state = false
            }

        };

    end

    ---@param index number
    function self:SetDoorState(index)

        local vehicle = Client.Player:GetVehicle();
        local isOpen = self:GetDoor(index);

        if (not isOpen) then

            self:SetDoor(index, true);
            SetVehicleDoorOpen(vehicle, index, false, false);

        else

            self:SetDoor(index, false);
            SetVehicleDoorShut(vehicle, index, false);

        end

    end

    ---@param extraIndex number
    ---@param toggle boolean
    ---@param vehicle number
    function self:ToggleExtra(extraIndex, toggle, vehicle)

        local veh = vehicle or Client.Player:GetVehicle();

        if (veh) then

            SetVehicleExtra(veh, extraIndex, toggle and 0 or 1);

        end

    end

    return self;
end);