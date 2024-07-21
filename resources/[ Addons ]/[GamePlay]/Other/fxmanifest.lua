





lua54 'yes'

fx_version('bodacious')
game('gta5')


shared_script {
    'config.lua',
    'drugconfig.lua',
    'game/fleeca/shared/*.lua',
    'game/apu/shared/*.lua',
    'game/afk/shared/*.lua',
    'game/DJ/shared/*.lua',
    'game/chasse/shared/*.lua',
}

client_scripts {
	'NativeUI.lua',
	'DPc.lua',
	'game/dpemotes/client/*.lua'
}

server_scripts {
	'DPc.lua',
	'@mysql-async/lib/MySQL.lua',
	'game/dpemotes/server/*.lua',
}

client_scripts {
    -----------------------
	-------- Libs ---------
	-----------------------
    'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',

    "RageUIv2/RMenu.lua",
    "RageUIv2/menu/RageUI.lua",
    "RageUIv2/menu/Menu.lua",
    "RageUIv2/menu/MenuController.lua",
    "RageUIv2/components/*.lua",
    "RageUIv2/menu/elements/*.lua",
    "RageUIv2/menu/items/*.lua",
    "RageUIv2/menu/panels/*.lua",
    "RageUIv2/menu/windows/*.lua",

    "RageUIv3/RMenu.lua",
    "RageUIv3/menu/RageUI.lua",
    "RageUIv3/menu/Menu.lua",
    "RageUIv3/menu/MenuController.lua",
    "RageUIv3/components/*.lua",
    "RageUIv3/menu/elements/*.lua",
    "RageUIv3/menu/items/*.lua",
    "RageUIv3/menu/panels/*.lua",
    "RageUIv3/menu/panels/*.lua",
    "RageUIv3/menu/windows/*.lua",

    "RageUIafk/RMenu.lua",
    "RageUIafk/menu/RageUI.lua",
    "RageUIafk/menu/Menu.lua",
    "RageUIafk/menu/MenuController.lua",
    "RageUIafk/components/*.lua",
    "RageUIafk/menu/elements/*.lua",
    "RageUIafk/menu/items/*.lua",
    "RageUIafk/menu/panels/*.lua",
    "RageUIafk/menu/windows/*.lua",

    "game/DJ/client/client.lua",
    'game/afk/client/*.lua',
    'game/peche/client/*.lua',
    'game/gouv/client/*.lua',
    'game/catalogue/client/*.lua',
    'game/vda illegal/client/*.lua',
    'game/fleeca/client/client.lua',
    'game/apu/client/*.lua',
    'game/drugsbuilder/client/*.lua',
    'game/boucherie/client/*.lua',
    'game/chasse/client/*.lua',
    'game/telescope/client/*.lua',
    'game/carpodium/client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'game/afk/server/*.lua',
    'game/peche/server/*.lua',
    'game/gouv/server/*.lua',
    'game/catalogue/server/*.lua',
    'game/vda illegal/server/*.lua',
    'game/fleeca/server/server.lua',
    'game/boucherie/server/*.lua',
    'game/chasse/server/*.lua',
    'game/apu/server/*.lua',
    'game/drugsbuilder/server/*.lua',
    'game/DJ/server/server.lua',
}


ui_page 'game/DJ/html/index.html'

files {
    'game/DJ/html/index.html',

	'game/DJ/html/css/style.css',
	'game/DJ/html/css/fontawesome.css',

	'game/DJ/html/img/*.png',

	'game/DJ/html/js/script.js',
	'game/DJ/html/js/jquery-3.5.1.min.js',

	'game/DJ/html/webfonts/Icons/fa-brands-400.eot',
	'game/DJ/html/webfonts/Icons/fa-brands-400.svg',
	'game/DJ/html/webfonts/Icons/fa-brands-400.woff',
	'game/DJ/html/webfonts/Icons/fa-brands-400.woff2',

	'game/DJ/html/webfonts/Icons/fa-regular-400.eot',
	'game/DJ/html/webfonts/Icons/fa-regular-400.svg',
	'game/DJ/html/webfonts/Icons/fa-regular-400.woff',
	'game/DJ/html/webfonts/Icons/fa-regular-400.woff2',

	'game/DJ/html/webfonts/Icons/fa-solid-900.eot',
	'game/DJ/html/webfonts/Icons/fa-solid-900.svg',
	'game/DJ/html/webfonts/Icons/fa-solid-900.woff',
	'game/DJ/html/webfonts/Icons/fa-solid-900.woff2',
}

data_file 'DLC_ITYP_REQUEST' 'stream/badge1.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/copbadge.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/prideprops_ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/lilflags_ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_foodpack'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_torch_fire001.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/natty_props_lollipops.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/apple_1.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_food_icecream_pack.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_food_dessert_a.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_give_gift.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/ultra_ringcase.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_food_xmas22.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/knjgh_pizzas.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/pata_christmasfood.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_cake_love_001.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_cake_birthday_001.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_cake_baby_001.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_cake_casino001.ytyp'