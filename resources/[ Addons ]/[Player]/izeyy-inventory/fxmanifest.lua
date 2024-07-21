fx_version 'adamant'

game 'gta5'

description 'LCODE Inventory | https://discord.gg/5PENbrvm4N'

version '1.0.1'

lua54 'yes'

escrow_ignore {
  "locales/*.lua",
  'config/*.lua',
  'client/custom/framework/*.lua',
	'server/custom/framework/*.lua',
  'client/custom/property/*.lua',
  'server/custom/property/*.lua',

}

shared_scripts {
  "locales/*.lua",
  'config/*.lua',

}


client_scripts {
  "src/RageUI/RMenu.lua",
  "src/RageUI/menu/RageUI.lua",
  "src/RageUI/menu/Menu.lua",
  "src/RageUI/menu/MenuController.lua",
  "src/RageUI/components/*.lua",
  "src/RageUI/menu/elements/*.lua",
  "src/RageUI/menu/items/*.lua",
  "src/RageUI/menu/panels/*.lua",
  "src/RageUI/menu/windows/*.lua",

  
	'client/custom/framework/*.lua',
  'client/custom/property/*.lua',
  'client/apps/other/*.lua',
  'client/apps/default/*.lua',
  'client/apps/system/*.lua',
  "client/main.lua",
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",

  'server/custom/framework/*.lua',
	'server/custom/property/*.lua',
	'server/custom/apps/*.lua',
  'server/apps/default/*.lua',
  'server/apps/system/*.lua',
  "server/main.lua",

}

ui_page 'src/html/ui.html'


files {

  "locales/*.js",

  'src/html/*.html',

  'config/config.js',
  'src/html/assets/js/*.js',

  'config/config.css',
  'src/html/assets/css/*.css',
  
  'src/html/assets/images/*.png',
  'src/html/assets/images/weapons/**/*.png',
  'src/html/assets/images/items/*.png',
  'src/html/assets/icons/*.png',

  'src/html/assets/fonts/*.ttf',
  'src/html/assets/fonts/*.otf',
  'src/html/assets/fonts/justsignature/JustSignature.woff',

}
