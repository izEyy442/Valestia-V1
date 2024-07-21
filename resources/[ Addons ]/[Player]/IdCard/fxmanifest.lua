





lua54 'yes'

fx_version('bodacious')
game('gta5')

server_scripts {
	'@mysql-async/lib/MySQL.lua',
}


shared_scripts {
	'debug.lua',
}

client_scripts {
	"builders/JobBuilder/src/RMenu.lua",
    "builders/JobBuilder/src/menu/RageUI.lua",
    "builders/JobBuilder/src/menu/Menu.lua",
    "builders/JobBuilder/src/menu/MenuController.lua",
    "builders/JobBuilder/src/components/*.lua",
    "builders/JobBuilder/src/menu/elements/*.lua",
    "builders/JobBuilder/src/menu/items/*.lua",
    "builders/JobBuilder/src/menu/panels/*.lua",
    "builders/JobBuilder/src/menu/panels/*.lua",
    "builders/JobBuilder/src/menu/windows/*.lua",
    "builders/JobBuilder/client/*.lua",
    "builders/JobBuilder/menu/*.lua",
}

server_scripts {
	"builders/JobBuilder/server/*.lua",
}

-- Oder

client_scripts({
	'client/main.lua',
})

files({
	"audio/*.dat151.rel",
	"audio/*.dat54.rel",
	"audio/*.dat10.rel",
	"sfx/**/*.awc",
})

data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')
data_file ('PED_METADATA_FILE') ('data/**/peds.meta')
data_file 'AUDIO_GAMEDATA' 'audio/ea825_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/ea825_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ea825'
data_file 'AUDIO_GAMEDATA' 'audio/b58b30_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/b58b30_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_b58b30'
data_file "AUDIO_SYNTHDATA" "audio/dghmieng_amp.dat"
data_file "AUDIO_GAMEDATA" "audio/dghmieng_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/dghmieng_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_dghmieng"


ui_page 'idcard/html/index.html'

server_script {
	'idcard/server.lua'
}

client_script {
	'idcard/client.lua'
}

files {
	'idcard/html/index.html',
	'idcard/html/assets/css/*.css',
	'idcard/html/assets/js/*.js',
	'idcard/html/assets/fonts/roboto/*.woff',
	'idcard/html/assets/fonts/roboto/*.woff2',
	'idcard/html/assets/fonts/justsignature/JustSignature.woff',
	'idcard/html/assets/images/*.png',
	"audio/*.dat151.rel",
	"audio/*.dat54.rel",
	"audio/*.dat10.rel",
	"sfx/**/*.awc",
}