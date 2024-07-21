---
--- @author Kadir#6666
--- Create at [25/04/2023] 22:51:49
--- Current project [Valestia-V1]
--- File name [supremacy]
---

local AdminStorage = Shared.Storage:Get("Administration");

---@type UIMenu
local supremacy_menu = AdminStorage:Get("admin_supremacy");

---@type UIMenu
local supremacy_menu_group = AdminStorage:Get("admin_supremacy_group");

---@type UIMenu
local supremacy_menu_group_create = AdminStorage:Get("admin_supremacy_group_create");

---@type UIMenu
local supremacy_menu_group_manage = AdminStorage:Get("admin_supremacy_group_manage");

---@type UIMenu
local supremacy_menu_ped = AdminStorage:Get("admin_supremacy_ped");

local group_list
local group_on_selected

local filter_value
local function SearchFilterValue(value)

    if (filter_value == nil) then
        return true
    end

    value = (tostring(value)):lower()
    filter_value = (tostring(filter_value)):lower()

    return string.find(value, filter_value)

end

local function HoverPermissions(Items)

    local client_server_id = Client.Player:GetServerId()
    local client_player = Client.PlayersManager:GetFromId(Client.Player:GetServerId(client_server_id))
    local default_permissions = Config["Admin"]["DefaultPermissions"]

    if (default_permissions ~= nil and (Shared.Table:SizeOf(default_permissions) > 0)) then

        for prmName, _ in pairs(default_permissions) do

            if (prmName ~= nil and Client.Admin:GroupHasPermission(client_player.group, prmName) == true) then

                Items:Checkbox(prmName, nil, group_on_selected.permissions[prmName] == true, {
                }, {

                    onSelected = function(Checked)

                        group_on_selected.permissions[prmName] = Checked == true or nil;

                        if (Client.Admin:GetGroup(group_on_selected.name) ~= nil) then

                            Shared.Events:ToServer(Enums.Administration.Server.Actions.UpdateGroupPermission, group_on_selected.name, prmName)

                        end

                    end

                });


            end

        end

    else

        Items:Separator("Aucune permission trouvé.")

    end

end

supremacy_menu:IsVisible(function(Items)

    local client_server_id = Client.Player:GetServerId()
    local client_player = Client.PlayersManager:GetFromId(Client.Player:GetServerId(client_server_id))

    Items:Button("Gestion Permission", nil, {
    }, (Client.Admin:GroupHasPermission(client_player.group, "group_manage") == true), {

        onSelected = function()

            local server_group_list = Client.Admin:GetGroups()
            group_list = {}

            for k, _ in pairs(server_group_list) do
                table.insert(group_list, k)
            end

            table.sort(group_list, function(a, b)
                return (tonumber(server_group_list[a].level) < tonumber(server_group_list[b].level))
            end)

        end

    }, supremacy_menu_group)

    Items:Button("Se changer en Ped", nil, {
    }, ((Config["Admin"] ~= nil and Config["Admin"]["PedList"] ~= nil) and Client.Admin:GroupHasPermission(client_player.group, "take_ped") == true), {
    }, supremacy_menu_ped)

end)

supremacy_menu_group:IsVisible(function(Items)

    local client_server_id = Client.Player:GetServerId()
    local client_player = Client.PlayersManager:GetFromId(Client.Player:GetServerId(client_server_id))

    Items:Button("Créer une Permission", nil, {
    }, true, {

        onSelected = function()

            group_on_selected = {
                permissions = {}
            }

            local default_permissions = Config["Admin"]["DefaultPermissions"]

            for prmName, prmState in pairs(default_permissions) do

                if (prmState == true) then
                    group_on_selected.permissions[prmName] = true;
                end

            end

        end

    }, supremacy_menu_group_create)

    Items:Line()

    if (group_list ~= nil) then

        for i = 1, #group_list do

            local group_selected_name = group_list[i]

            if (group_selected_name ~= nil) then

                local group_selected_data = Client.Admin:GetGroup(group_selected_name)

                if (group_selected_data ~= nil) then

                    Items:Button(("~h~%s~s~ - (L%s)~h~"):format(group_selected_data.label, group_selected_data.level), nil, {
                    }, (group_selected_data.level ~= 1 and Client.Admin:GroupIsHigher(client_player.group, group_selected_data.name) == true), {

                        onSelected = function()

                            group_on_selected = group_selected_data

                        end

                    }, supremacy_menu_group_manage)

                end

            end

        end

    end

end)

