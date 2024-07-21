




lua54 'yes'

fx_version('bodacious')
game('gta5')
provide "es_extended"

server_scripts({
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'locale.lua',
	'locales/fr.lua',

	'config.lua',
	'config.weapons.lua',

	'server/common.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/Sv_ServerData.lua',
	'server/commands.lua',

	'common/modules/Logs.lua',
	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
	'server/anticheat/**/*.lua',
	'server/PVP/pvp.lua',
	'server/PVP/leaderboard.lua'
})

client_scripts({
	'locale.lua',
	'locales/fr.lua',

	'config.lua',
	'config.weapons.lua',

	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',
	'client/Cl_ServerData.lua',

	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',
	'client/modules/carkill.lua',

	'common/modules/Logs.lua',
	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
	'common/common.lua',

	'imports.lua',
	'lscreen/client.lua'
})

ui_page('html/ui.html')

files({
	'locale.js'
})


files {
    'lscreen/html/*.html',
	'lscreen/html/audio/*.*',
	'lscreen/html/img/*.*',
	'lscreen/html/script/*.*',
	'lscreen/html/style/*.*',
	'lscreen/html/img/*.*',
}

loadscreen "lscreen/html/index.html"








