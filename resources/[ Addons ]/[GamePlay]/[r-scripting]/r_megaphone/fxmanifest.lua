

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'rytrak.fr'
ui_page 'html/index.html'

files {
    'html/*',

    'data/contentunlocks.meta',
    'data/weaponanimations.meta',
    'data/weaponarchetypes.meta',
    'data/loadouts.meta',
    'data/weapons.meta'
}

escrow_ignore {
	'config.lua',
	'cl_utils.lua',
    'stream/w_pi_megaphone.ytd'
}

client_scripts {
	'config.lua',
	'cl_utils.lua',
	'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

data_file 'WEAPONINFO_FILE' 'data/weapons.meta'
data_file 'WEAPON_METADATA_FILE' 'data/weaponarchetypes.meta'
data_file 'LOADOUTS_FILE' 'data/loadouts.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/weaponanimations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'data/contentunlocks.meta'
dependency '/assetpacks'