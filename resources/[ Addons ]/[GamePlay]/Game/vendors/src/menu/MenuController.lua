---@type table
RageUIc.LastControl = false

---IsMouseInBounds
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@return number
---@public
function RageUIc.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(0, 239) * 1920) / 1920, math.round(GetControlNormal(0, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

---GetSafeZoneBounds
---@return table
---@public
function RageUIc.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end
---GoUp
---@param Options number
---@return nil
---@public
function RageUIc.GoUp(Options)
    if RageUIc.CurrentMenu ~= nil then
        Options = RageUIc.CurrentMenu.Options
        if RageUIc.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIc.CurrentMenu.Pagination.Total then
                    if RageUIc.CurrentMenu.Index <= RageUIc.CurrentMenu.Pagination.Minimum then
                        if RageUIc.CurrentMenu.Index == 1 then
                            RageUIc.CurrentMenu.Pagination.Minimum = Options - (RageUIc.CurrentMenu.Pagination.Total - 1)
                            RageUIc.CurrentMenu.Pagination.Maximum = Options
                            RageUIc.CurrentMenu.Index = Options
                        else
                            RageUIc.CurrentMenu.Pagination.Minimum = (RageUIc.CurrentMenu.Pagination.Minimum - 1)
                            RageUIc.CurrentMenu.Pagination.Maximum = (RageUIc.CurrentMenu.Pagination.Maximum - 1)
                            RageUIc.CurrentMenu.Index = RageUIc.CurrentMenu.Index - 1
                        end
                    else
                        RageUIc.CurrentMenu.Index = RageUIc.CurrentMenu.Index - 1
                    end
                else
                    if RageUIc.CurrentMenu.Index == 1 then
                        RageUIc.CurrentMenu.Pagination.Minimum = Options - (RageUIc.CurrentMenu.Pagination.Total - 1)
                        RageUIc.CurrentMenu.Pagination.Maximum = Options
                        RageUIc.CurrentMenu.Index = Options
                    else
                        RageUIc.CurrentMenu.Index = RageUIc.CurrentMenu.Index - 1
                    end
                end

                local Audio = RageUIc.Settings.Audio
                RageUIc.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIc.LastControl = true
            else
                local Audio = RageUIc.Settings.Audio
                RageUIc.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

---GoDown
---@param Options number
---@return nil
---@public
function RageUIc.GoDown(Options)
    if RageUIc.CurrentMenu ~= nil then
        Options = RageUIc.CurrentMenu.Options
        if RageUIc.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIc.CurrentMenu.Pagination.Total then
                    if RageUIc.CurrentMenu.Index >= RageUIc.CurrentMenu.Pagination.Maximum then
                        if RageUIc.CurrentMenu.Index == Options then
                            RageUIc.CurrentMenu.Pagination.Minimum = 1
                            RageUIc.CurrentMenu.Pagination.Maximum = RageUIc.CurrentMenu.Pagination.Total
                            RageUIc.CurrentMenu.Index = 1
                        else
                            RageUIc.CurrentMenu.Pagination.Maximum = (RageUIc.CurrentMenu.Pagination.Maximum + 1)
                            RageUIc.CurrentMenu.Pagination.Minimum = RageUIc.CurrentMenu.Pagination.Maximum - (RageUIc.CurrentMenu.Pagination.Total - 1)
                            RageUIc.CurrentMenu.Index = RageUIc.CurrentMenu.Index + 1
                        end
                    else
                        RageUIc.CurrentMenu.Index = RageUIc.CurrentMenu.Index + 1
                    end
                else
                    if RageUIc.CurrentMenu.Index == Options then
                        RageUIc.CurrentMenu.Pagination.Minimum = 1
                        RageUIc.CurrentMenu.Pagination.Maximum = RageUIc.CurrentMenu.Pagination.Total
                        RageUIc.CurrentMenu.Index = 1
                    else
                        RageUIc.CurrentMenu.Index = RageUIc.CurrentMenu.Index + 1
                    end
                end
                local Audio = RageUIc.Settings.Audio
                RageUIc.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIc.LastControl = false
            else
                local Audio = RageUIc.Settings.Audio
                RageUIc.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

function RageUIc.GoLeft(Controls)
    if Controls.Left.Enabled then
        for Index = 1, #Controls.Left.Keys do
            if not Controls.Left.Pressed then
                if IsDisabledControlJustPressed(Controls.Left.Keys[Index][1], Controls.Left.Keys[Index][2]) then
                    Controls.Left.Pressed = true

                    Citizen.CreateThread(function()
                        Controls.Left.Active = true

                        Citizen.Wait(0.01)

                        Controls.Left.Active = false

                        Citizen.Wait(174.99)

                        while Controls.Left.Enabled and IsDisabledControlPressed(Controls.Left.Keys[Index][1], Controls.Left.Keys[Index][2]) do
                            Controls.Left.Active = true

                            Citizen.Wait(0.01)

                            Controls.Left.Active = false

                            Citizen.Wait(124.99)
                        end

                        Controls.Left.Pressed = false
                        Wait(10)
                    end)

                    break
                end
            end
        end
    end
end

function RageUIc.GoRight(Controls)
    if Controls.Right.Enabled then
        for Index = 1, #Controls.Right.Keys do
            if not Controls.Right.Pressed then
                if IsDisabledControlJustPressed(Controls.Right.Keys[Index][1], Controls.Right.Keys[Index][2]) then
                    Controls.Right.Pressed = true

                    Citizen.CreateThread(function()
                        Controls.Right.Active = true

                        Citizen.Wait(0.01)

                        Controls.Right.Active = false

                        Citizen.Wait(174.99)

                        while Controls.Right.Enabled and IsDisabledControlPressed(Controls.Right.Keys[Index][1], Controls.Right.Keys[Index][2]) do
                            Controls.Right.Active = true

                            Citizen.Wait(1)

                            Controls.Right.Active = false

                            Citizen.Wait(124.99)
                        end

                        Controls.Right.Pressed = false
                        Wait(10)
                    end)

                    break
                end
            end
        end
    end
end

function RageUIc.GoSliderLeft(Controls)
    if Controls.SliderLeft.Enabled then
        for Index = 1, #Controls.SliderLeft.Keys do
            if not Controls.SliderLeft.Pressed then
                if IsDisabledControlJustPressed(Controls.SliderLeft.Keys[Index][1], Controls.SliderLeft.Keys[Index][2]) then
                    Controls.SliderLeft.Pressed = true
                    Citizen.CreateThread(function()
                        Controls.SliderLeft.Active = true
                        Citizen.Wait(1)
                        Controls.SliderLeft.Active = false
                        while Controls.SliderLeft.Enabled and IsDisabledControlPressed(Controls.SliderLeft.Keys[Index][1], Controls.SliderLeft.Keys[Index][2]) do
                            Controls.SliderLeft.Active = true
                            Citizen.Wait(1)
                            Controls.SliderLeft.Active = false
                        end
                        Controls.SliderLeft.Pressed = false
                    end)
                    break
                end
            end
        end
    end
end

function RageUIc.GoSliderRight(Controls)
    if Controls.SliderRight.Enabled then
        for Index = 1, #Controls.SliderRight.Keys do
            if not Controls.SliderRight.Pressed then
                if IsDisabledControlJustPressed(Controls.SliderRight.Keys[Index][1], Controls.SliderRight.Keys[Index][2]) then
                    Controls.SliderRight.Pressed = true
                    Citizen.CreateThread(function()
                        Controls.SliderRight.Active = true
                        Citizen.Wait(1)
                        Controls.SliderRight.Active = false
                        while Controls.SliderRight.Enabled and IsDisabledControlPressed(Controls.SliderRight.Keys[Index][1], Controls.SliderRight.Keys[Index][2]) do
                            Controls.SliderRight.Active = true
                            Citizen.Wait(1)
                            Controls.SliderRight.Active = false
                        end
                        Controls.SliderRight.Pressed = false
                    end)
                    break
                end
            end
        end
    end
end

---Controls
---@return nil
---@public
function RageUIc.Controls()
    if RageUIc.CurrentMenu ~= nil then
        if RageUIc.CurrentMenu() then
            if RageUIc.CurrentMenu.Open then

                local Controls = RageUIc.CurrentMenu.Controls;
                ---@type number
                local Options = RageUIc.CurrentMenu.Options
                RageUIc.Options = RageUIc.CurrentMenu.Options
                if RageUIc.CurrentMenu.EnableMouse then
                    DisableAllControlActions(2)
                end

                if not IsInputDisabled(2) then
                    for Index = 1, #Controls.Enabled.Controller do
                        EnableControlAction(Controls.Enabled.Controller[Index][1], Controls.Enabled.Controller[Index][2], true)
                    end
                else
                    for Index = 1, #Controls.Enabled.Keyboard do
                        EnableControlAction(Controls.Enabled.Keyboard[Index][1], Controls.Enabled.Keyboard[Index][2], true)
                    end
                end

                if Controls.Up.Enabled then
                    for Index = 1, #Controls.Up.Keys do
                        if not Controls.Up.Pressed then
                            if IsDisabledControlJustPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) then
                                Controls.Up.Pressed = true

                                Citizen.CreateThread(function()
                                    RageUIc.GoUp(Options)

                                    Citizen.Wait(175)

                                    while Controls.Up.Enabled and IsDisabledControlPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) do
                                        RageUIc.GoUp(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Up.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                if Controls.Down.Enabled then
                    for Index = 1, #Controls.Down.Keys do
                        if not Controls.Down.Pressed then
                            if IsDisabledControlJustPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) then
                                Controls.Down.Pressed = true

                                Citizen.CreateThread(function()
                                    RageUIc.GoDown(Options)

                                    Citizen.Wait(175)

                                    while Controls.Down.Enabled and IsDisabledControlPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) do
                                        RageUIc.GoDown(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Down.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                RageUIc.GoLeft(Controls)
                --- Default Left navigation
                RageUIc.GoRight(Controls) --- Default Right navigation

                RageUIc.GoSliderLeft(Controls)
                RageUIc.GoSliderRight(Controls)

                if Controls.Select.Enabled then
                    for Index = 1, #Controls.Select.Keys do
                        if not Controls.Select.Pressed then
                            if IsDisabledControlJustPressed(Controls.Select.Keys[Index][1], Controls.Select.Keys[Index][2]) then
                                Controls.Select.Pressed = true

                                Citizen.CreateThread(function()
                                    Controls.Select.Active = true

                                    Citizen.Wait(0.01)

                                    Controls.Select.Active = false

                                    Citizen.Wait(174.99)

                                    while Controls.Select.Enabled and IsDisabledControlPressed(Controls.Select.Keys[Index][1], Controls.Select.Keys[Index][2]) do
                                        Controls.Select.Active = true

                                        Citizen.Wait(0.01)

                                        Controls.Select.Active = false

                                        Citizen.Wait(124.99)
                                    end

                                    Controls.Select.Pressed = false

                                end)

                                break
                            end
                        end
                    end
                end

                if Controls.Click.Enabled then
                    for Index = 1, #Controls.Click.Keys do
                        if not Controls.Click.Pressed then
                            if IsDisabledControlJustPressed(Controls.Click.Keys[Index][1], Controls.Click.Keys[Index][2]) then
                                Controls.Click.Pressed = true

                                Citizen.CreateThread(function()
                                    Controls.Click.Active = true

                                    Citizen.Wait(0.01)

                                    Controls.Click.Active = false

                                    Citizen.Wait(174.99)

                                    while Controls.Click.Enabled and IsDisabledControlPressed(Controls.Click.Keys[Index][1], Controls.Click.Keys[Index][2]) do
                                        Controls.Click.Active = true

                                        Citizen.Wait(0.01)

                                        Controls.Click.Active = false

                                        Citizen.Wait(124.99)
                                    end

                                    Controls.Click.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end
                if Controls.Back.Enabled then
                    for Index = 1, #Controls.Back.Keys do
                        if not Controls.Back.Pressed then
                            if IsDisabledControlJustPressed(Controls.Back.Keys[Index][1], Controls.Back.Keys[Index][2]) then
                                Controls.Back.Pressed = true
                                Wait(10)
                                break
                            end
                        end
                    end
                end

            end
        end
    end
end

---Navigation
---@return nil
---@public
function RageUIc.Navigation()
    if RageUIc.CurrentMenu ~= nil then
        if RageUIc.CurrentMenu() then
            if RageUIc.CurrentMenu.EnableMouse   then
                SetMouseCursorActiveThisFrame()
            end
            if RageUIc.Options > RageUIc.CurrentMenu.Pagination.Total then

                ---@type boolean
                local UpHovered = false

                ---@type boolean
                local DownHovered = false

                if not RageUIc.CurrentMenu.SafeZoneSize then
                    RageUIc.CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

                    if RageUIc.CurrentMenu.Safezone then
                        RageUIc.CurrentMenu.SafeZoneSize = RageUIc.GetSafeZoneBounds()

                        SetScriptGfxAlign(76, 84)
                        SetScriptGfxAlignParams(0, 0, 0, 0)
                    end
                end

                UpHovered = RageUIc.IsMouseInBounds(RageUIc.CurrentMenu.X + RageUIc.CurrentMenu.SafeZoneSize.X, RageUIc.CurrentMenu.Y + RageUIc.CurrentMenu.SafeZoneSize.Y + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height)
                DownHovered = RageUIc.IsMouseInBounds(RageUIc.CurrentMenu.X + RageUIc.CurrentMenu.SafeZoneSize.X, RageUIc.CurrentMenu.Y + RageUIc.Settings.Items.Navigation.Rectangle.Height + RageUIc.CurrentMenu.SafeZoneSize.Y + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height)

                if RageUIc.CurrentMenu.EnableMouse   then


                    if RageUIc.CurrentMenu.Controls.Click.Active then
                        if UpHovered then
                            RageUIc.GoUp(RageUIc.Options)
                        elseif DownHovered then
                            RageUIc.GoDown(RageUIc.Options)
                        end
                    end

                    if UpHovered then
                        RenderRectangle(RageUIc.CurrentMenu.X, RageUIc.CurrentMenu.Y + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIc.CurrentMenu.X, RageUIc.CurrentMenu.Y + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end

                    if DownHovered then
                        RenderRectangle(RageUIc.CurrentMenu.X, RageUIc.CurrentMenu.Y + RageUIc.Settings.Items.Navigation.Rectangle.Height + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIc.CurrentMenu.X, RageUIc.CurrentMenu.Y + RageUIc.Settings.Items.Navigation.Rectangle.Height + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end
                else
                    RenderRectangle(RageUIc.CurrentMenu.X, RageUIc.CurrentMenu.Y + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    RenderRectangle(RageUIc.CurrentMenu.X, RageUIc.CurrentMenu.Y + RageUIc.Settings.Items.Navigation.Rectangle.Height + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Rectangle.Width + RageUIc.CurrentMenu.WidthOffset, RageUIc.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                end
                RenderSprite(RageUIc.Settings.Items.Navigation.Arrows.Dictionary, RageUIc.Settings.Items.Navigation.Arrows.Texture, RageUIc.CurrentMenu.X + RageUIc.Settings.Items.Navigation.Arrows.X + (RageUIc.CurrentMenu.WidthOffset / 2), RageUIc.CurrentMenu.Y + RageUIc.Settings.Items.Navigation.Arrows.Y + RageUIc.CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, RageUIc.Settings.Items.Navigation.Arrows.Width, RageUIc.Settings.Items.Navigation.Arrows.Height)

                RageUIc.ItemOffset = RageUIc.ItemOffset + (RageUIc.Settings.Items.Navigation.Rectangle.Height * 2)

            end
        end
    end
end

---GoBack
---@return nil
---@public
function RageUIc.GoBack()
    if RageUIc.CurrentMenu ~= nil then
        local Audio = RageUIc.Settings.Audio
        RageUIc.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
        if RageUIc.CurrentMenu.Parent ~= nil then
            if RageUIc.CurrentMenu.Parent() then
                RageUIc.NextMenu = RageUIc.CurrentMenu.Parent
            else
                RageUIc.NextMenu = nil
                RageUIc.Visible(RageUIc.CurrentMenu, false)
            end
        else
            RageUIc.NextMenu = nil
            RageUIc.Visible(RageUIc.CurrentMenu, false)
        end
    end
end
