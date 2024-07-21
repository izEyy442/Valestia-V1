--[[
----
----Created Date: 3:21 Saturday April 1st 2023
----Author: vCore3
----Made with ❤
----
----File: [HUDSprite]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

local _HasStreamedTextureDictLoaded = HasStreamedTextureDictLoaded;
local _RequestStreamedTextureDict = RequestStreamedTextureDict;
local _DrawSprite = DrawSprite;

---@param textureDict string
---@param textureName string
---@param x number
---@param y number
---@param width number
---@param height number
function HUD.DrawSprite(textureDict, textureName, x, y, width, height)
    local _x, _y = HUD.ToResolution(x, y);
    local _width, _height = HUD.ToResolution(width, height);

    if not _HasStreamedTextureDictLoaded(textureDict) then
        _RequestStreamedTextureDict(textureDict, true);
    end

    _DrawSprite(textureDict, textureName, _x, _y, _width, _height, 0.0, 255, 255, 255, 255);
end

---@param textureDict string
---@param textureName string
---@param x number
---@param y number
---@param width number
---@param height number
---@param color table
function HUD.DrawSpriteColor(textureDict, textureName, x, y, width, height, color)
    local _x, _y = HUD.ToResolution(x, y);
    local _width, _height = HUD.ToResolution(width, height);
    local _color = type(color) == "table" and color or {r = 255, g = 255, b = 255, a = 255};

    if not _HasStreamedTextureDictLoaded(textureDict) then
        _RequestStreamedTextureDict(textureDict, true);
    end

    _DrawSprite(textureDict, textureName, _x, _y, _width, _height, 0.0, _color.r, _color.g, _color.b, _color.a);
end