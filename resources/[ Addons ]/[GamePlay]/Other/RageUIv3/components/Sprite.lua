---RenderSprite
---
--- Reference : https://github.com/iTexZoz/NativeUILua_Reloaded/blob/master/UIElements/Sprite.lua#L90
---
---@param TextureDictionary string
---@param TextureName string
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function RenderSprite(TextureDictionary, TextureName, X, Y, Width, Height, Heading, R, G, B, A)
    ---@type number
    local X, Y, Width, Height = (tonumber(X) or 0) / 1920, (tonumber(Y) or 0) / 1080, (tonumber(Width) or 0) / 1920, (tonumber(Height) or 0) / 1080

    if not HasStreamedTextureDictLoaded(TextureDictionary) then
        RequestStreamedTextureDict(TextureDictionary, true)
    end

    DrawSprite(TextureDictionary, TextureName, X + Width * 0.5, Y + Height * 0.5, Width, Height, Heading or 0, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

local TextPanelVehicle = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0.25, Width = 431, Height = 42 },
}

---@type Panel
function RageUIv3.RenderVehicle(Dictionary, Texture)
    local CurrentMenu = RageUIv3.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, 560.25, TextPanelVehicle.Background.Width + CurrentMenu.WidthOffset, TextPanelVehicle.Background.Height + 20255, 0, 0, 255, 255, 255);
            RageUIv3.StatisticPanelCount = RageUIv3.StatisticPanelCount + 1
        end
    end
end

---@type Panel
function RageUIv3.RenderCaisse(Dictionary, Texture)
    local CurrentMenu = RageUIv3.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, 258, TextPanelVehicle.Background.Width + CurrentMenu.WidthOffset, TextPanelVehicle.Background.Height + 20255, 0, 0, 255, 255, 255);
            RageUIv3.StatisticPanelCount = RageUIv3.StatisticPanelCount + 1
        end
    end
end