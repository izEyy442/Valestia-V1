---@type table
RageUIv1.LastControl = false

---IsMouseInBounds
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@return number
---@public
function RageUIv1.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(0, 239) * 1920) / 1920, math.round(GetControlNormal(0, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

---GetSafeZoneBounds
---@return table
---@public
function RageUIv1.GetSafeZoneBounds()
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
function RageUIv1.GoUp(Options)
    if RageUIv1.CurrentMenu ~= nil then
        Options = RageUIv1.CurrentMenu.Options
        if RageUIv1.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIv1.CurrentMenu.Pagination.Total then
                    if RageUIv1.CurrentMenu.Index <= RageUIv1.CurrentMenu.Pagination.Minimum then
                        if RageUIv1.CurrentMenu.Index == 1 then
                            RageUIv1.CurrentMenu.Pagination.Minimum = Options - (RageUIv1.CurrentMenu.Pagination.Total - 1)
                            RageUIv1.CurrentMenu.Pagination.Maximum = Options
                            RageUIv1.CurrentMenu.Index = Options
                        else
                            RageUIv1.CurrentMenu.Pagination.Minimum = (RageUIv1.CurrentMenu.Pagination.Minimum - 1)
                            RageUIv1.CurrentMenu.Pagination.Maximum = (RageUIv1.CurrentMenu.Pagination.Maximum - 1)
                            RageUIv1.CurrentMenu.Index = RageUIv1.CurrentMenu.Index - 1
                        end
                    else
                        RageUIv1.CurrentMenu.Index = RageUIv1.CurrentMenu.Index - 1
                    end
                else
                    if RageUIv1.CurrentMenu.Index == 1 then
                        RageUIv1.CurrentMenu.Pagination.Minimum = Options - (RageUIv1.CurrentMenu.Pagination.Total - 1)
                        RageUIv1.CurrentMenu.Pagination.Maximum = Options
                        RageUIv1.CurrentMenu.Index = Options
                    else
                        RageUIv1.CurrentMenu.Index = RageUIv1.CurrentMenu.Index - 1
                    end
                end

                local Audio = RageUIv1.Settings.Audio
                RageUIv1.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIv1.LastControl = true
            else
                local Audio = RageUIv1.Settings.Audio
                RageUIv1.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

---GoDown
---@param Options number
---@return nil
---@public
function RageUIv1.GoDown(Options)
    if RageUIv1.CurrentMenu ~= nil then
        Options = RageUIv1.CurrentMenu.Options
        if RageUIv1.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIv1.CurrentMenu.Pagination.Total then
                    if RageUIv1.CurrentMenu.Index >= RageUIv1.CurrentMenu.Pagination.Maximum then
                        if RageUIv1.CurrentMenu.Index == Options then
                            RageUIv1.CurrentMenu.Pagination.Minimum = 1
                            RageUIv1.CurrentMenu.Pagination.Maximum = RageUIv1.CurrentMenu.Pagination.Total
                            RageUIv1.CurrentMenu.Index = 1
                        else
                            RageUIv1.CurrentMenu.Pagination.Maximum = (RageUIv1.CurrentMenu.Pagination.Maximum + 1)
                            RageUIv1.CurrentMenu.Pagination.Minimum = RageUIv1.CurrentMenu.Pagination.Maximum - (RageUIv1.CurrentMenu.Pagination.Total - 1)
                            RageUIv1.CurrentMenu.Index = RageUIv1.CurrentMenu.Index + 1
                        end
                    else
                        RageUIv1.CurrentMenu.Index = RageUIv1.CurrentMenu.Index + 1
                    end
                else
                    if RageUIv1.CurrentMenu.Index == Options then
                        RageUIv1.CurrentMenu.Pagination.Minimum = 1
                        RageUIv1.CurrentMenu.Pagination.Maximum = RageUIv1.CurrentMenu.Pagination.Total
                        RageUIv1.CurrentMenu.Index = 1
                    else
                        RageUIv1.CurrentMenu.Index = RageUIv1.CurrentMenu.Index + 1
                    end
                end
                local Audio = RageUIv1.Settings.Audio
                RageUIv1.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIv1.LastControl = false
            else
                local Audio = RageUIv1.Settings.Audio
                RageUIv1.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

function RageUIv1.GoLeft(Controls)
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

function RageUIv1.GoRight(Controls)
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

function RageUIv1.GoSliderLeft(Controls)
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

function RageUIv1.GoSliderRight(Controls)
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
function RageUIv1.Controls()
    if RageUIv1.CurrentMenu ~= nil then
        if RageUIv1.CurrentMenu() then
            if RageUIv1.CurrentMenu.Open then

                local Controls = RageUIv1.CurrentMenu.Controls;
                ---@type number
                local Options = RageUIv1.CurrentMenu.Options
                RageUIv1.Options = RageUIv1.CurrentMenu.Options
                if RageUIv1.CurrentMenu.EnableMouse then
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
                                    RageUIv1.GoUp(Options)

                                    Citizen.Wait(175)

                                    while Controls.Up.Enabled and IsDisabledControlPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) do
                                        RageUIv1.GoUp(Options)

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
                                    RageUIv1.GoDown(Options)

                                    Citizen.Wait(175)

                                    while Controls.Down.Enabled and IsDisabledControlPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) do
                                        RageUIv1.GoDown(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Down.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                RageUIv1.GoLeft(Controls)
                --- Default Left navigation
                RageUIv1.GoRight(Controls) --- Default Right navigation

                RageUIv1.GoSliderLeft(Controls)
                RageUIv1.GoSliderRight(Controls)

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
function RageUIv1.Navigation()
    if RageUIv1.CurrentMenu ~= nil then
        if RageUIv1.CurrentMenu() then
            if RageUIv1.CurrentMenu.EnableMouse   then
                SetMouseCursorActiveThisFrame()
            end
            if RageUIv1.Options > RageUIv1.CurrentMenu.Pagination.Total then

                ---@type boolean
                local UpHovered = false

                ---@type boolean
                local DownHovered = false

                if not RageUIv1.CurrentMenu.SafeZoneSize then
                    RageUIv1.CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

                    if RageUIv1.CurrentMenu.Safezone then
                        RageUIv1.CurrentMenu.SafeZoneSize = RageUIv1.GetSafeZoneBounds()

                        SetScriptGfxAlign(76, 84)
                        SetScriptGfxAlignParams(0, 0, 0, 0)
                    end
                end

                UpHovered = RageUIv1.IsMouseInBounds(RageUIv1.CurrentMenu.X + RageUIv1.CurrentMenu.SafeZoneSize.X, RageUIv1.CurrentMenu.Y + RageUIv1.CurrentMenu.SafeZoneSize.Y + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height)
                DownHovered = RageUIv1.IsMouseInBounds(RageUIv1.CurrentMenu.X + RageUIv1.CurrentMenu.SafeZoneSize.X, RageUIv1.CurrentMenu.Y + RageUIv1.Settings.Items.Navigation.Rectangle.Height + RageUIv1.CurrentMenu.SafeZoneSize.Y + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height)

                if RageUIv1.CurrentMenu.EnableMouse   then


                    if RageUIv1.CurrentMenu.Controls.Click.Active then
                        if UpHovered then
                            RageUIv1.GoUp(RageUIv1.Options)
                        elseif DownHovered then
                            RageUIv1.GoDown(RageUIv1.Options)
                        end
                    end

                    if UpHovered then
                        RenderRectangle(RageUIv1.CurrentMenu.X, RageUIv1.CurrentMenu.Y + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIv1.CurrentMenu.X, RageUIv1.CurrentMenu.Y + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end

                    if DownHovered then
                        RenderRectangle(RageUIv1.CurrentMenu.X, RageUIv1.CurrentMenu.Y + RageUIv1.Settings.Items.Navigation.Rectangle.Height + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIv1.CurrentMenu.X, RageUIv1.CurrentMenu.Y + RageUIv1.Settings.Items.Navigation.Rectangle.Height + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end
                else
                    RenderRectangle(RageUIv1.CurrentMenu.X, RageUIv1.CurrentMenu.Y + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    RenderRectangle(RageUIv1.CurrentMenu.X, RageUIv1.CurrentMenu.Y + RageUIv1.Settings.Items.Navigation.Rectangle.Height + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Width + RageUIv1.CurrentMenu.WidthOffset, RageUIv1.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                end
                RenderSprite(RageUIv1.Settings.Items.Navigation.Arrows.Dictionary, RageUIv1.Settings.Items.Navigation.Arrows.Texture, RageUIv1.CurrentMenu.X + RageUIv1.Settings.Items.Navigation.Arrows.X + (RageUIv1.CurrentMenu.WidthOffset / 2), RageUIv1.CurrentMenu.Y + RageUIv1.Settings.Items.Navigation.Arrows.Y + RageUIv1.CurrentMenu.SubtitleHeight + RageUIv1.ItemOffset, RageUIv1.Settings.Items.Navigation.Arrows.Width, RageUIv1.Settings.Items.Navigation.Arrows.Height)

                RageUIv1.ItemOffset = RageUIv1.ItemOffset + (RageUIv1.Settings.Items.Navigation.Rectangle.Height * 2)

            end
        end
    end
end

---GoBack
---@return nil
---@public
function RageUIv1.GoBack()
    if RageUIv1.CurrentMenu ~= nil then
        local Audio = RageUIv1.Settings.Audio
        RageUIv1.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
        if RageUIv1.CurrentMenu.Parent ~= nil then
            if RageUIv1.CurrentMenu.Parent() then
                RageUIv1.NextMenu = RageUIv1.CurrentMenu.Parent
            else
                RageUIv1.NextMenu = nil
                RageUIv1.Visible(RageUIv1.CurrentMenu, false)
            end
        else
            RageUIv1.NextMenu = nil
            RageUIv1.Visible(RageUIv1.CurrentMenu, false)
        end
    end
end
