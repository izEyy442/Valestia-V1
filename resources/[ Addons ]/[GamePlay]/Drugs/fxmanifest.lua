





lua54 'yes'

fx_version "adamant"
game "gta5"

shared_scripts {
    "shared/config.lua"
} 

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    "shared/functions.lua",
    "shared/statistics.lua",
    "shared/animList.lua",
    "shared/animUtils.lua",
    "client/*.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/server.lua",
    "shared/configSV.lua"
}