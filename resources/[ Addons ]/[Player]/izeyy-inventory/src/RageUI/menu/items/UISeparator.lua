
---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 444, Height = 35 },
    Text = { X = 15, Y = 3, Scale = 0.26  },
}

function lgdUI.Separator(Label)
    local CurrentMenu = lgdUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = lgdUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if (Label ~= nil) then
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 200), CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + lgdUI.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255, 1)
                end
                lgdUI.ItemOffset = lgdUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (lgdUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = lgdUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            lgdUI.Options = lgdUI.Options + 1
        end
    end
end

