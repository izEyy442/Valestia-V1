---
--- @author Kadir#6666
--- Create at [21/04/2023] 12:31:25
--- Current project [Valestia-V1]
--- File name [players]
---

local AdminStorage = Shared.Storage:Get("Administration");

---@type UIMenu
local players_menu = AdminStorage:Get("admin_players");

---@type UIMenu
local player_selected_menu = AdminStorage:Get("admin_player_selected");

---@type UIMenu
local player_selected_me_menu = AdminStorage:Get("admin_player_selected_me");

---@type UIMenu
local player_selected_accounts_menu = AdminStorage:Get("admin_player_selected_accounts");

---@type UIMenu
local player_selected_inventory_menu = AdminStorage:Get("admin_player_selected_inventory");

---@type UIMenu
local player_selected_inventory_menu_give = AdminStorage:Get("admin_player_selected_inventory_give");

local hoveredPlayer

local vehicle_choose_index = 1
local teleport_choose_index = 1
local accounts_choose_index = 1

local filter_zone
local filter_cat_value = 1
local filter_cat_index = 1
local filter_value

local function SearchFilterValue(value)

    if (filter_value == nil) then
        return true
    end

    value = (tostring(value)):lower()
    filter_value = (tostring(filter_value)):lower()

    return string.find(value, filter_value)

end

AdminStorage:Set("hoveredPlayer", function(newPlayer)
    hoveredPlayer = newPlayer;
end)

Shared.Events:OnNet(Enums.Administration.Client.Actions.ReceiveInventory, function(player_source, player_inventory)

    if (player_source == nil or type(player_source) ~= "number") then
        return
    elseif (player_inventory == nil or type(player_inventory) ~= "table") then
        return
    end

    if (hoveredPlayer == nil) then
        return
    elseif (tonumber(hoveredPlayer[1]) ~= tonumber(player_source)) then
        return
    end

    hoveredPlayer[2].inventory = nil;
    hoveredPlayer[2].inventory = player_inventory;

end)

Shared.Events:OnNet(Enums.Administration.Client.Actions.ReceiveAccounts, function(player_source, player_accounts)

    if (player_source == nil or type(player_source) ~= "number") then
        return
    elseif (player_accounts == nil or type(player_accounts) ~= "table") then
        return
    end

    if (hoveredPlayer == nil) then
        return
    elseif (tonumber(hoveredPlayer[1]) ~= tonumber(player_source)) then
        return
    end

    hoveredPlayer[2].accounts = nil;
    hoveredPlayer[2].accounts = player_accounts;

end)

local function PlayerInfoDisplay()

    if (hoveredPlayer ~= nil) then

        local group_data = Client.Admin:GetGroup(hoveredPlayer[2].group)

        Panels:info("Informations du Personnage", {
            ("Identité : ~h~%s~h~"):format(((hoveredPlayer[2] ~= nil and hoveredPlayer[2].identity) or "Unknow")),
            ("Rang : ~h~%s~h~~s~ - ~h~(L%s)~h~"):format(((group_data ~= nil and group_data.label) or "Utilisateur") , ((group_data ~= nil and group_data.level) or 0)),
            ("Emplois : ~h~%s - %s~h~"):format(((hoveredPlayer[2] ~= nil and hoveredPlayer[2].job.label) or "Unknow"), ((hoveredPlayer[2] ~= nil and hoveredPlayer[2].job.grade_label) or "Unknow")),
            ("Organisation : ~h~%s - %s~h~"):format(((hoveredPlayer[2] ~= nil and hoveredPlayer[2].job2.label) or "Unknow"), ((hoveredPlayer[2] ~= nil and hoveredPlayer[2].job2.grade_label) or "Unknow")),
        })

    end

end

