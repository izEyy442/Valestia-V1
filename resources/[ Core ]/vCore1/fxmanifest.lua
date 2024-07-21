







lua54 'yes'

fx_version "cerulean"
game "gta5"

author "vCore1"
version "1.0.0"
lua54 "yes"


shared_scripts {
    "config.lua",
    "Config/*.lua",
    "shared/Classes/BaseObject.lua",
    "shared/Classes/Class.lua",
    "shared/Utils/**/**",
    "shared/Index.lua",
    "shared/Enums/**/**",
    "locales/**/**",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "webhook.lua",
    "modules/**/server/*.lua"
}

---RageUI
client_scripts {
    "utils/RageUI/init.lua",
    "utils/RageUI/menu/RageUI.lua",
    "utils/RageUI/menu/Menu.lua",
    "utils/RageUI/menu/MenuController.lua",
    "utils/RageUI/components/*.lua",
    "utils/RageUI/menu/elements/*.lua",
    "utils/RageUI/menu/items/*.lua",
    "utils/RageUI/menu/panels/*.lua",
    "utils/RageUI/menu/windows/*.lua",
};

client_scripts {
    'utils/client.lua',
    'utils/Game/modules/**/**',
    'utils/Game/Game.lua',
    'utils/Game/UI/index.lua',
    'utils/Game/UI/components/**',
    'utils/Game/UI/progressbar/**',
    'utils/Player/**/**',
    "modules/**/client/*.lua",
}

escrow_ignore {
    "config.lua",
    "Config/*.lua",
    "locales/**/**",
    "stream/**",
}