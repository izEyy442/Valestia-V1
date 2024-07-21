---@type table
RageUIv2.LastControl = false

---IsMouseInBounds
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@return number
---@public
function RageUIv2.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(0, 239) * 1920) / 1920, math.round(GetControlNormal(0, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

---GetSafeZoneBounds
---@return table
---@public
function RageUIv2.GetSafeZoneBounds()
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
function RageUIv2.GoUp(Options)
    if RageUIv2.CurrentMenu ~= nil then
        Options = RageUIv2.CurrentMenu.Options
        if RageUIv2.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIv2.CurrentMenu.Pagination.Total then
                    if RageUIv2.CurrentMenu.Index <= RageUIv2.CurrentMenu.Pagination.Minimum then
                        if RageUIv2.CurrentMenu.Index == 1 then
                            RageUIv2.CurrentMenu.Pagination.Minimum = Options - (RageUIv2.CurrentMenu.Pagination.Total - 1)
                            RageUIv2.CurrentMenu.Pagination.Maximum = Options
                            RageUIv2.CurrentMenu.Index = Options
                        else
                            RageUIv2.CurrentMenu.Pagination.Minimum = (RageUIv2.CurrentMenu.Pagination.Minimum - 1)
                            RageUIv2.CurrentMenu.Pagination.Maximum = (RageUIv2.CurrentMenu.Pagination.Maximum - 1)
                            RageUIv2.CurrentMenu.Index = RageUIv2.CurrentMenu.Index - 1
                        end
                    else
                        RageUIv2.CurrentMenu.Index = RageUIv2.CurrentMenu.Index - 1
                    end
                else
                    if RageUIv2.CurrentMenu.Index == 1 then
                        RageUIv2.CurrentMenu.Pagination.Minimum = Options - (RageUIv2.CurrentMenu.Pagination.Total - 1)
                        RageUIv2.CurrentMenu.Pagination.Maximum = Options
                        RageUIv2.CurrentMenu.Index = Options
                    else
                        RageUIv2.CurrentMenu.Index = RageUIv2.CurrentMenu.Index - 1
                    end
                end

                local Audio = RageUIv2.Settings.Audio
                RageUIv2.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIv2.LastControl = true
            else
                local Audio = RageUIv2.Settings.Audio
                RageUIv2.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

---GoDown
---@param Options number
---@return nil
---@public
function RageUIv2.GoDown(Options)
    if RageUIv2.CurrentMenu ~= nil then
        Options = RageUIv2.CurrentMenu.Options
        if RageUIv2.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIv2.CurrentMenu.Pagination.Total then
                    if RageUIv2.CurrentMenu.Index >= RageUIv2.CurrentMenu.Pagination.Maximum then
                        if RageUIv2.CurrentMenu.Index == Options then
                            RageUIv2.CurrentMenu.Pagination.Minimum = 1
                            RageUIv2.CurrentMenu.Pagination.Maximum = RageUIv2.CurrentMenu.Pagination.Total
                            RageUIv2.CurrentMenu.Index = 1
                        else
                            RageUIv2.CurrentMenu.Pagination.Maximum = (RageUIv2.CurrentMenu.Pagination.Maximum + 1)
                            RageUIv2.CurrentMenu.Pagination.Minimum = RageUIv2.CurrentMenu.Pagination.Maximum - (RageUIv2.CurrentMenu.Pagination.Total - 1)
                            RageUIv2.CurrentMenu.Index = RageUIv2.CurrentMenu.Index + 1
                        end
                    else
                        RageUIv2.CurrentMenu.Index = RageUIv2.CurrentMenu.Index + 1
                    end
                else
                    if RageUIv2.CurrentMenu.Index == Options then
                        RageUIv2.CurrentMenu.Pagination.Minimum = 1
                        RageUIv2.CurrentMenu.Pagination.Maximum = RageUIv2.CurrentMenu.Pagination.Total
                        RageUIv2.CurrentMenu.Index = 1
                    else
                        RageUIv2.CurrentMenu.Index = RageUIv2.CurrentMenu.Index + 1
                    end
                end
                local Audio = RageUIv2.Settings.Audio
                RageUIv2.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIv2.LastControl = false
            else
                local Audio = RageUIv2.Settings.Audio
                RageUIv2.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

function RageUIv2.GoLeft(Controls)
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

function RageUIv2.GoRight(Controls)
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

function RageUIv2.GoSliderLeft(Controls)
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

function RageUIv2.GoSliderRight(Controls)
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
function RageUIv2.Controls()
    if RageUIv2.CurrentMenu ~= nil then
        if RageUIv2.CurrentMenu() then
            if RageUIv2.CurrentMenu.Open then

                local Controls = RageUIv2.CurrentMenu.Controls;
                ---@type number
                local Options = RageUIv2.CurrentMenu.Options
                RageUIv2.Options = RageUIv2.CurrentMenu.Options
                if RageUIv2.CurrentMenu.EnableMouse then
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
                                    RageUIv2.GoUp(Options)

                                    Citizen.Wait(175)

                                    while Controls.Up.Enabled and IsDisabledControlPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) do
                                        RageUIv2.GoUp(Options)

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
                                    RageUIv2.GoDown(Options)

                                    Citizen.Wait(175)

                                    while Controls.Down.Enabled and IsDisabledControlPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) do
                                        RageUIv2.GoDown(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Down.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                RageUIv2.GoLeft(Controls)
                --- Default Left navigation
                RageUIv2.GoRight(Controls) --- Default Right navigation

                RageUIv2.GoSliderLeft(Controls)
                RageUIv2.GoSliderRight(Controls)

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
function RageUIv2.Navigation()
    if RageUIv2.CurrentMenu ~= nil then
        if RageUIv2.CurrentMenu() then
            if RageUIv2.CurrentMenu.EnableMouse   then
                SetMouseCursorActiveThisFrame()
            end
            if RageUIv2.Options > RageUIv2.CurrentMenu.Pagination.Total then

                ---@type boolean
                local UpHovered = false

                ---@type boolean
                local DownHovered = false

                if not RageUIv2.CurrentMenu.SafeZoneSize then
                    RageUIv2.CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

                    if RageUIv2.CurrentMenu.Safezone then
                        RageUIv2.CurrentMenu.SafeZoneSize = RageUIv2.GetSafeZoneBounds()

                        SetScriptGfxAlign(76, 84)
                        SetScriptGfxAlignParams(0, 0, 0, 0)
                    end
                end

                UpHovered = RageUIv2.IsMouseInBounds(RageUIv2.CurrentMenu.X + RageUIv2.CurrentMenu.SafeZoneSize.X, RageUIv2.CurrentMenu.Y + RageUIv2.CurrentMenu.SafeZoneSize.Y + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height)
                DownHovered = RageUIv2.IsMouseInBounds(RageUIv2.CurrentMenu.X + RageUIv2.CurrentMenu.SafeZoneSize.X, RageUIv2.CurrentMenu.Y + RageUIv2.Settings.Items.Navigation.Rectangle.Height + RageUIv2.CurrentMenu.SafeZoneSize.Y + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height)

                if RageUIv2.CurrentMenu.EnableMouse   then


                    if RageUIv2.CurrentMenu.Controls.Click.Active then
                        if UpHovered then
                            RageUIv2.GoUp(RageUIv2.Options)
                        elseif DownHovered then
                            RageUIv2.GoDown(RageUIv2.Options)
                        end
                    end

                    if UpHovered then
                        RenderRectangle(RageUIv2.CurrentMenu.X, RageUIv2.CurrentMenu.Y + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIv2.CurrentMenu.X, RageUIv2.CurrentMenu.Y + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end

                    if DownHovered then
                        RenderRectangle(RageUIv2.CurrentMenu.X, RageUIv2.CurrentMenu.Y + RageUIv2.Settings.Items.Navigation.Rectangle.Height + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIv2.CurrentMenu.X, RageUIv2.CurrentMenu.Y + RageUIv2.Settings.Items.Navigation.Rectangle.Height + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end
                else
                    RenderRectangle(RageUIv2.CurrentMenu.X, RageUIv2.CurrentMenu.Y + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    RenderRectangle(RageUIv2.CurrentMenu.X, RageUIv2.CurrentMenu.Y + RageUIv2.Settings.Items.Navigation.Rectangle.Height + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Width + RageUIv2.CurrentMenu.WidthOffset, RageUIv2.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                end
                RenderSprite(RageUIv2.Settings.Items.Navigation.Arrows.Dictionary, RageUIv2.Settings.Items.Navigation.Arrows.Texture, RageUIv2.CurrentMenu.X + RageUIv2.Settings.Items.Navigation.Arrows.X + (RageUIv2.CurrentMenu.WidthOffset / 2), RageUIv2.CurrentMenu.Y + RageUIv2.Settings.Items.Navigation.Arrows.Y + RageUIv2.CurrentMenu.SubtitleHeight + RageUIv2.ItemOffset, RageUIv2.Settings.Items.Navigation.Arrows.Width, RageUIv2.Settings.Items.Navigation.Arrows.Height)

                RageUIv2.ItemOffset = RageUIv2.ItemOffset + (RageUIv2.Settings.Items.Navigation.Rectangle.Height * 2)

            end
        end
    end
end

---GoBack
---@return nil
---@public
function RageUIv2.GoBack()
    if RageUIv2.CurrentMenu ~= nil then
        local Audio = RageUIv2.Settings.Audio
        RageUIv2.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
        if RageUIv2.CurrentMenu.Parent ~= nil then
            if RageUIv2.CurrentMenu.Parent() then
                RageUIv2.NextMenu = RageUIv2.CurrentMenu.Parent
            else
                RageUIv2.NextMenu = nil
                RageUIv2.Visible(RageUIv2.CurrentMenu, false)
            end
        else
            RageUIv2.NextMenu = nil
            RageUIv2.Visible(RageUIv2.CurrentMenu, false)
        end
    end
end