supremacy_menu_group_create:IsVisible(function(Items)

    if (group_on_selected ~= nil) then

        Items:Button("Nom", nil, {

            RightLabel = (group_on_selected.label ~= nil and group_on_selected.label),

        }, true, {

            onSelected = function()

                local entry = Shared:KeyboardInput("Veuillez entrer un nom pour le groupe", 20);

                if (Shared:InputIsValid(entry, "string")) then

                    group_on_selected.name = string.gsub(entry, " ", "_"):lower();
                    group_on_selected.label = entry

                end

            end

        })

        Items:Line()

        HoverPermissions(Items)

        Items:Line()

        Items:Button("Valider", nil, {

            RightBadge = (group_on_selected.label ~= nil and RageUI.BadgeStyle.Tick),

            Color = {

                BackgroundColor = RageUI.ItemsColour.Green,

            }

        }, (group_on_selected.label ~= nil and group_on_selected.name ~= nil and group_on_selected.permissions ~= nil), {

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.CreateGroup, group_on_selected)

            end

        })

    end

end)

supremacy_menu_group_manage:IsVisible(function(Items)

    if (group_on_selected ~= nil) then

        Items:Separator(("Gestion du grade : ~h~%s~s~ - (~h~L%s~s~)"):format(group_on_selected.label, group_on_selected.level))

        HoverPermissions(Items)

        Items:Line()

        Items:Button("Supprimer", nil, {

            Color = {

                BackgroundColor = RageUI.ItemsColour.Red,

            }

        }, true, {

            onSelected = function()

                Shared.Events:ToServer(Enums.Administration.Server.Actions.DeleteGroup, group_on_selected.name)

            end

        })

    end

end)

supremacy_menu_ped:IsVisible(function(Items)

    local ped_list = Config["Admin"]["PedList"]

    if  (ped_list ~= nil) then

        local client_player_server_id = Client.Player:GetServerId()
        local client_player_ped_id = Client.Player:GetPed()
        local client_player_ped_model = GetEntityModel(client_player_ped_id)
        local client_has_currently_ped = (client_player_ped_model ~= GetHashKey("mp_m_freemode_01") and client_player_ped_model ~= GetHashKey("mp_f_freemode_01"))

        Items:Button("Reset", "Permet de réinitialiser son personnage.", {

            RightBadge = RageUI.BadgeStyle.Tick,

        }, client_has_currently_ped == true, {

            onSelected = function()
                Shared.Events:ToServer(Enums.Administration.Server.Actions.SetPed, client_player_server_id, "default")
            end

        })

        Items:Button("Rechercher", nil, {
        }, true, {

            onSelected = function()

                filter_value = nil;

                local value = Shared:KeyboardInput("Model", 30);

                if (value ~= nil and (Shared:InputIsValid(value, "string"))) then
                    filter_value = value
                end

            end

        })

        Items:Line()

        for i = 1, #ped_list do

            local selected_ped = ped_list[i]

            if (selected_ped ~= nil and SearchFilterValue(selected_ped)) then

                Items:Button(selected_ped, nil, {
                    RightLabel = "→→"
                }, true, {

                    onSelected = function()
                        Shared.Events:ToServer(Enums.Administration.Server.Actions.SetPed, client_player_server_id, selected_ped)
                    end

                })

            end

        end

    end

end)