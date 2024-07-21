---
--- @author Kadir#6666
--- Create at [26/04/2023] 21:31:36
--- Current project [Valestia-V1]
--- File name [vehicle]
---

local AdminStorage = Shared.Storage:Get("Administration");

---@type UIMenu
local vehicles_menu = AdminStorage:Get("admin_vehicles");

---@return boolean
local function playerIsInVehicle()
    if (IsPedInAnyVehicle(Client.Player:GetPed())) then
        return true;
    end
    return false;
end

---@return number, boolean
local function getVehicleAndPlayer()

    local isInVehicle = false;
    local vehicle;
    local distance;

    if (playerIsInVehicle()) then

        vehicle = GetVehiclePedIsIn(Client.Player:GetPed());
        isInVehicle = true;

    else

        vehicle, distance = Game.Vehicle:GetClosest(Client.Player:GetCoords());;

        if (distance ~= -1 and distance < 15.0) then
            isInVehicle = true;
        else
            vehicle = nil;
        end

    end

    return vehicle, isInVehicle;

end

vehicles_menu:IsVisible(function(Items)

    local client_server_id = Client.Player:GetServerId()
    local client_player = Client.PlayersManager:GetFromId(Client.Player:GetServerId(client_server_id))

    local vehicle_entity = getVehicleAndPlayer();
    local vehicle_detected = (vehicle_entity ~= nil and vehicle_entity ~= 0)
    local vehicle_entity_network_id = (vehicle_detected and NetworkGetNetworkIdFromEntity(vehicle_entity))

    Items:Button("Faire apparaître un véhicule", nil, {
        RightLabel = "→→"
    }, Client.Admin:GroupHasPermission(client_player.group, "vehicle_spawn") == true, {

        onSelected = function()

            local vehicle_model = tostring(Shared:KeyboardInput("Votre message", 300));

            if (Shared:InputIsValid(vehicle_model, "string")) then
                Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "vehicle_spawn", vehicle_model)
            end

        end

    })

    Items:Button("Réparer", nil, {
        RightLabel = "→"
    }, Client.Admin:GroupHasPermission(client_player.group, "vehicle_repair") == true and vehicle_detected == true, {

        onSelected = function()

            Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "vehicle_repair", vehicle_entity_network_id)

        end

    })

    Items:Button("Freeze", nil, {
        RightLabel = "→"
    }, Client.Admin:GroupHasPermission(client_player.group, "entity_freeze") == true and vehicle_detected == true, {

        onSelected = function()

            Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "entity_freeze", vehicle_entity_network_id)

        end

    })

    Items:Button("Faire le plein d'essence", nil, {
        RightLabel = "→"
    }, Client.Admin:GroupHasPermission(client_player.group, "vehicle_refuel") == true and vehicle_detected == true, {

        onSelected = function()

            Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "vehicle_refuel", vehicle_entity_network_id)

        end

    })

    Items:Button("Upgrade les performances", nil, {
        RightLabel = "→"
    }, Client.Admin:GroupHasPermission(client_player.group, "vehicle_upgrade") == true and vehicle_detected == true, {

        onSelected = function()

            Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "vehicle_upgrade", vehicle_entity_network_id)

        end

    })

    Items:Button("Se donner la clé", nil, {
        RightLabel = "→"
    }, Client.Admin:GroupHasPermission(client_player.group, "vehicle_take_key") == true and vehicle_detected == true, {

        onSelected = function()

            Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "vehicle_take_key", vehicle_entity_network_id)

        end

    })

    Items:Button("Supprimer le véhicule", nil, {
        RightLabel = "→"
    }, Client.Admin:GroupHasPermission(client_player.group, "vehicle_delete") == true and vehicle_detected == true, {

        onSelected = function()

            Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "vehicle_delete", vehicle_entity_network_id)

        end

    })

end)