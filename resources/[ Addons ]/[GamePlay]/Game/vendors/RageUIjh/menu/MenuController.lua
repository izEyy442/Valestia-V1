---@type table
RageUIjh.LastControl = false

---IsMouseInBounds
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@return number
---@public
function RageUIjh.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(2, 239) * 1920) / 1920, math.round(GetControlNormal(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

---GetSafeZoneBounds
---@return table
---@public
function RageUIjh.GetSafeZoneBounds()
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
function RageUIjh.GoUp(Options)
    if RageUIjh.CurrentMenu ~= nil then
        Options = RageUIjh.CurrentMenu.Options
        if RageUIjh.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIjh.CurrentMenu.Pagination.Total then
                    if RageUIjh.CurrentMenu.Index <= RageUIjh.CurrentMenu.Pagination.Minimum then
                        if RageUIjh.CurrentMenu.Index == 1 then
                            RageUIjh.CurrentMenu.Pagination.Minimum = Options - (RageUIjh.CurrentMenu.Pagination.Total - 1)
                            RageUIjh.CurrentMenu.Pagination.Maximum = Options
                            RageUIjh.CurrentMenu.Index = Options
                        else
                            RageUIjh.CurrentMenu.Pagination.Minimum = (RageUIjh.CurrentMenu.Pagination.Minimum - 1)
                            RageUIjh.CurrentMenu.Pagination.Maximum = (RageUIjh.CurrentMenu.Pagination.Maximum - 1)
                            RageUIjh.CurrentMenu.Index = RageUIjh.CurrentMenu.Index - 1
                        end
                    else
                        RageUIjh.CurrentMenu.Index = RageUIjh.CurrentMenu.Index - 1
                    end
                else
                    if RageUIjh.CurrentMenu.Index == 1 then
                        RageUIjh.CurrentMenu.Pagination.Minimum = Options - (RageUIjh.CurrentMenu.Pagination.Total - 1)
                        RageUIjh.CurrentMenu.Pagination.Maximum = Options
                        RageUIjh.CurrentMenu.Index = Options
                    else
                        RageUIjh.CurrentMenu.Index = RageUIjh.CurrentMenu.Index - 1
                    end
                end

                local Audio = RageUIjh.Settings.Audio
                RageUIjh.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIjh.LastControl = true
                if (RageUIjh.CurrentMenu.onIndexChange ~= nil) then
                    RageUIjh.CurrentMenu.onIndexChange(RageUIjh.CurrentMenu.Index)
                end
            else
                local Audio = RageUIjh.Settings.Audio
                RageUIjh.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

---GoDown
---@param Options number
---@return nil
---@public
function RageUIjh.GoDown(Options)
    if RageUIjh.CurrentMenu ~= nil then
        Options = RageUIjh.CurrentMenu.Options
        if RageUIjh.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIjh.CurrentMenu.Pagination.Total then
                    if RageUIjh.CurrentMenu.Index >= RageUIjh.CurrentMenu.Pagination.Maximum then
                        if RageUIjh.CurrentMenu.Index == Options then
                            RageUIjh.CurrentMenu.Pagination.Minimum = 1
                            RageUIjh.CurrentMenu.Pagination.Maximum = RageUIjh.CurrentMenu.Pagination.Total
                            RageUIjh.CurrentMenu.Index = 1
                        else
                            RageUIjh.CurrentMenu.Pagination.Maximum = (RageUIjh.CurrentMenu.Pagination.Maximum + 1)
                            RageUIjh.CurrentMenu.Pagination.Minimum = RageUIjh.CurrentMenu.Pagination.Maximum - (RageUIjh.CurrentMenu.Pagination.Total - 1)
                            RageUIjh.CurrentMenu.Index = RageUIjh.CurrentMenu.Index + 1
                        end
                    else
                        RageUIjh.CurrentMenu.Index = RageUIjh.CurrentMenu.Index + 1
                    end
                else
                    if RageUIjh.CurrentMenu.Index == Options then
                        RageUIjh.CurrentMenu.Pagination.Minimum = 1
                        RageUIjh.CurrentMenu.Pagination.Maximum = RageUIjh.CurrentMenu.Pagination.Total
                        RageUIjh.CurrentMenu.Index = 1
                    else
                        RageUIjh.CurrentMenu.Index = RageUIjh.CurrentMenu.Index + 1
                    end
                end
                local Audio = RageUIjh.Settings.Audio
                RageUIjh.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIjh.LastControl = false
                if (RageUIjh.CurrentMenu.onIndexChange ~= nil) then
                    RageUIjh.CurrentMenu.onIndexChange(RageUIjh.CurrentMenu.Index)
                end
            else
                local Audio = RageUIjh.Settings.Audio
                RageUIjh.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

function RageUIjh.GoLeft(Controls)
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

function RageUIjh.GoRight(Controls)
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

function RageUIjh.GoSliderLeft(Controls)
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

function RageUIjh.GoSliderRight(Controls)
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
function RageUIjh.Controls()
    if RageUIjh.CurrentMenu ~= nil then
        if RageUIjh.CurrentMenu() then
            if RageUIjh.CurrentMenu.Open then

                local Controls = RageUIjh.CurrentMenu.Controls;
                ---@type number
                local Options = RageUIjh.CurrentMenu.Options
                RageUIjh.Options = RageUIjh.CurrentMenu.Options
                if RageUIjh.CurrentMenu.EnableMouse then
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
                                    RageUIjh.GoUp(Options)

                                    Citizen.Wait(175)

                                    while Controls.Up.Enabled and IsDisabledControlPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) do
                                        RageUIjh.GoUp(Options)

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
                                    RageUIjh.GoDown(Options)

                                    Citizen.Wait(175)

                                    while Controls.Down.Enabled and IsDisabledControlPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) do
                                        RageUIjh.GoDown(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Down.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                RageUIjh.GoLeft(Controls)
                --- Default Left navigation
                RageUIjh.GoRight(Controls) --- Default Right navigation

                RageUIjh.GoSliderLeft(Controls)
                RageUIjh.GoSliderRight(Controls)

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
function RageUIjh.Navigation()
    if RageUIjh.CurrentMenu ~= nil then
        if RageUIjh.CurrentMenu() then
            if RageUIjh.CurrentMenu.EnableMouse then
                SetMouseCursorActiveThisFrame()
            end
            if RageUIjh.Options > RageUIjh.CurrentMenu.Pagination.Total then

                ---@type boolean
                local UpHovered = false

                ---@type boolean
                local DownHovered = false

                if not RageUIjh.CurrentMenu.SafeZoneSize then
                    RageUIjh.CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

                    if RageUIjh.CurrentMenu.Safezone then
                        RageUIjh.CurrentMenu.SafeZoneSize = RageUIjh.GetSafeZoneBounds()

                        SetScriptGfxAlign(76, 84)
                        SetScriptGfxAlignParams(0, 0, 0, 0)
                    end
                end

                UpHovered = RageUIjh.IsMouseInBounds(RageUIjh.CurrentMenu.X + RageUIjh.CurrentMenu.SafeZoneSize.X, RageUIjh.CurrentMenu.Y + RageUIjh.CurrentMenu.SafeZoneSize.Y + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height)
                DownHovered = RageUIjh.IsMouseInBounds(RageUIjh.CurrentMenu.X + RageUIjh.CurrentMenu.SafeZoneSize.X, RageUIjh.CurrentMenu.Y + RageUIjh.Settings.Items.Navigation.Rectangle.Height + RageUIjh.CurrentMenu.SafeZoneSize.Y + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height)

                if RageUIjh.CurrentMenu.EnableMouse then


                    if RageUIjh.CurrentMenu.Controls.Click.Active then
                        if UpHovered then
                            RageUIjh.GoUp(RageUIjh.Options)
                        elseif DownHovered then
                            RageUIjh.GoDown(RageUIjh.Options)
                        end
                    end

                    if UpHovered then
                        RenderRectangle(RageUIjh.CurrentMenu.X, RageUIjh.CurrentMenu.Y + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIjh.CurrentMenu.X, RageUIjh.CurrentMenu.Y + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end

                    if DownHovered then
                        RenderRectangle(RageUIjh.CurrentMenu.X, RageUIjh.CurrentMenu.Y + RageUIjh.Settings.Items.Navigation.Rectangle.Height + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIjh.CurrentMenu.X, RageUIjh.CurrentMenu.Y + RageUIjh.Settings.Items.Navigation.Rectangle.Height + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end
                else
                    RenderRectangle(RageUIjh.CurrentMenu.X, RageUIjh.CurrentMenu.Y + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    RenderRectangle(RageUIjh.CurrentMenu.X, RageUIjh.CurrentMenu.Y + RageUIjh.Settings.Items.Navigation.Rectangle.Height + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Width + RageUIjh.CurrentMenu.WidthOffset, RageUIjh.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                end
                RenderSprite(RageUIjh.Settings.Items.Navigation.Arrows.Dictionary, RageUIjh.Settings.Items.Navigation.Arrows.Texture, RageUIjh.CurrentMenu.X + RageUIjh.Settings.Items.Navigation.Arrows.X + (RageUIjh.CurrentMenu.WidthOffset / 2), RageUIjh.CurrentMenu.Y + RageUIjh.Settings.Items.Navigation.Arrows.Y + RageUIjh.CurrentMenu.SubtitleHeight + RageUIjh.ItemOffset, RageUIjh.Settings.Items.Navigation.Arrows.Width, RageUIjh.Settings.Items.Navigation.Arrows.Height)

                RageUIjh.ItemOffset = RageUIjh.ItemOffset + (RageUIjh.Settings.Items.Navigation.Rectangle.Height * 2)

            end
        end
    end
end

---GoBack
---@return nil
---@public
function RageUIjh.GoBack()
    if RageUIjh.CurrentMenu ~= nil then
        local Audio = RageUIjh.Settings.Audio
        RageUIjh.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
        if RageUIjh.CurrentMenu.Parent ~= nil then
            if RageUIjh.CurrentMenu.Parent() then
                RageUIjh.NextMenu = RageUIjh.CurrentMenu.Parent
            else
                RageUIjh.NextMenu = nil
                RageUIjh.Visible(RageUIjh.CurrentMenu, false)
            end
        else
            RageUIjh.NextMenu = nil
            RageUIjh.Visible(RageUIjh.CurrentMenu, false)
        end
    end
end
