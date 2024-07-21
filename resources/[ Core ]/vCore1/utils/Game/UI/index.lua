--[[
----
----Created Date: 7:08 Friday March 31st 2023
----Author: vCore3
----Made with ❤
----
----File: [Index]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type fun(): number, number
local _GetActiveScreenResolution = GetActiveScreenResolution;
local _type = type;

---@class HUD
HUD = {};
HUD.ShowHUD = true;

---@param screenX number
---@param screenY number
---@return number, number
function HUD.ToResolution(screenX, screenY)
    local resolutionX, resolutionY = _GetActiveScreenResolution();
    local _resolutionX = (_type(screenX) == "number" and screenX or 0) * (resolutionX / 1920);
    local _resolutionY = (_type(screenY) == "number" and screenY or 0) * (resolutionY / 1080);
    return (_resolutionX / resolutionX), (_resolutionY / resolutionY);
end

---Close all opened menus
function HUD.CloseAll()
    if (Core.Value.IsValid(HUDMenuBuilder.CurrentMenu, Core.Types.Table)) then
        HUDMenuBuilder.CurrentMenu:Close();
    end
end