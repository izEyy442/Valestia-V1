--
--Created Date: 22:20 14/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Society]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Lang:Insert("fr", {

    ["society_add_success"] = "^4%s ^0society added ✔️",
    ["society_add_already_exist"] = "^4%s ^0society already exists ❌",
    ["society_remove_success"] = "^4%s ^0society removed ✔️",
    ["society_remove_not_exist"] = "^4%s ^0society doesn't exists ❌",
    ["society_get_money_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_get_money_error'",
    ["society_get_dirty_money_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_get_dirty_money_error'",
    ["society_get_items_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_get_items_error'",
    ["society_get_weapons_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_get_weapons_error'",
    ["society_get_vehicles_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_get_vehicles_error'",
    ["society_add_money_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_add_money_error'",
    ["society_remove_money_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_remove_money_error'",
    ["society_set_grade_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_set_grade_error'",
    ["society_no_enought_money"] = "Votre société n'a pas assez d'argent",
    ["society_add_item_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_add_item_error'",
    ["society_storage_full"] = "Le coffre de la société est plein.",
    ["society_no_enought_item"] = "Votre société n'a pas assez de %s%s~s~",
    ["society_remove_item_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_remove_item_error'",
    ["society_add_weapon_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_add_weapon_error'",
    ["society_no_enought_weapon"] = "Votre société n'a pas assez de %s%s~s~",
    ["society_player_no_enought_weapon"] = "Vous ne possédez pas cette arme.",
    ["society_remove_weapon_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_remove_weapon_error'",
    ["society_job_label"] = "Société: %s%s~s~",
    ["society_gang_label"] = "Gang: %s%s~s~",
    ["society_player_has_already_weapon"] = "Vous possédez déjà cette arme",
    ["society_log_job_employee_added"] = "Player ^7[^0id: ^4%s^0, ^0identifier: ^4%s^0, ^0name: ^4%s^0]^0 has been added to society ^4%s^0.",
    ["society_log_gang_employee_added"] = "Player ^7[^0id: ^4%s^0, ^0identifier: ^4%s^0, ^0name: ^4%s^0]^0 has been added to gang ^4%s^0.",
    ["society_set_grade_player_is_boss"] = "Impossible de promouvoir cette personne.",
    ["society_set_grade_cant_demote_boss"] = "Impossible de changer le grade de cette personne",
    ["insufisent_weapon_ammo"] = "Vous n'avez pas autant de munitions",
    ["society_park_vehicle_is_permanent"] = "Ce véhicule provient de la boutique. Impossible de le stocker ici.",
    ["society_grade_invalid_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_grade_invalid_error'",
    ["society_target_has_already_job"] = "La personne possède déjà un métier.",
    ["society_player_has_already_job"] = "Impossible d'accepter la proposition d'embauche, vous avez déjà un métier",
    ["society_player_not_found"] = "La personne n'est plus disponnible",
    ["society_set_grade_player_already_in_society"] = "La personne est déjà dans votre société.",
    ["society_set_job_target"] = "Vous avez recruter %s%s %s~s~ en tant que %s%s~s~",
    ["society_set_job_player"] = "Vous avez été recruter dans la société %s%s~s~ par %s%s %s~s~ en tant que %s%s",


    --MENUS

    --Actions
    ["society_menu_accounts"] = "Gestion des comptes",
    ["society_menu_employees"] = "Gestion des employés",
    ["society_menu_salary"] = "Gestion des salaires",
    ["society_menu_money"] = "Compte en banque",
    ["society_menu_dirty_money"] = "Compte offshore",
    ["society_menu_withdraw"] = "Combien voulez vous retirer ? ~m~(%s%s~g~$~m~)",
    ["society_menu_deposit"] = "Combien voulez vous déposer ? ~m~(%s%s~g~$~m~)",
    ["society_money"] = "Argent disponible: %s~g~$~s~",
    ["society_menu_money_add"] = "Déposer de l'argent",
    ["society_menu_money_remove"] = "Retirer de l'argent",
    ["society_menu_dirty_money_add"] = "Déposer de l'argent sale",
    ["society_menu_dirty_money_remove"] = "Retirer de l'argent sale",
    ["society_menu_loading_employees"] = "Chargement de la liste des employés...",
    ["society_menu_loading_selected_employee"] = "Chargement des données de l'employé...",
    ["society_menu_promote"]  = "Promouvoir",
    ["society_menu_demote"]  = "Rétrograder",
    ["society_menu_fire"]  = "Virer",
    ["society_menu_salary_set_salary"] = "Définir le nouveau salaire ~m~(~s~Salaire: %s%s~g~$~m~)~s~",

    --Chest
    ["society_menu_chest"] = "Coffre",
    ["society_menu_player_inventory"] = "Votre Inventaire",
    ["society_menu_chest_inventory_separator"] = "~y~↓~s~ Inventaire ~y~↓~s~",
    ["society_menu_chest_weapons_separator"] = "~y~↓~s~ Armes ~y~↓~s~",
    ["society_menu_chest_index_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_menu_chest_index_error'",
    ["society_menu_chest_empty"] = "Le coffre est vide.",
    ["society_menu_chest_choices"] = "Sélection : ",
    ["society_menu_chest_chest_desc"] = "Utilisation du Stockage: ~m~(%s%s~s~/%s%s~m~)~s~\nUtilisation de votre inventaire: ~m~(%s%s~s~/%s%s~m~)~s~",
    ["society_menu_chest_loading"] = "Chargement des items...",
    ["society_menu_weapons_loading"] = "Chargement des armes...",
    ["society_menu_player_inventory_empty"] = "Votre inventaire est vide.",
    ["society_menu_player_inventory_loading"] = "Chargement de votre inventaire...",
    ["society_menu_chest_quantity"] = "Quantité: %s%s~s~",
    ["society_menu_chest_select_quantity"] = "Sélectionnez la quantité (Disponible: %s%s~s~)",
    ["society_menu_chest_weapon_desc_cat"] = "Caractéristique:~s~",
    ["society_menu_chest_weapon_desc_type"] = "Type: %s%s~s~",
    ["society_menu_chest_weapon_desc_ammo"] = "Munitions disponible: %s%s~s~",
    ["society_menu_chest_weapon_desc_components"] = "Customisation:",
    ["society_menu_weapons_empty"] = "Aucune arme dans le coffre.",
    ["society_menu_player_weapons_empty"] = "Aucune arme dans votre inventaire",

    --Garage
    ["society_garage_loading_vehicles"] = "Chargement des véhicules...",
    ["society_garage_empty"] = "Aucun véhicule dans le garage",
    ["society_menu_player_owned_vehicle"] = "POSSÉDÉ",
    ["society_menu_player_not_owned_vehicle"] = "SOCIÉTÉ",
    ["society_menu_vehicle_not_stored"] = "SORTIE~s~",
    ["society_vehicle_already_out"] = "Ce véhicule est indisponible, vous devez le retrouver là où vous l'avez laissé.",
    ["society_menu_vehicle_take"] = "Sortir le véhicule",
    ["society_menu_vehicle_take_error"] = "Une erreur est survenue~s~, Code erreur: ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'society_menu_vehicle_take_error'",
    ["society_menu_vehicle_loading"] = "Chargement du véhicule...",
    ["society_menu_vehicle_retrieve_personnal"] = "Récupérer mon véhicule",
    ["society_pound_vehicles_loading"] = "Chargement des véhicules...",
    ["society_take_vehicle_not_enough_money"] = "Vous n'avez pas assez d'argent pour sortir ce véhicule.",
    ["society_buy_pound_vehicle_success"] = "Vous avez payé %s~g~$~s~",
    ["society_menu_pound_no_vehicles"] = "Aucun véhicule dans la fourrière.",
    ["society_zone_pound"] = "Appuyez sur ~c~[%sE~c~]~s~ pour accéder à la fourrière",
    ["society_zone_pound_no_job"] = "Vous n'êtes pas dans une %ssociété",
    ["society_zone_pound_no_gang"] = "Vous n'êtes pas dans un %sgang",
    ["society_park_vehicle_not_owned"] = "Ce véhicule ne vous appartient pas.",
    ["society_park_vehicle_not_from_society"] = "Ce véhicule n'ppartient pas à votre société.",
    ["society_retrieve_vehicle_success"] = "Votre véhicule a été ranger dans votre garage personnel."

});