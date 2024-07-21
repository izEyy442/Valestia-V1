







lua54 'yes'





fx_version 'cerulean';
game 'gta5';

author 'Riiick';

ui_page 'html/index.html'

files {
    'Common/yacht.json',
    'html/index.html',
    'html/styles/default.css',
    'html/script.js'
}

client_scripts {
    'Client/RageUI/init.lua',
    'Client/RageUI/menu/RageUI.lua',
    'Client/RageUI/menu/Menu.lua',
    'Client/RageUI/menu/MenuController.lua',
    'Client/RageUI/components/*.lua',
    'Client/RageUI/menu/elements/*.lua',
    'Client/RageUI/menu/items/*.lua',
    'Client/RageUI/menu/panels/*.lua',
    'Client/RageUI/menu/windows/*.lua',
    'Client/config.lua',
    'Client/main.lua',
    'Client/function.lua',
    'Client/zoneManager.lua',
    'Client/Modules/**/**',
};

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Server/Modules/**/**',
};
