
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@class lgdUIMenus
lgdUI.Menus = setmetatable({}, lgdUI.Menus)

---@type table
---@return boolean
lgdUI.Menus.__call = function()
    return true
end

---@type table
lgdUI.Menus.__index = lgdUI.Menus

---@type table
lgdUI.CurrentMenu = nil

---@type table
lgdUI.NextMenu = nil

---@type number
lgdUI.Options = 0

---@type number
lgdUI.ItemOffset = 0

---@type number
lgdUI.StatisticPanelCount = 0

---@class UISize
lgdUI.UI = {
    Current = "NativeUI",
    Style = {
        lgdUI = {
            Width = 0
        },
        NativeUI = {
            Width = 0
        }
    }
}

---@class Settings
lgdUI.Settings = {
    Debug = false,
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        SliderLeft = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        SliderRight = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Id = nil,
        Use = "NativeUI",
        lgdUI = {
            UpDown = {
                audioName = "HUD_FREEMODE_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        },
        NativeUI = {
            UpDown = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        }
    },
    Items = {
        Title = {
            Background = { Width = 444, Height = 105 },
            Text = { X = 160, Y = 30, Scale = 0.20 },
        },
        Subtitle = {
            Background = { Width = 444, Height = 35 },
            Text = { X = 8, Y = 6, Scale = 0.26 },
            PreText = { X = 435, Y = 6, Scale = 0.26 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 444 },
        Navigation = {
            Rectangle = { Width = 444, Height = 18 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50 },
        },
        Description = {
            Bar = { Y = 4, Width = 444, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 444, Height = 30 },
            Text = { X = 8, Y = 10, Scale = 0.26 },
        },
    },
    Panels = {
        Grid = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 444, Height = 275 },
            Grid = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200 },
            Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
            Text = {
                Top = { X = 215.5, Y = 15, Scale = 0.36 },
                Bottom = { X = 215.5, Y = 250, Scale = 0.36 },
                Left = { X = 57.75, Y = 130, Scale = 0.36 },
                Right = { X = 373.25, Y = 130, Scale = 0.36 },
            },
        },
        Percentage = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 444, Height = 76 },
            Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
            Text = {
                Left = { X = 25, Y = 15, Scale = 0.35 },
                Middle = { X = 215.5, Y = 15, Scale = 0.35 },
                Right = { X = 398, Y = 15, Scale = 0.35 },
            },
        },
    },
}

function lgdUI.SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

function lgdUI.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(2, 239) * 1920) / 1920, math.round(GetControlNormal(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function lgdUI.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end

function lgdUI.Visible(Menu, Value)
    if Menu ~= nil and Menu() then
        if Value == true or Value == false then
            if Value then
                if lgdUI.CurrentMenu ~= nil then
                    if lgdUI.CurrentMenu.Closed ~= nil then
                        lgdUI.CurrentMenu.Closed()
                    end
                    lgdUI.CurrentMenu.Open = not Value
                    Menu:UpdateInstructionalButtons(Value);
                    Menu:UpdateCursorStyle();

                end
                lgdUI.CurrentMenu = Menu
            else
                lgdUI.CurrentMenu = nil
            end
            Menu.Open = Value
            lgdUI.Options = 0
            lgdUI.ItemOffset = 0
            lgdUI.LastControl = false
        else
            return Menu.Open
        end
    end
end

function lgdUI.CloseAll()
    if lgdUI.CurrentMenu ~= nil then
        local parent = lgdUI.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = parent.Pagination.Total
            parent = parent.Parent
        end
        lgdUI.CurrentMenu.Index = 1
        lgdUI.CurrentMenu.Pagination.Minimum = 1
        lgdUI.CurrentMenu.Pagination.Maximum = lgdUI.CurrentMenu.Pagination.Total
        lgdUI.CurrentMenu.Open = false
        lgdUI.CurrentMenu = nil
    end
    lgdUI.Options = 0
    lgdUI.ItemOffset = 0
    ResetScriptGfxAlign()
end

function lgdUI.Banner()
    local CurrentMenu = lgdUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Header) then
            lgdUI.ItemsSafeZone(CurrentMenu)
            if CurrentMenu.Sprite ~= nil then
                if CurrentMenu.Sprite.Dictionary ~= nil then
                    if CurrentMenu.Sprite.Dictionary == "tespascool" then
                        RenderSprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, lgdUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, lgdUI.Settings.Items.Title.Background.Height, CurrentMenu.Sprite.Color.R,CurrentMenu.Sprite.Color.G,CurrentMenu.Sprite.Color.B,CurrentMenu.Sprite.Color.A)
                    else
                        RenderSprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, lgdUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, lgdUI.Settings.Items.Title.Background.Height, nil)
                    end
                else
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y, lgdUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, lgdUI.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
                end
            else
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y, lgdUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, lgdUI.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
            end
            if (CurrentMenu.Display.Glare) then
                local ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
                ---@type number
                local Glarewidth = lgdUI.Settings.Items.Title.Background.Width
                ---@type number
                local Glareheight = lgdUI.Settings.Items.Title.Background.Height
                ---@type number
                local GlareX = CurrentMenu.X / 1920 + (CurrentMenu.SafeZoneSize.X / (62.399 - (CurrentMenu.WidthOffset * 0.065731)))
                ---@type number
                local GlareY = CurrentMenu.Y / 1080 + CurrentMenu.SafeZoneSize.Y / 33.895020746888
                lgdUI.SetScaleformParams(ScaleformMovie, {
                    { name = "SET_ROTATION", param = { GetGameplayCamRelativeHeading() } }
                })
                DrawScaleformMovie(ScaleformMovie, GlareX, GlareY, Glarewidth / 430, Glareheight / 100, 255, 255, 255, 255, 0)
            end
            RenderText(CurrentMenu.Title, CurrentMenu.X + lgdUI.Settings.Items.Title.Text.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + lgdUI.Settings.Items.Title.Text.Y, CurrentMenu.TitleFont, CurrentMenu.TitleScale, 255, 255, 255, 255, 1)
            lgdUI.ItemOffset = lgdUI.ItemOffset + lgdUI.Settings.Items.Title.Background.Height
        end
    end
