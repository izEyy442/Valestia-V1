--[[
----
----Created Date: 11:22 Saturday April 1st 2023
----Author: vCore3
----Made with ❤
----
----File: [HUDProgressBarSettings]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@enum HUDProgressBarSettings
HUDProgressBarSettings = {

    height = 30,
    width = 300,
    x = 960,
    y = 1000,
    ---@enum HUDProgressBarSettings.Color
    Color = {

        ---@enum HUDProgressBarSettings.Color.Background
        Background = {
            r = 0, 
            g = 0, 
            b = 0, 
            a = 40
        },
        ---@enum HUDProgressBarSettings.Color.Bar
        Bar = {
            r = Config["MarkerRGB"]["R"], 
            g = Config["MarkerRGB"]["G"], 
            b = Config["MarkerRGB"]["B"],  
            a = Config["MarkerRGB"]["A1"]
        },

    },

};