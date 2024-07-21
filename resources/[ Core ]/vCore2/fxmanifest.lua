lua54 'yes'
fx_version "adamant"
game "gta5" 
this_is_a_map 'yes'

author 'iZeyy#0442'
description 'Ressource build for ViceCity RP 2024'
version '4.4.2'

shared_scripts {
    -- Modules & Jobs
    'Modules/**/shared/*.lua'
}

client_scripts {
    -- RAGEUI
    'Libs/RageUI/RMenu.lua',
    'Libs/RageUI/menu/RageUI.lua',
    'Libs/RageUI/menu/Menu.lua',
    'Libs/RageUI/menu/MenuController.lua',
    'Libs/RageUI/components/*.lua',
    'Libs/RageUI/menu/elements/*.lua',
    'Libs/RageUI/menu/items/*.lua',
    'Libs/RageUI/menu/panels/*.lua',
    'Libs/RageUI/menu/windows/*.lua',

    -- Utils
    'Libs/Utils/client.lua',
    'Libs/Utils/BoxZone.lua',
    'Libs/Utils/EntityZone.lua',
    'Libs/Utils/CircleZone.lua',
    'Libs/Utils/ComboZone.lua',
    'Libs/Utils/creation/client/*.lua',

    -- Esx
    'Libs/Esx/client/*.lua',

    -- Jobs
    'Modules/**/client/*.lua',

}

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    -- Utils
    'Libs/Utils/creation/server/*.lua',
    'Libs/Utils/server.lua',

    -- Esx
    'Libs/Esx/server/*.lua',

    -- Modules & Jobs
    'Modules/**/server/*.lua',

}