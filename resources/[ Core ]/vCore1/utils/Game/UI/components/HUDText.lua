--[[
----
----Created Date: 3:20 Saturday April 1st 2023
----Author: vCore3
----Made with ❤
----
----File: [HUDText]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local _AddTextComponentSubstringPlayerName = AddTextComponentSubstringPlayerName;
local _BeginTextCommandDisplayText = BeginTextCommandDisplayText;
local _EndTextCommandDisplayText = EndTextCommandDisplayText;
local _SetTextRightJustify = SetTextRightJustify;
local _SetTextDropShadow = SetTextDropShadow;
local _SetTextOutline = SetTextOutline;
local _SetTextCentre = SetTextCentre;
local _SetTextColour = SetTextColour;
local _SetTextScale = SetTextScale;
local _SetTextFont = SetTextFont;
local _SetTextWrap = SetTextWrap;

---@param Text string
---@param x number
---@param y number
---@param Font number
---@param scale number
---@param r number
---@param g number
---@param b number
---@param a number
---@param alignment number | "Center" | "Centre" | "Right"
---@param dropShadow boolean
---@param outline boolean
---@param wordWrap number
local function RenderText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)

    local _text = type(text) == "string" and text or "";

    _SetTextFont(font or 0);
    _SetTextScale(1.0, scale or 0);
    _SetTextColour(r, g, b, a);

    if (dropShadow) then _SetTextDropShadow(); end
    if (outline) then _SetTextOutline(); end

    if (alignment ~= nil) then
        if (alignment == 1 or alignment == "center") then
            _SetTextCentre(true);
        elseif (alignment == 2 or alignment == "right") then
            _SetTextRightJustify(true);
            _SetTextWrap(0, x);
        end
    end

    if (type(wordWrap) == "number") then

        if (wordWrap ~= 0) then
            local _x, _ = HUD.ToResolution(wordWrap, 0);
            _SetTextWrap(_x, x - _x);
        end

    end

    _BeginTextCommandDisplayText("STRING");
    _AddTextComponentSubstringPlayerName(_text);
    _EndTextCommandDisplayText(x, y);

end

---@param text string
---@param x number
---@param y number
---@param font number
---@param scale number
---@param dropShadow boolean
---@param color table{r: number, g: number, b: number, a: number}
---@param wordWrap number
---@param alignment number | "center" | "right"
function HUD.DrawText(text, x, y, font, scale, dropShadow, color, wordWrap, alignment)
    
    local _x, _y = HUD.ToResolution(x, y);
    local _text = tostring(text) or "";
    local _color = color or { r = 255, g = 255, b = 255, a = 255 };

    RenderText(_text, _x, _y, font, scale, _color.r, _color.g, _color.b, _color.a, alignment, dropShadow, false, wordWrap);

end