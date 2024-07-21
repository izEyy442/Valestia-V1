

fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Outfit bag script by KuzQuality'
version '1.3.0'


ui_page 'html/index.html'

--
-- Files
--

files {
    'html/js/jquery.js',
    'html/js/jquery-ui.js',
    'html/fonts/quicksand.ttf',
    'html/img/*.png',
    'html/index.html',
}

--- UNCOMMENT IF YOU'RE USING OLD QB CORE EXPORT
-- shared_script '@qb-core/import.lua'

--
-- Server
--

server_scripts {
    --- !!! COMMENT OUT IF YOU'RE USING QBCORE !!!
    '@mysql-async/lib/MySQL.lua',
    -----------------------------------------------

    'locale/locale.lua',
    'config.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
    'server/server.lua',
}

--
-- Client
--

client_scripts {
    'locale/locale.lua',
    'config.lua',
    'client/editable/settings.lua',
    'client/functions.lua',
    'client/editable/editable.lua',
    'client/client.lua',
    'client/editable/target.lua',
}

escrow_ignore {
    'config.lua',
    'html/fonts/quicksand.ttf',
    'html/img/*.png',
    'html/index.html',
    'client/editable/target.lua',
    'client/editable/editable.lua',
    'client/editable/settings.lua',
    'locale/locale.lua',
    'config.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
}

dependency '/assetpacks'