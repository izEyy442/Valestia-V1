--- @see lgdUI
---

---@type table

local SettingsButton = {
    Text = { X = 13, Y = 10, Scale = 0.32 },
    Rectangle = { Y = 1, Width = 1, Height = 10 },
}

function lgdUI.Line(R,G,B,O)
    local CurrentMenu = lgdUI.CurrentMenu
    local Description = lgdUI.Settings.Items.Description;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = lgdUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                RenderRectangle(CurrentMenu.X + Description.Bar.Y + 60 + CurrentMenu.SubtitleHeight , CurrentMenu.Y + Description.Bar.Y + 1.9 + CurrentMenu.SubtitleHeight + lgdUI.ItemOffset, Description.Bar.Width - 120 + CurrentMenu.WidthOffset, Description.Bar.Height - 0.7, R, G, B, O)
                lgdUI.ItemOffset = lgdUI.ItemOffset + SettingsButton.Rectangle.Height + Description.Bar.Height 
                if (CurrentMenu.Index == Option) then
                    if (lgdUI.LastControl) then
                        CurrentMenu.Index = Option - 0
                        if (CurrentMenu.Index < 0) then
                            CurrentMenu.Index = lgdUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 0
                    end
                end
            end
            lgdUI.Options = lgdUI.Options + 0
        end
    end
end