end

function lgdUI.Subtitle()
    local CurrentMenu = lgdUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Subtitle) then
            lgdUI.ItemsSafeZone(CurrentMenu)
            if CurrentMenu.Subtitle ~= "" then
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y + lgdUI.ItemOffset, lgdUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset, lgdUI.Settings.Items.Subtitle.Background.Height + CurrentMenu.SubtitleHeight, 25, 25, 25, 235)
                RenderText(CurrentMenu.PageCounterColour .. CurrentMenu.Subtitle, CurrentMenu.X + lgdUI.Settings.Items.Subtitle.Text.X, CurrentMenu.Y + lgdUI.Settings.Items.Subtitle.Text.Y + lgdUI.ItemOffset, 0, lgdUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, lgdUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset)
                if CurrentMenu.Index > CurrentMenu.Options or CurrentMenu.Index < 0 then
                    CurrentMenu.Index = 1
                end
                if (CurrentMenu ~= nil) then
                    if (CurrentMenu.Index > CurrentMenu.Pagination.Total) then
                        local offset = CurrentMenu.Index - CurrentMenu.Pagination.Total
                        CurrentMenu.Pagination.Minimum = 1 + offset
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total + offset
                    else
                        CurrentMenu.Pagination.Minimum = 1
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total
                    end
                end
                
                if CurrentMenu.Display.PageCounter then
                    if CurrentMenu.PageCounter == nil then
                        RenderText(CurrentMenu.PageCounterColour .. CurrentMenu.Index .. " / " .. CurrentMenu.Options, CurrentMenu.X + lgdUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + lgdUI.Settings.Items.Subtitle.PreText.Y + lgdUI.ItemOffset, 0, lgdUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                    else
                        RenderText(CurrentMenu.PageCounter, CurrentMenu.X + lgdUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + lgdUI.Settings.Items.Subtitle.PreText.Y + lgdUI.ItemOffset, 0, lgdUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                    end
                end
                lgdUI.ItemOffset = lgdUI.ItemOffset + lgdUI.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

function lgdUI.Background()
    local CurrentMenu = lgdUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Background) then
            lgdUI.ItemsSafeZone(CurrentMenu)
            SetScriptGfxDrawOrder(0)
            -- RenderRectangle(CurrentMenu.X, CurrentMenu.Y + lgdUI.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight, lgdUI.Settings.Items.Background.Width + CurrentMenu.WidthOffset, lgdUI.Settings.Items.Subtitle.Background.Height + CurrentMenu.SubtitleHeight, 25, 25, 25, 225)
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + lgdUI.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight, lgdUI.Settings.Items.Background.Width + CurrentMenu.WidthOffset, lgdUI.ItemOffset, 0, 0, 0, 120)

            -- RenderSprite(lgdUI.Settings.Items.Background.Dictionary, lgdUI.Settings.Items.Background.Texture, CurrentMenu.X, CurrentMenu.Y + lgdUI.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight, lgdUI.Settings.Items.Background.Width + CurrentMenu.WidthOffset, lgdUI.ItemOffset, 0, 0, 0, 0, 255)
            SetScriptGfxDrawOrder(1)
        end
    end
end

