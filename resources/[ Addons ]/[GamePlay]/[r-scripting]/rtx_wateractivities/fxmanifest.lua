

fx_version 'cerulean'

game 'gta5'

description 'RTX WATER ACTIVITIES'

version '15.0'

server_scripts {
	'config.lua',
	'language/main.lua',
	'server/main.lua',
	'server/other.lua',
	'server/attr1.lua',
	'server/attr2.lua',
	'server/attr3.lua',
	'server/attr4.lua',
	'server/attr5.lua',
	'server/attr6.lua',
	'server/attr7.lua',
	'server/attr8.lua',
	'server/attr9.lua',
	'server/attr10.lua',
	'server/attr11.lua',
}

client_scripts {
	'config.lua',
	'language/main.lua',
	'client/main.lua',
	'client/attr1.lua',
	'client/attr2.lua',
	'client/attr3.lua',
	'client/attr4.lua',
	'client/attr5.lua',
	'client/attr6.lua',
	'client/attr7.lua',
	'client/attr8.lua',
	'client/attr9.lua',
	'client/attr10.lua',
	'client/attr11.lua',
}

files {
	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
	'html/BebasNeueBold.ttf',
	'html/NakaraRegular.ttf',
	'html/img/*.png'
}

ui_page 'html/ui.html'

data_file 'DLC_ITYP_REQUEST' 'water_ent.ytyp'
data_file 'DLC_ITYP_REQUEST' 'rtx_djn_water_active_holder.ytyp'

files {
	'data/**/*.meta',
} 

data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'

lua54 'yes'

escrow_ignore {
  'config.lua',
  'language/main.lua',
  'server/other.lua'
}
dependency '/assetpacks'