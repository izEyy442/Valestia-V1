





lua54 'yes'





fx_version 'cerulean'
game'gta5'
name 'mrw_minigolf'
lua54 'yes'
description 'script for patoche golf mapping'
author 'Morow'

client_scripts{
    'src/RageUI/RMenu.lua',
    'src/RageUI/menu/RageUI.lua',
    'src/RageUI/menu/Menu.lua',
    'src/RageUI/menu/MenuController.lua',
    'src/RageUI/components/*.lua',
    'src/RageUI/menu/elements/*.lua',
    'src/RageUI/menu/items/*.lua',
    'src/RageUI/menu/panels/*.lua',
    'src/RageUI/menu/windows/*.lua',
    'client/*.lua'
}

server_script{
    'server/*.lua'
}

shared_scripts{
    'shared/*.lua',
    'shared/translation/*.lua'
}

files{
    'ui/ui.html',
    'ui/script/app.js',
    'ui/css/app.css',
    'ui/font/*.woff'
}

ui_page 'ui/ui.html'