function lgdUI.Description()
    local CurrentMenu = lgdUI.CurrentMenu;
    local Description = lgdUI.Settings.Items.Description;
    if CurrentMenu ~= nil and CurrentMenu.Description ~= nil then
        if CurrentMenu() then
            lgdUI.ItemsSafeZone(CurrentMenu)
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Description.Background.Y + CurrentMenu.SubtitleHeight + lgdUI.ItemOffset, Description.Background.Width + CurrentMenu.WidthOffset, CurrentMenu.DescriptionHeight, 0, 0, 0, 120)
            RenderText(CurrentMenu.Description, CurrentMenu.X + Description.Text.X, CurrentMenu.Y + Description.Text.Y + CurrentMenu.SubtitleHeight + lgdUI.ItemOffset, 0, Description.Text.Scale, 255, 255, 255, 255, nil, false, false, Description.Background.Width + CurrentMenu.WidthOffset - 8.0)
            lgdUI.ItemOffset = lgdUI.ItemOffset + CurrentMenu.DescriptionHeight + Description.Bar.Y
        end
    end
end

function lgdUI.Render()
    local CurrentMenu = lgdUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end

            if (CurrentMenu.Display.InstructionalButton) then
                if not CurrentMenu.InitScaleform then
                    CurrentMenu:UpdateInstructionalButtons(true)
                    CurrentMenu.InitScaleform = true
                end
                DrawScaleformMovieFullscreen(CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end
            CurrentMenu.Options = lgdUI.Options
            CurrentMenu.SafeZoneSize = nil
            lgdUI.Controls()
            lgdUI.Options = 0
            lgdUI.StatisticPanelCount = 0
            lgdUI.ItemOffset = 0
            if CurrentMenu.Controls.Back.Enabled then
                if CurrentMenu.Controls.Back.Pressed and CurrentMenu.Closable then
                    CurrentMenu.Controls.Back.Pressed = false
                    local Audio = lgdUI.Settings.Audio
                    lgdUI.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)

                    if CurrentMenu.Closed ~= nil then
                        collectgarbage()
                        CurrentMenu.Closed()
                    end

                    if CurrentMenu.Parent ~= nil then
                        if CurrentMenu.Parent() then
                            lgdUI.NextMenu = CurrentMenu.Parent
                            CurrentMenu:UpdateCursorStyle()
                        else
                            lgdUI.NextMenu = nil
                            lgdUI.Visible(CurrentMenu, false)
                        end
                    else
                        lgdUI.NextMenu = nil
                        lgdUI.Visible(CurrentMenu, false)
                    end
                elseif CurrentMenu.Controls.Back.Pressed and not CurrentMenu.Closable then
                    CurrentMenu.Controls.Back.Pressed = false
                end
            end
            if lgdUI.NextMenu ~= nil then
                if lgdUI.NextMenu() then
                    lgdUI.Visible(CurrentMenu, false)
                    lgdUI.Visible(lgdUI.NextMenu, true)
                    CurrentMenu.Controls.Select.Active = false
                    lgdUI.NextMenu = nil
                    lgdUI.LastControl = false
                end
            end
        end
    end
end

function lgdUI.ItemsDescription(CurrentMenu, Description, Selected)
    ---@type table
    if Description ~= "" or Description ~= nil then
        local SettingsDescription = lgdUI.Settings.Items.Description;
        if Selected and CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil
            ---@type number
            local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + lgdUI.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
            end
        end
    end
end

function lgdUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    ---@type boolean
    local Hovered = false
    Hovered = lgdUI.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + lgdUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + lgdUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            local Audio = lgdUI.Settings.Audio
            lgdUI.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
        end
    end
    return Hovered;
end

function lgdUI.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = lgdUI.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function lgdUI.CurrentIsEqualTo(Current, To, Style, DefaultStyle)
    return Current == To and Style or DefaultStyle or {};
end

function lgdUI.IsVisible(Menu, Items, Panels)
    if (lgdUI.Visible(Menu)) and (UpdateOnscreenKeyboard() ~= 0) and (UpdateOnscreenKeyboard() ~= 3) then
        lgdUI.Banner()
        lgdUI.Subtitle()
        if (Items ~= nil) then
            Items()
        end
        lgdUI.Background();
        lgdUI.Navigation();
        lgdUI.Description();
        if (Panels ~= nil) then
            Panels()
        end
        lgdUI.Render()
    end
end


---SetStyleAudio
---@param StyleAudio string
---@return void
---@public
function lgdUI.SetStyleAudio(StyleAudio)
    lgdUI.Settings.Audio.Use = StyleAudio or "lgdUI"
end

function lgdUI.GetStyleAudio()
    return lgdUI.Settings.Audio.Use or "lgdUI"
end



