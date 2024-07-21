---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUIv4 Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see RageUIv4
---


---@type table
local Heritage = {
    Background = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "mumdadbg", Width = 431, Height = 228 },
    Mum = { Dictionary = "char_creator_portraits", X = 25, Width = 228, Height = 228 },
    Dad = { Dictionary = "char_creator_portraits", X = 195, Width = 228, Height = 228 },
}

---@type Window
function RageUIv4.Window.Heritage(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUIv4.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if Mum < 20 then
                Mum = "female_" .. Mum-1
            elseif Mum > 40 then
                Mum = "female_" .. Mum-40
            else
                Mum = "female_" .. Mum-20
            end
            if Dad < 20 then
                Dad = "male_" .. Dad-1
            elseif Dad > 40 then
                Dad = "male_" .. Dad-40
            else
                Dad = "male_" .. Dad-20
            end
            RenderSprite(Heritage.Background.Dictionary, Heritage.Background.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUIv4.ItemOffset, Heritage.Background.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background.Height)
            RenderSprite(Heritage.Dad.Dictionary, Dad, CurrentMenu.X + Heritage.Dad.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUIv4.ItemOffset, Heritage.Dad.Width, Heritage.Dad.Height)
            RenderSprite(Heritage.Mum.Dictionary, Mum, CurrentMenu.X + Heritage.Mum.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUIv4.ItemOffset, Heritage.Mum.Width, Heritage.Mum.Height)
            RageUIv4.ItemOffset = RageUIv4.ItemOffset + Heritage.Background.Height
        end
    end
end