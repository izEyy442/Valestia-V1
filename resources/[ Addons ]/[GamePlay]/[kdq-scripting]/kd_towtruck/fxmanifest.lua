

author "kad Darem : shop.jumpon-studios.com"
documentation 'https://docs.kaddarem.com'
version '1.1.10'
package_id '5207275'

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

escrow_ignore {
  "shared/config.lua",
  'overwriteConfig.lua',
  'shared/lang.lua',
  'overwriteLang.lua',
  'meta/flatbed/vehiclelayouts.meta',
  'meta/flatbed/handling.meta',
  'meta/flatbed/vehicles.meta',
  'meta/flatbed/carcols.meta',
  'meta/flatbed/carvariations.meta',
  "stream/*"
}

shared_scripts {
  'shared/config.lua',
  'overwriteConfig.lua',
  'shared/lang.lua',
  'overwriteLang.lua',
}

client_script {
  '@kd_hud-event/hudevent_aff.lua',
  '@kd_custom-native/native_cl.lua',
  'client/depanneur_plateau.lua',
}

server_scripts {
	'server/depanneur_server.lua',
  'server/versionChecker.lua'
}

data_file 'VEHICLE_LAYOUTS_FILE' 'meta/flatbed/vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'meta/flatbed/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'meta/flatbed/vehicles.meta'
data_file 'CARCOLS_FILE' 'meta/flatbed/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'meta/flatbed/carvariations.meta'

files {
  'meta/flatbed/vehiclelayouts.meta',
  'meta/flatbed/handling.meta',
  'meta/flatbed/vehicles.meta',
  'meta/flatbed/carcols.meta',
  'meta/flatbed/carvariations.meta',
}

dependency '/assetpacks'