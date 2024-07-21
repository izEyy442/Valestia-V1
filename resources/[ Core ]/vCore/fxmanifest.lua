





lua54 'yes'

fx_version "adamant"

game "gta5"
lua54 'yes'

client_scripts {
    -- RAGEUI
    "src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",
    "src/client/components/*.lua",
    "src/client/menu/elements/*.lua",
    "src/client/menu/items/*.lua",
    "src/client/menu/panels/*.lua",
    "src/client/menu/windows/*.lua",
    --
    "init/shared/init.lua",
    "init/client/cl_init.lua",
    -- "init/client/eUtis.lua",
    "init/client/cl_initESX.lua",
    "markers.lua",
    "blips.lua",
    -- "warmenu.lua",
    "functions/client.lua",
    "players/**/shared/*.lua",
    "players/**/client/*.lua",
    -- "jobs/**/client/*.lua",
    -- "jobs/menu.lua",
}

server_scripts {
    "players/async.lua",
    "@oxmysql/lib/MySQL.lua",
    "init/shared/init.lua",
    "init/server/sv_init.lua",
    "init/server/eUtils.lua",
    "init/server/sv_initESX.lua",
    "players/**/shared/*.lua",
    "players/**/server/*.lua",
    -- "jobs/**/server/*.lua",
    -- "maintenance.lua",
}

exports {
    "GetVIP",
    "GetLevel",
    "XNL_GetCurrentPlayerLevel",
    "VerifyToken",
    "GenerateSocietyPlate",
    "GetIDfromUID",
    "MomoLogs",
    "isNotificationEnabled",
    "enableNotification",
    "disableNotification"
}

server_exports {
    "GetVIP",
    "GetLevel",
    "XNL_GetCurrentPlayerLevel",
    "VerifyToken",
    "GenerateSocietyPlate",
    "GetIDfromUID",
    "MomoLogs",
}

data_file ("DLC_ITYP_REQUEST") ("stream/int_cayo_props.ytyp")
data_file ("DLC_ITYP_REQUEST") ("stream/med/int_cayo_med_props.ytyp")