---@type table
RageUIv3.LastControl = false

---IsMouseInBounds
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@return number
---@public
function RageUIv3.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(0, 239) * 1920) / 1920, math.round(GetControlNormal(0, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

---GetSafeZoneBounds
---@return table
---@public
function RageUIv3.GetSafeZoneBounds()
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
function RageUIv3.GoUp(Options)
    if RageUIv3.CurrentMenu ~= nil then
        Options = RageUIv3.CurrentMenu.Options
        if RageUIv3.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIv3.CurrentMenu.Pagination.Total then
                    if RageUIv3.CurrentMenu.Index <= RageUIv3.CurrentMenu.Pagination.Minimum then
                        if RageUIv3.CurrentMenu.Index == 1 then
                            RageUIv3.CurrentMenu.Pagination.Minimum = Options - (RageUIv3.CurrentMenu.Pagination.Total - 1)
                            RageUIv3.CurrentMenu.Pagination.Maximum = Options
                            RageUIv3.CurrentMenu.Index = Options
                        else
                            RageUIv3.CurrentMenu.Pagination.Minimum = (RageUIv3.CurrentMenu.Pagination.Minimum - 1)
                            RageUIv3.CurrentMenu.Pagination.Maximum = (RageUIv3.CurrentMenu.Pagination.Maximum - 1)
                            RageUIv3.CurrentMenu.Index = RageUIv3.CurrentMenu.Index - 1
                        end
                    else
                        RageUIv3.CurrentMenu.Index = RageUIv3.CurrentMenu.Index - 1
                    end
                else
                    if RageUIv3.CurrentMenu.Index == 1 then
                        RageUIv3.CurrentMenu.Pagination.Minimum = Options - (RageUIv3.CurrentMenu.Pagination.Total - 1)
                        RageUIv3.CurrentMenu.Pagination.Maximum = Options
                        RageUIv3.CurrentMenu.Index = Options
                    else
                        RageUIv3.CurrentMenu.Index = RageUIv3.CurrentMenu.Index - 1
                    end
                end

                local Audio = RageUIv3.Settings.Audio
                RageUIv3.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIv3.LastControl = true
            else
                local Audio = RageUIv3.Settings.Audio
                RageUIv3.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

---GoDown
---@param Options number
---@return nil
---@public
function RageUIv3.GoDown(Options)
    if RageUIv3.CurrentMenu ~= nil then
        Options = RageUIv3.CurrentMenu.Options
        if RageUIv3.CurrentMenu() then
            if (Options ~= 0) then
                if Options > RageUIv3.CurrentMenu.Pagination.Total then
                    if RageUIv3.CurrentMenu.Index >= RageUIv3.CurrentMenu.Pagination.Maximum then
                        if RageUIv3.CurrentMenu.Index == Options then
                            RageUIv3.CurrentMenu.Pagination.Minimum = 1
                            RageUIv3.CurrentMenu.Pagination.Maximum = RageUIv3.CurrentMenu.Pagination.Total
                            RageUIv3.CurrentMenu.Index = 1
                        else
                            RageUIv3.CurrentMenu.Pagination.Maximum = (RageUIv3.CurrentMenu.Pagination.Maximum + 1)
                            RageUIv3.CurrentMenu.Pagination.Minimum = RageUIv3.CurrentMenu.Pagination.Maximum - (RageUIv3.CurrentMenu.Pagination.Total - 1)
                            RageUIv3.CurrentMenu.Index = RageUIv3.CurrentMenu.Index + 1
                        end
                    else
                        RageUIv3.CurrentMenu.Index = RageUIv3.CurrentMenu.Index + 1
                    end
                else
                    if RageUIv3.CurrentMenu.Index == Options then
                        RageUIv3.CurrentMenu.Pagination.Minimum = 1
                        RageUIv3.CurrentMenu.Pagination.Maximum = RageUIv3.CurrentMenu.Pagination.Total
                        RageUIv3.CurrentMenu.Index = 1
                    else
                        RageUIv3.CurrentMenu.Index = RageUIv3.CurrentMenu.Index + 1
                    end
                end
                local Audio = RageUIv3.Settings.Audio
                RageUIv3.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                RageUIv3.LastControl = false
            else
                local Audio = RageUIv3.Settings.Audio
                RageUIv3.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

function RageUIv3.GoLeft(Controls)
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

function RageUIv3.GoRight(Controls)
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

function RageUIv3.GoSliderLeft(Controls)
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

function RageUIv3.GoSliderRight(Controls)
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
function RageUIv3.Controls()
    if RageUIv3.CurrentMenu ~= nil then
        if RageUIv3.CurrentMenu() then
            if RageUIv3.CurrentMenu.Open then

                local Controls = RageUIv3.CurrentMenu.Controls;
                ---@type number
                local Options = RageUIv3.CurrentMenu.Options
                RageUIv3.Options = RageUIv3.CurrentMenu.Options
                if RageUIv3.CurrentMenu.EnableMouse then
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
                                    RageUIv3.GoUp(Options)

                                    Citizen.Wait(175)

                                    while Controls.Up.Enabled and IsDisabledControlPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) do
                                        RageUIv3.GoUp(Options)

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
                                    RageUIv3.GoDown(Options)

                                    Citizen.Wait(175)

                                    while Controls.Down.Enabled and IsDisabledControlPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) do
                                        RageUIv3.GoDown(Options)

                                        Citizen.Wait(50)
                                    end

                                    Controls.Down.Pressed = false
                                end)

                                break
                            end
                        end
                    end
                end

                RageUIv3.GoLeft(Controls)
                --- Default Left navigation
                RageUIv3.GoRight(Controls) --- Default Right navigation

                RageUIv3.GoSliderLeft(Controls)
                RageUIv3.GoSliderRight(Controls)

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
function RageUIv3.Navigation()
    if RageUIv3.CurrentMenu ~= nil then
        if RageUIv3.CurrentMenu() then
            if RageUIv3.CurrentMenu.EnableMouse then
                ShowCursorThisFrame()
            end
            if RageUIv3.Options > RageUIv3.CurrentMenu.Pagination.Total then

                ---@type boolean
                local UpHovered = false

                ---@type boolean
                local DownHovered = false

                if not RageUIv3.CurrentMenu.SafeZoneSize then
                    RageUIv3.CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

                    if RageUIv3.CurrentMenu.Safezone then
                        RageUIv3.CurrentMenu.SafeZoneSize = RageUIv3.GetSafeZoneBounds()

                        SetScriptGfxAlign(76, 84)
                        SetScriptGfxAlignParams(0, 0, 0, 0)
                    end
                end

                UpHovered = RageUIv3.IsMouseInBounds(RageUIv3.CurrentMenu.X + RageUIv3.CurrentMenu.SafeZoneSize.X, RageUIv3.CurrentMenu.Y + RageUIv3.CurrentMenu.SafeZoneSize.Y + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height)
                DownHovered = RageUIv3.IsMouseInBounds(RageUIv3.CurrentMenu.X + RageUIv3.CurrentMenu.SafeZoneSize.X, RageUIv3.CurrentMenu.Y + RageUIv3.Settings.Items.Navigation.Rectangle.Height + RageUIv3.CurrentMenu.SafeZoneSize.Y + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height)

                if RageUIv3.CurrentMenu.EnableMouse then


                    if RageUIv3.CurrentMenu.Controls.Click.Active then
                        if UpHovered then
                            RageUIv3.GoUp(RageUIv3.Options)
                        elseif DownHovered then
                            RageUIv3.GoDown(RageUIv3.Options)
                        end
                    end

                    if UpHovered then
                        RenderRectangle(RageUIv3.CurrentMenu.X, RageUIv3.CurrentMenu.Y + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIv3.CurrentMenu.X, RageUIv3.CurrentMenu.Y + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end

                    if DownHovered then
                        RenderRectangle(RageUIv3.CurrentMenu.X, RageUIv3.CurrentMenu.Y + RageUIv3.Settings.Items.Navigation.Rectangle.Height + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(RageUIv3.CurrentMenu.X, RageUIv3.CurrentMenu.Y + RageUIv3.Settings.Items.Navigation.Rectangle.Height + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end
                else
                    RenderRectangle(RageUIv3.CurrentMenu.X, RageUIv3.CurrentMenu.Y + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    RenderRectangle(RageUIv3.CurrentMenu.X, RageUIv3.CurrentMenu.Y + RageUIv3.Settings.Items.Navigation.Rectangle.Height + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Width + RageUIv3.CurrentMenu.WidthOffset, RageUIv3.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                end
                RenderSprite(RageUIv3.Settings.Items.Navigation.Arrows.Dictionary, RageUIv3.Settings.Items.Navigation.Arrows.Texture, RageUIv3.CurrentMenu.X + RageUIv3.Settings.Items.Navigation.Arrows.X + (RageUIv3.CurrentMenu.WidthOffset / 2), RageUIv3.CurrentMenu.Y + RageUIv3.Settings.Items.Navigation.Arrows.Y + RageUIv3.CurrentMenu.SubtitleHeight + RageUIv3.ItemOffset, RageUIv3.Settings.Items.Navigation.Arrows.Width, RageUIv3.Settings.Items.Navigation.Arrows.Height)

                RageUIv3.ItemOffset = RageUIv3.ItemOffset + (RageUIv3.Settings.Items.Navigation.Rectangle.Height * 2)

            end
        end
    end
end

---GoBack
---@return nil
---@public
function RageUIv3.GoBack()
    if RageUIv3.CurrentMenu ~= nil then
        local Audio = RageUIv3.Settings.Audio
        RageUIv3.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
        if RageUIv3.CurrentMenu.Parent ~= nil then
            if RageUIv3.CurrentMenu.Parent() then
                RageUIv3.NextMenu = RageUIv3.CurrentMenu.Parent
            else
                RageUIv3.NextMenu = nil
                RageUIv3.Visible(RageUIv3.CurrentMenu, false)
            end
        else
            RageUIv3.NextMenu = nil
            RageUIv3.Visible(RageUIv3.CurrentMenu, false)
        end
    end
end
