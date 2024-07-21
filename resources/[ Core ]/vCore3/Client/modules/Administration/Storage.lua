--[[
----
----Created Date: 3:41 Saturday December 24th 2022
----Author: vCore3
----Made with ❤
----
----File: [Storage]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local AdminStorage = Shared.Storage:Register("Administration");

local main_menu = AdminStorage:Set("admin_main", RageUI.AddMenu("", "Administration"));
local reports_menu = AdminStorage:Set("admin_reports", RageUI.AddSubMenu(main_menu, "", "Administration : Reports"));
AdminStorage:Set("admin_report_selected", RageUI.AddSubMenu(reports_menu, "", "Administration : Report"));

AdminStorage:Set("admin_vehicles", RageUI.AddSubMenu(main_menu, "", "Administration : Véhicules"));

local players_menu = AdminStorage:Set("admin_players", RageUI.AddSubMenu(main_menu, "", "Administration : Liste des joueurs"));
local player_menu_selected = AdminStorage:Set("admin_player_selected", RageUI.AddSubMenu(players_menu, "", "Administration :  Intéractions"));
AdminStorage:Set("admin_player_selected_accounts", RageUI.AddSubMenu(player_menu_selected, "", "Administration : Finances"));

local player_menu_selected_inventory = AdminStorage:Set("admin_player_selected_inventory", RageUI.AddSubMenu(player_menu_selected, "", "Administration : Inventaire"));
AdminStorage:Set("admin_player_selected_inventory_give", RageUI.AddSubMenu(player_menu_selected_inventory, "", "Administration : Items"));

AdminStorage:Set("admin_player_selected_me", RageUI.AddSubMenu(main_menu, "", "Administration : Mon personnage"));
AdminStorage:Set("admin_preferences", RageUI.AddSubMenu(main_menu, "", "Administration : Préférences"));

local supremacy_menu = AdminStorage:Set("admin_supremacy", RageUI.AddSubMenu(main_menu, "", "Administration : Suprématie"));
local supremacy_menu_group = AdminStorage:Set("admin_supremacy_group", RageUI.AddSubMenu(supremacy_menu, "", "Administration : Grades"));
AdminStorage:Set("admin_supremacy_group_create", RageUI.AddSubMenu(supremacy_menu_group, "", "Administration : Création"));
AdminStorage:Set("admin_supremacy_group_manage", RageUI.AddSubMenu(supremacy_menu_group, "", "Administration : Gestion"));

AdminStorage:Set("admin_supremacy_ped", RageUI.AddSubMenu(supremacy_menu, "", "Administration : Ped"));
AdminStorage:Set("admin_statistics", RageUI.AddSubMenu(main_menu, "", "Administration : Statistiques"));