local function PlayerActionsDisplay()

    if (hoveredPlayer ~= nil) then

        Items:Separator(("(%s) - %s"):format(hoveredPlayer[1], ((hoveredPlayer[2] ~= nil and hoveredPlayer[2].name) or "Unknow")), nil, {}, true,{})

        Items:Line()

        Items:Button("Envoyer un message privé", nil, {}, hoveredPlayer[3] == nil,{

            onSelected = function()

                local message = tostring(Shared:KeyboardInput("Votre message", 300));

                if (Shared:InputIsValid(message, "string")) then

                    Shared.Events:ToServer(Enums.Administration.Server.Actions.SendMessage, hoveredPlayer[1], message)

                end

            end

        })

        Items:List("Donner un véhicule", Config["Admin"]["SpawnVehicles"] or {}, vehicle_choose_index, nil, {
        }, true,{

            onListChange = function(Index)

                vehicle_choose_index = Index;

            end,

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.Entity, "vehicle_spawn", Config["Admin"]["SpawnVehicles"][vehicle_choose_index], hoveredPlayer[1])

            end

        })

        Items:List("Téléportation Rapide", Config["Admin"]["TeleportCoords"] or {}, teleport_choose_index, nil, {
        }, true,{

            onListChange = function(Index)

                teleport_choose_index = Index;

            end,

            onSelected = function(Index)

                Shared.Events:ToServer(Enums.Administration.Server.Actions.Player.TeleportCoords, Index, hoveredPlayer[1])

            end

        })

        Items:Button("Finances", nil, {}, true,{

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.Player.GetAccounts, hoveredPlayer[1])

            end

        }, player_selected_accounts_menu)

        Items:Button("Inventaire", nil, {}, true,{

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.Player.GetInventory, hoveredPlayer[1])

            end

        }, player_selected_inventory_menu)

        Items:Button("Revive", nil, {}, true,{

            onSelected = function()

                ExecuteCommand(("revive %s"):format(hoveredPlayer[1]))

            end

        })

        Items:Button("Goto", nil, {}, hoveredPlayer[3] == nil,{

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.Goto, hoveredPlayer[1])

            end

        })

        Items:Button("Bring", nil, {}, hoveredPlayer[3] == nil,{

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.Bring, hoveredPlayer[1])

            end

        })

        Items:Button("Bring back", nil, {}, hoveredPlayer[3] == nil,{

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.BringBack, hoveredPlayer[1])

            end

        })

        Items:Button("Freeze", nil, {}, hoveredPlayer[3] == nil,{

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.Player.Freeze, hoveredPlayer[1])

            end

        })

    end

end

