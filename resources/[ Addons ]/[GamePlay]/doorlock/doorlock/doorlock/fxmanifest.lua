





lua54 'yes'

fx_version 'cerulean'

game 'gta5'

lua54 'yes'

shared_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    'Shared/Config.lua'
}

client_scripts {
    'Client/CMain.lua'
}

server_scripts {
    'Server/SMain.lua'
}

ui_page 'Ui/index.html'

files {
    'Ui/*.html',
    'Ui/*.js',
    'Ui/*.css',
}
