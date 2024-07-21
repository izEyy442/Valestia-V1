---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---Button
---@param Label string
---@param Description string
---@param Enabled boolean
---@param Callback function
---@param Submenu table
---@return nil
---@public
function RageUI.Button(Label, Description, Enabled, Callback, Submenu)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil and CurrentMenu() then
        ---@type number
        local Option = RageUI.Options + 1

        if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
            ---@type boolean
            local Active = CurrentMenu.Index == Option

            RageUI.ItemsSafeZone(CurrentMenu)

            if Active then
                RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
            end

            local colorData = Enabled and (Active and { 0, 0, 0 } or { 255, 255, 255 }) or { 163, 159, 148 }
            RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.Text.Scale, colorData[1], colorData[2], colorData[3], 255)

            RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

            RageUI.ItemsDescription(CurrentMenu, Description, Active);

            if Enabled then
                ---@type boolean
                local Hovered = CurrentMenu.EnableMouse and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1) and RageUI.ItemsMouseBounds(CurrentMenu, Active, Option + 1, SettingsButton);
                local Selected = (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and Active

                if Callback then
                    Callback(Hovered, Active, Selected)
                end

                if Selected then
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

                    if Submenu and Submenu() then
                        RageUI.NextMenu = Submenu
                    end
                end
            end
        end

        RageUI.Options = RageUI.Options + 1
    end
end

---ButtonWithStyle
---@param Label string
---@param Description string
---@param Style table
---@param Enabled boolean
---@param Callback function
---@param Submenu table
---@return nil
---@public
function RageUI.ButtonWithStyle(Label, Description, Style, Enabled, Callback, Submenu)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil and CurrentMenu() then
        ---@type number
        local Option = RageUI.Options + 1

        if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
            ---@type boolean
            local Active = CurrentMenu.Index == Option

            RageUI.ItemsSafeZone(CurrentMenu)

            local haveLeftBadge = Style.LeftBadge and Style.LeftBadge ~= RageUI.BadgeStyle.None
            local haveRightBadge = (Style.RightBadge and Style.RightBadge ~= RageUI.BadgeStyle.None) or (not Enabled and Style.LockBadge ~= RageUI.BadgeStyle.None)

            local LeftBadgeOffset = haveLeftBadge and 27 or 0
            local RightBadgeOffset = haveRightBadge and 32 or 0

            if Style.Color and Style.Color.BackgroundColor then
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, 255, 255, 255, 0)
            end

            if Active then
                if Style.Color and Style.Color.HightLightColor then
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, 255, 255, 255, 0)
                else
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                end
            end

            if Enabled then
                if haveLeftBadge then
                    local LeftBadge = Style.LeftBadge(Active)
                    RenderSprite(LeftBadge.BadgeDictionary or "commonmenu", LeftBadge.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, LeftBadge.BadgeColour and LeftBadge.BadgeColour.R or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.G or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.B or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.A or 255)
                end

                if haveRightBadge then
                    local RightBadge = Style.RightBadge(Active)
                    RenderSprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                end

                if Style.RightLabel then
                    RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.RightText.Scale, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255, 2)
                end

                RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.Text.Scale, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255)
            else
                if haveRightBadge then
                    local RightBadge = RageUI.BadgeStyle.Lock(Active)
                    RenderSprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                end

                RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)
            end

            RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height

            RageUI.ItemsDescription(CurrentMenu, Description, Active);

            if Enabled then
                ---@type boolean
                local Hovered = CurrentMenu.EnableMouse and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1) and RageUI.ItemsMouseBounds(CurrentMenu, Active, Option + 1, SettingsButton);
                local Selected = (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and Active

                if Callback then
                    Callback(Hovered, Active, Selected)
                end

                if Selected then
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

                    if Submenu and Submenu() then
                        RageUI.NextMenu = Submenu
                    end
                end
            end

        end

        RageUI.Options = RageUI.Options + 1
    end
end


---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by iTexZ.
--- DateTime: 04/06/2020 18:39
---

UIInstructionalButton = setmetatable({}, UIInstructionalButton);

---@type table
UIInstructionalButton.__index = UIInstructionalButton

---__constructor
---@param scaleform string
---@return table
---@public
function UIInstructionalButton.__constructor(scaleform)
    local _UIInstructionalButton = {
        scaleform = RequestScaleformMovie(scaleform or "INSTRUCTIONAL_BUTTONS"),
        display = false,
        color = { r = 0, g = 0, b = 0, a = 80 },
        items = {};
    }
    return setmetatable(_UIInstructionalButton, UIInstructionalButton);
end

---Add
---@param name string
---@param control number https://docs.fivem.net/docs/game-references/controls/
---@return void
---@public
function UIInstructionalButton:Add(name, control)
    self.items[#self.items + 1] = { name = name, control = control }
    self:onRefresh();
end

---UpdateBackground
---@param r number
---@param g number
---@param b number
---@param a number
---@return table
---@public
function UIInstructionalButton:UpdateBackground(r, g, b, a)
    self.color = { r = r, g = g, b = b, a = a };
    self:onRefresh();
    return self.color
end

---Delete
---@param name string
---@param control number
---@return void
---@public
function UIInstructionalButton:Delete(name, control)
    for key, value in pairs(self.items) do
        if (value.name == name) and (control == nil) then
            self.items[key] = nil;
        elseif (value.name == name) and (value.control == control) then
            self.items[key] = nil;
        end
    end
    self:onRefresh();
end

---Edit
---@param name string
---@param control number
---@return void
---@public
function UIInstructionalButton:Edit(name, old, control)
    for key, value in pairs(self.items) do
        if (value.name == name) and (control == nil) then
            self.items[key].name = old;
        elseif (value.name == name) and (value.control == control) then
            self.items[key].name = old;
        end
    end
    self:onRefresh();
end

---Visible
---@param bool boolean
---@return boolean
---@public
function UIInstructionalButton:Visible(bool)
    self.display = bool;
    return self.display;
end

---onRefresh
---@return void
---@private
function UIInstructionalButton:onRefresh()
    PushScaleformMovieFunction(self.scaleform, "CLEAR_ALL")
    PopScaleformMovieFunction()

    PushScaleformMovieFunction(self.scaleform, "TOGGLE_MOUSE_BUTTONS")
    PushScaleformMovieFunctionParameterInt(0)
    PopScaleformMovieFunction()

    PushScaleformMovieFunction(self.scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(self.color.r)
    PushScaleformMovieFunctionParameterInt(self.color.g)
    PushScaleformMovieFunctionParameterInt(self.color.b)
    PushScaleformMovieFunctionParameterInt(self.color.a)
    PopScaleformMovieFunction()

    PushScaleformMovieFunction(self.scaleform, "CREATE_CONTAINER")
    PopScaleformMovieFunction()

    for key, value in pairs(self.items) do
        PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(key)
        PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(1, value.control, 0))
        PushScaleformMovieFunctionParameterString(value.name)
        PopScaleformMovieFunction()
    end

    PushScaleformMovieFunction(self.scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PushScaleformMovieFunctionParameterInt(-1)
    PopScaleformMovieFunction()
end

---onTick
---@return void
function UIInstructionalButton:onTick()
    if (#self.items > 0) and (self.display) then
        DrawScaleformMovieFullscreen(self.scaleform, 255, 255, 255, 255)
    end
end