local function ItemsDisplay(displayType)

    Items:Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Liste des items~s~ ↓")

    if (displayType == "player") then

        local player_inventory = type(hoveredPlayer[2].inventory) == "table" and hoveredPlayer[2].inventory["items"]

        if (type(player_inventory) == "table") then

            if (#player_inventory <= 0) then

                Items:Button("Aucun items", nil, {
                }, true, {
                })

            else

                for i = 1, #player_inventory do

                    local item_values = player_inventory[i]

                    if (item_values ~= nil and (SearchFilterValue(item_values.label) or SearchFilterValue(item_values.name))) then

                        Items:Button(("%s - ~h~%s~h~"):format(item_values.label, item_values.name), ("Quantité : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~y~"):format(item_values.count), {
                        }, true, {

                            onSelected = function()

                                local item_count = tonumber(Shared:KeyboardInput("Veuillez entrer la quantité que vous souhaitez prendre", 2));

                                if (type(item_count) == "number") then

                                    ExecuteCommand(("removeitem %s %s %s"):format(hoveredPlayer[1], item_values.name, item_count))

                                end

                            end

                        })

                    end

                end

            end

        else

            Items:Separator("Inventaire en chargement ...")

        end

    elseif (displayType == "server") then

        local server_items = Client.Admin.Utils:GetItems()

        if (server_items ~= nil) then

            for itemName, itemValues in pairs(server_items) do

                if (itemName ~= nil and itemValues ~= nil and (SearchFilterValue(itemValues.label) or SearchFilterValue(itemName))) then

                    Items:Button(("%s - ~h~%s~h~"):format(itemValues.label, itemName), nil, {
                    }, true, {

                        onSelected = function()

                            local item_count = tonumber(Shared:KeyboardInput("Veuillez entrer la quantité que vous souhaitez donner", 2));

                            if (type(item_count) == "number") then

                                ExecuteCommand(("giveitem %s %s %s"):format(hoveredPlayer[1], itemName, item_count))

                            end

                        end

                    })

                end

            end

        end

    end

end

local function WeaponsDisplay(displayType)

    Items:Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Liste des armes~s~ ↓")

    if (displayType == "player") then

        local player_weapons = type(hoveredPlayer[2].inventory) == "table" and hoveredPlayer[2].inventory["weapons"]

        if (type(player_weapons) == "table") then

            if (#player_weapons <= 0) then

                Items:Button("Aucune armes", nil, {

                    LeftBadge = RageUI.BadgeStyle.Gun

                }, true, {
                })

            else

                for i = 1, #player_weapons do

                    local weapon_data = player_weapons[i]

                    if (weapon_data ~= nil and (SearchFilterValue(weapon_data.label) or SearchFilterValue(weapon_data.name))) then

                        Items:Button(weapon_data.label, weapon_data.name, {

                            LeftBadge = RageUI.BadgeStyle.Gun

                        }, true, {

                            onSelected = function()

                                ExecuteCommand(("removeweapon %s %s"):format(hoveredPlayer[1], weapon_data.name))

                            end

                        })

                    end

                end

            end

        else

            Items:Separator("Armes en chargement ...")

        end

    elseif (displayType == "server") then

        local server_weapons = ESX.GetWeaponList()

        if (server_weapons ~= nil) then

            for i = 1, #server_weapons do

                local weapon_data = server_weapons[i]

                if (weapon_data ~= nil and (SearchFilterValue(weapon_data.label) or SearchFilterValue(weapon_data.name))) then

                    Items:Button(weapon_data.label, weapon_data.name, {

                        LeftBadge = RageUI.BadgeStyle.Gun

                    }, true, {

                        onSelected = function()

                            ExecuteCommand(("giveweapon %s %s %s"):format(hoveredPlayer[1], weapon_data.name, 300))

                        end

                    })

                end

            end

        end

    end

end

local function staffCanManagePlayer(player_id)

    if (type(player_id) ~= "number") then
        return false
    end

    local client_server_id = Client.Player:GetServerId()
    local client_player = Client.PlayersManager:GetFromId(client_server_id)
    local server_selected_player = Client.PlayersManager:GetFromId(player_id)

    return (((player_id ~= client_server_id and Client.Admin:GroupIsHigher(client_player.group, server_selected_player.group)) and true) or true)

end

players_menu:IsVisible(function(Items)

    local server_players = Client.PlayersManager:GetAll()
    local server_players_number = Shared.Table:SizeOf(server_players)

    if (server_players_number == 0) then

        Items:Button("Une erreur s'est produite.", nil, {}, true, {})

    else

        Items:Button(((filter_value == nil and "Rechercher") or "Réinitialiser la recherche"), nil, {
        }, true, {

            onSelected = function()

                if (filter_value ~= nil) then

                    filter_value = nil;

                else

                    local value = Shared:KeyboardInput("ID, pseudo, identité, staff", 30);

                    if (value ~= nil and (Shared:InputIsValid(value, "string") or Shared:InputIsValid(value, "number"))) then

                        filter_value = value

                    end

                end

            end

        })

        Items:Checkbox("Restreindre a ma zone", nil, filter_zone, {
        }, {

            onSelected = function(Checked)

                filter_zone = Checked;

            end

        })

        Items:Line()

        if (hoveredPlayer ~= nil) then
            hoveredPlayer = nil;
        end

        for id, values in pairs(server_players) do

            if (type(id) == "number" and type(values) == "table") then

                local filter_string_matched = (SearchFilterValue(tostring(id)) or SearchFilterValue(values.name) or SearchFilterValue(values.identity) or (SearchFilterValue("staff") and values.group ~= "user"))
                local filter_zone_matched = ((filter_zone ~= true or (filter_zone == true and GetPlayerFromServerId(id) ~= -1)) and true) or false;

                if (filter_zone_matched and filter_string_matched) then

                    Items:Button(("%s (%s) - %s"):format(((values.group ~= "user" and "[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~STAFF~s~]") or ""), id, values.name), nil, {

                        RightBadge = (staffCanManagePlayer(tonumber(id)) == false and RageUI.BadgeStyle.Lock) or nil

                    }, true, {

                        onActive = function()

                            if (hoveredPlayer == nil or hoveredPlayer[1] == nil or hoveredPlayer[1] ~= id) then

                                hoveredPlayer = { id, values }

                            end

                        end,

                        onSelected = function ()

                            if (hoveredPlayer == nil or hoveredPlayer[1] == nil or hoveredPlayer[1] ~= id) then

                                hoveredPlayer = { id, values }

                            end

                        end

                    }, (staffCanManagePlayer(tonumber(id)) == true and AdminStorage:Get("admin_player_selected") or nil))

                end

            end

        end

    end

end, function(Panels)

    PlayerInfoDisplay();

end)

player_selected_menu:IsVisible(function(Items)

    PlayerActionsDisplay();

end, function(Panels)

    PlayerInfoDisplay();

end)

player_selected_me_menu:IsVisible(function(Items)

    Items:Checkbox("Noclip", nil, Client.Admin.Ped:HasNoClipActive(), {}, {

        onSelected = function()

            Client.Admin.Ped:SetNoClipActive(not Client.Admin.Ped:HasNoClipActive());
            Client.Admin.Ped:OnNoClip();

        end

    });

    Items:Checkbox("Gamertag des joueurs", nil, Client.Admin:GetPreferenceFromName("gamertag"), {}, {

        onSelected = function(Checked)

            Client.Admin:SetPreferenceFromName("gamertag", Checked)

        end

    });

    Items:Checkbox("Blip des joueurs", nil, Client.Admin:GetPreferenceFromName("blip"), {}, {

        onSelected = function(Checked)

            Client.Admin:SetPreferenceFromName("blip", Checked)

        end

    });

    Items:Line()

    Items:Checkbox("Afficher le nombre de reports", nil, Client.Admin:GetPreferenceFromName("report:number"), {}, {

        onSelected = function(Checked)

            Client.Admin:SetPreferenceFromName("report:number", Checked)

        end

    });

    --NO GODMODE UPDATE
    Items:Checkbox("Invisible", nil, Client.Admin.Ped:IsInvisible(), {}, {

        onSelected = function()

            Client.Admin.Ped:SetInvisible(not Client.Admin.Ped:IsInvisible());

        end

    });

    -- NO GODMODE UPDATE
    Items:Checkbox("Invincible", nil, Client.Admin.Ped:IsInGodMode(), {}, {

        onSelected = function()

            Client.Admin.Ped:SetGodMode(not Client.Admin.Ped:IsInGodMode());


        end

    });

    Items:Line()

    Items:Button("Gérer", nil, {
    }, true, {

        onSelected = function()

            player_selected_menu:SetHasSubMenu(player_selected_me_menu)

        end

    }, player_selected_menu)

    Items:Button("Se téléporter au marker", nil, {
    }, true, {

        onSelected = function()

            Client.Admin.Ped:TeleportToMarker();

        end

    })

end)

player_selected_inventory_menu:IsVisible(function(Items)

    if (hoveredPlayer ~= nil) then

        local client_server_id = Client.Player:GetServerId()
        local client_player = Client.PlayersManager:GetFromId(Client.Player:GetServerId(client_server_id))

        Items:List("Trier par", {
            "Aucun",
            "Items",
            "Armes"
        }, filter_cat_index, nil, {
        }, true, {

            onListChange = function(Index)

                filter_cat_index = Index

                if (filter_cat_index == 1) then

                    filter_cat_value = nil

                elseif (filter_cat_index == 2) then

                    filter_cat_value = "items"

                elseif (filter_cat_index == 3) then

                    filter_cat_value = "weapons"

                end

            end

        })

        Items:Button("Give", nil, {
        }, Client.Admin:GroupHasPermission(client_player.group, "player_manage_item"), {
        }, player_selected_inventory_menu_give)

        if (filter_cat_value == "items") then
            ItemsDisplay("player")
        elseif (filter_cat_value == "weapons") then
            WeaponsDisplay("player")
        else
            ItemsDisplay("player")
            WeaponsDisplay("player")
        end

    end

end, function()  end, function() filter_value = nil;  end)

player_selected_inventory_menu_give:IsVisible(function(Items)

    local server_items = Client.Admin.Utils:GetItems()
    local server_weapons = ESX.GetWeaponList()

    if ((server_items ~= nil and server_weapons ~= nil) and hoveredPlayer ~= nil) then

        Items:List("Trier par", {
            "Aucun",
            "Items",
            "Armes"
        }, filter_cat_index, nil, {
        }, true, {

            onListChange = function(Index)

                filter_cat_index = Index

                if (filter_cat_index == 1) then

                    filter_cat_value = nil

                elseif (filter_cat_index == 2) then

                    filter_cat_value = "items"

                elseif (filter_cat_index == 3) then

                    filter_cat_value = "weapons"

                end

            end

        })

        Items:Button("Rechercher", nil, {
        }, true, {

            onSelected = function()

                filter_value = nil;

                local value = Shared:KeyboardInput("Nom de l'item/arme", 30);

                if (value ~= nil and Shared:InputIsValid(value, "string")) then

                    filter_value = value

                end

            end

        })

        Items:Line()

        if (filter_cat_value == "items") then
            ItemsDisplay("server")
        elseif (filter_cat_value == "weapons") then
            WeaponsDisplay("server")
        else
            ItemsDisplay("server")
            WeaponsDisplay("server")
        end

    end

end, function()  end, function() filter_value = nil;  end)

player_selected_accounts_menu:IsVisible(function(Items)

    if (hoveredPlayer ~= nil and hoveredPlayer[2] ~= nil and type(hoveredPlayer[2].accounts) == "table") then

        local client_server_id = Client.Player:GetServerId()
        local client_player = Client.PlayersManager:GetFromId(Client.Player:GetServerId(client_server_id))
        local player_selected_accounts = hoveredPlayer[2].accounts

        Items:Separator("↓ ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Finances~s~ ↓")

        for i = 1, #player_selected_accounts do

            local current_player_account = player_selected_accounts[i]

            if (current_player_account ~= nil and Config["Admin"]["ViewableAccounts"][current_player_account.name] == true) then

                Items:List(("%s (~h~%s~s~$)"):format(ESX.GetAccountLabel(current_player_account.name), ESX.Math.GroupDigits(current_player_account.money)), {
                    "Prendre",
                    "Donner"
                }, accounts_choose_index,nil, {
                }, true, {

                    onListChange = function(Index)

                        accounts_choose_index = Index;

                    end,

                    onSelected = function(Index)

                        local item_count = tonumber(Shared:KeyboardInput("Veuillez entrer la quantité que vous souhaitez prendre", 6));

                        if (type(item_count) ~= "number") then

                            return

                        end

                        if (Index == 1) then

                            ExecuteCommand(("removeaccountmoney %s %s %s"):format(hoveredPlayer[1], current_player_account.name, item_count))

                        elseif (Index == 2) then

                            ExecuteCommand(("giveaccountmoney %s %s %s"):format(hoveredPlayer[1], current_player_account.name, item_count))

                        end

                    end

                })

            end

        end

    end

end)