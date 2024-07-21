--
--Created Date: 16:03 11/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Config]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Config = {}; -- Don't touch this.
Config["Accounts"] = {}; -- Don't touch this.
Config["Menu"] = {}; -- Don't touch this.
Config["DeathLogs"] = {}; -- Don't touch this.
Config["Notification"] = {}; -- Don't touch this.
Config["MarkerRGB"] = {}; -- Don't touch this.
Config["AdvancedNotification"] = {}; -- Don't touch this.

Config["Debug"] = false; -- Enable debug mode
Config["ServerName"] = "Valestia"; -- Server name
Config["ServerColor"] = "blue"; -- red, green, blue, yellow, purple, pink, orange, grey, black, white
Config["ServerImage"] = "https://i.imgur.com/uyNntjE.png"; -- red, green, blue, yellow, purple, pink, orange, grey, black, white
Config["Language"] = "fr"; -- Language of the server

Config["Accounts"]["money"] = "cash";
Config["Accounts"]["bank"] = "bank";
Config["Accounts"]["dirty_money"] = "dirtycash";

Config["MarkerRGB"]["R"] = 3;
Config["MarkerRGB"]["G"] = 112;
Config["MarkerRGB"]["B"] = 214;
Config["MarkerRGB"]["A1"] = 255;
Config["MarkerRGB"]["A2"] = 150;

Config["DeathLogs"]["onDeath"] = true; -- Log player death in server console ? (true/false)
Config["DeathLogs"]["onRevive"] = true; -- Log player revive in server console ? (true/false)

Config["Job2Enabled"] = true; -- Enable Job2 support ? (true/false)

Config["Notification"]["Enabled"] = true; -- Enable custom notification ? (true/false)
Config["AdvancedNotification"]["Enabled"] = true; -- Enable custom notification ? (true/false)

---@param message string
---@param hudColorIndex? number
Config["Notification"]["Custom"] = function(message, hudColorIndex) -- Custom notification function
    ESX.ShowNotification(message, hudColorIndex);
end

---@param sender string
---@param subject string
---@param message string
---@param textureDict string
---@param iconType number
---@param flash boolean
---@param saveToBrief boolean
---@param hudColorIndex? number
Config["AdvancedNotification"]["Custom"] = function(sender, subject, message, textureDict, iconType, flash, saveToBrief, hudColorIndex) -- Custom notification function
    ESX.ShowNotification(message, hudColorIndex);
end

Config["Menu"]["CloseOnDeath"] = true; -- Close the menu when the player dies ? Menu can't be opened until revive. (true/false)
Config["Menu"]["ShowHeader"] = true; --Show Menus header
Config["Menu"]["DisplayGlare"] = true; --Glare in the header
Config["Menu"]["DisplaySubtitle"] = true; --Display menus Subtitle
Config["Menu"]["DisplayBackground"] = true; --Display menus background
Config["Menu"]["DisplayNavigationBar"] = true; --Display navigation buttons
Config["Menu"]["DisplayInstructionalButton"] = true; --Display Instructional Buttons
Config["Menu"]["DisplayPageCounter"] = true; --Display Page Counter
Config["Menu"]["Titles"] = ""; --Set all menus title
Config["Menu"]["TitleFont"] = 6; --Set all menus font
Config["Menu"]["TextureDictionary"] = "commonmenu"; --https://wiki.rage.mp/index.php?title=Textures --"color"
Config["Menu"]["TextureName"] = "interaction_bgd"; --https://wiki.rage.mp/index.php?title=Textures
Config["Menu"]["Color"] = { -- To use this you must set TextureDictionary to "color"
    R = 0,
    G = 0,
    B = 0,
    A = 10
};