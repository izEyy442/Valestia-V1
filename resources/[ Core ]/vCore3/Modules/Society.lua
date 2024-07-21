--
--Created Date: 18:31 15/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Society]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Config["Society"] = {}; -- Don't touch this

Config["Society"]["MaxWeight"] = 10000; -- Max weight of society storage
Config["Society"]["DefaultMoney"] = 0; -- Default money of society storage
Config["Society"]["DefaultDirtyMoney"] = 0; -- Default dirty money of society storage

Config["Society"]["Pound"] = {}; -- Don't touch this
Config["Society"]["Pound"]["JobCoords"] = {}; -- Don't touch this
Config["Society"]["Pound"]["GangCoords"] = {}; -- Don't touch this
Config["Society"]["Pound"]["JobCoords"]["Blips"] = {}; -- Don't touch this
Config["Society"]["Pound"]["GangCoords"]["Blips"] = {}; -- Don't touch this

Config["Society"]["Pound"]["JobCoords"]["Blips"]["Enabled"] = true;
Config["Society"]["Pound"]["JobCoords"]["Blips"]["Label"] = "[Public] Fourrière Société";
Config["Society"]["Pound"]["JobCoords"]["Blips"]["Sprite"] = 68;
Config["Society"]["Pound"]["JobCoords"]["Blips"]["Color"] = 25;

Config["Society"]["Pound"]["GangCoords"]["Blips"]["Enabled"] = true;
Config["Society"]["Pound"]["GangCoords"]["Blips"]["Label"] = "[Public] Fourrière Gang";
Config["Society"]["Pound"]["GangCoords"]["Blips"]["Sprite"] = 68;
Config["Society"]["Pound"]["GangCoords"]["Blips"]["Color"] = 49;

Config["Society"]["Pound"]["Price"] = 500; -- Price to get vehicle from pound

Config["Society"]["Pound"]["JobCoords"]["Interact"] = vector3(410.11468505859, -1623.6401367188, 29.291940689087);
Config["Society"]["Pound"]["JobCoords"]["Out"] = vector3(408.05212402344, -1646.5361328125, 29.291940689087);

Config["Society"]["Pound"]["GangCoords"]["Interact"] = vector3(483.78424072266, -1320.1688232422, 29.202421188354);
Config["Society"]["Pound"]["GangCoords"]["Out"] = vector3(494.52969360352, -1328.7476806641, 29.340944290161);