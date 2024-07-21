







lua54 'yes'

--
--Created Date: 15:40 11/12/2022
--Author: vCore3
--Made with ❤
--
--File: [fxmanifest]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

fx_version 'cerulean';
game 'gta5';

author 'vCore3';
description 'Resource made for Valestia by vCore3';
github 'https://github.com/vCore3Work';
version '1.0.0';
lua54 'yes';

shared_scripts {
    'Config.lua',
    'Modules/**/**',
    'Shared/Classes/BaseObject.lua',
    'Shared/Classes/Class.lua',
    'Shared/Utils/**/**',
    'Shared/Index.lua',
    'Locales/**/**',
    'Shared/Enums/**/**',
    'Shared/exports/**/**',
    'Shared/Modules/**/**'
};

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Webhooks.lua',
    'Server/Discord/Discord.lua',
    'Server/Society/**/**',
    'Server/Keys/**/**',
    'Server/Vehicle/**/**',
    'Server/Server.lua',
    'Server/Player/**/**',
    'Server/modules/**/**',
};

---RageUI
client_scripts {
    'Client/RageUI/init.lua',
    'Client/RageUI/menu/RageUI.lua',
    'Client/RageUI/menu/Menu.lua',
    'Client/RageUI/menu/MenuController.lua',
    'Client/RageUI/components/*.lua',
    'Client/RageUI/menu/elements/*.lua',
    'Client/RageUI/menu/items/*.lua',
    'Client/RageUI/menu/panels/*.lua',
    'Client/RageUI/menu/windows/*.lua',
};

client_scripts {
    'Client/Client.lua',
    'Client/Utils/Game/modules/**/**',
    'Client/Utils/Game/Game.lua',
    'Client/Player/**/**',
    'Client/Society/**/**',
    'Client/modules/**/**',
};

files({
    "Server/JSON/Gangs.json",
    "Server/JSON/Admins.json",
});

escrow_ignore {
	"Config.lua",
    "Modules/**/**",
	"stream/**",
    "Locales/**",
    "Server/modules/exports/**/**",
    "Shared/exports/**/**",
    "Webhooks.lua",
};