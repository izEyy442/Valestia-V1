ConfigWipe = {
    ESX = "",
    MessageWipe = "Vous avez été wipe, pattientez quelques minutes avant de relancer votre jeu !",
    Autorized = {
        ['founder'] = true,
        ['gerant-staff'] = true,
        ['gerant-il'] = true,
        ['super-admin'] = true,
    },

    Logs = {
        WebHook = "https://discord.com/api/webhooks/1226955463858458735/sQtZEqh-ai1G5-duM62kNYGUiQSkFzaEhYKmgytkilUg_ABAk1Ul_8dsxwNUZsq_kXwg"
    },

    TuSaisPasDevCeluiQuiAModif = {
        ["WEAPON_KATANA"] = true,
        ["WEAPON_SNSPISTOL_MK2"] = true,
        ["WEAPON_PISTOL_MK2"] = true,
        ["WEAPON_APPISTOL"] = true,
        ["WEAPON_MACHINEPISTOL"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
        ["WEAPON_CARBINERIFLE"] = true,
        ["WEAPON_PUMPSHOTGUN"] = true,
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_ADVANCEDRIFLE"] = true,
        ["WEAPON_SAWNOFFSHOTGUN"] = true,
        ["WEAPON_MUSKET"] = true,
        ["WEAPON_DOUBLEACTION"] = true,
        ["WEAPON_SWITCHBLADE"] = true,
        ["WEAPON_PENETRATOR"] = true,
        ["WEAPON_ASSAULTRIFLE"] = true,
        ["WEAPON_SMG"] = true,
        ["WEAPON_STONE_HATCHET"] = true,

    },

    ItemsPerm = {
        --["feuille_coca"] = true,
    },

    -- Delete
    TableDelete = {
        {name = "addon_account_data", id = "owner"},
        {name = "clothes_data", id = "identifier"},
        {name = "kq_extra", id = "player"},
        {name = "user_licenses", id = "owner"},
        {name = "addon_inventory_items", id = "owner"},
        {name = "billing", id = "identifier"},
        {name = "datastore_data", id = "owner"},
        {name = "owned_properties", id = "owner"},
        {name = "playerstattoos", id = "identifier"},
        {name = "jail", id = "identifier"},
        {name = "phone_phones", id = "id"},
        {name = "phone_backups", id = "identifier"},
        {name = "phone_crypto", id = "identifier"},
        {name = "drugss", id = "owner"},
    },

    -- Update 
    TableUpdate = {
        {tablename = "users", var = "firstname", id = "identifier", finalvalue = ""},
        {tablename = "users", var = "lastname", id = "identifier", finalvalue = ""},
        {tablename = "users", var = "position", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "skin", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "accounts", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "inventory", id = "identifier", finalvalue = nil},
        {tablename = "users", var = "job", id = "identifier", finalvalue = "unemployed"},
        {tablename = "users", var = "job2", id = "identifier", finalvalue = "unemployed2"},
        {tablename = "users", var = "job_grade", id = "identifier", finalvalue = 0},
        {tablename = "users", var = "job2_grade", id = "identifier", finalvalue = 0},
        {tablename = "users", var = "isDead", id = "identifier", finalvalue = 0},
        {tablename = "users", var = "isHurt", id = "identifier", finalvalue = 0},
        {tablename = "users", var = "ammo", id = "identifier", finalvalue = "{}"},
    }

}