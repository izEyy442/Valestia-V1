

fx_version 'cerulean'

game 'gta5'

lua54 'yes'

client_script {
    'native_cl.lua',
    'init_cl.lua',
}
server_script {
    'native_sv.lua',
    'init_sv.lua',
}

export 'GetMySteamID'

dependency '/assetpacks'