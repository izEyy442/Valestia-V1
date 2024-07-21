---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 21/04/2019 21:20
---

---CreateMenu
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return RageUIv4Menus
---@public
function RageUIv4.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)

    ---@type table
    local Menu = {}
    Menu.Display = {};

    Menu.InstructionalButtons = {}

    Menu.Display.Header = true;
    Menu.Display.Glare = false;
    Menu.Display.Subtitle = true;
    Menu.Display.Background = true;
    Menu.Display.Navigation = true;
    Menu.Display.InstructionalButton = true;
    Menu.Display.PageCounter = true;
    Menu.Display.AcceptFilter = false;

    Menu.Title = Title or ""
    Menu.TitleFont = 6
    Menu.TitleScale = 1.1
    Menu.Subtitle = Subtitle or nil
    Menu.SubtitleHeight = -37
    Menu.Description = nil
    Menu.DescriptionHeight = RageUIv4.Settings.Items.Description.Background.Height
    Menu.X = X or 0
    Menu.Y = Y or 80
    Menu.Parent = nil
    Menu.WidthOffset = RageUIv4.UI.Style[RageUIv4.UI.Current].Width
    Menu.Open = false
    Menu.Controls = RageUIv4.Settings.Controls
    Menu.Index = 1
    Menu.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = R, G = G, B = B, A = A } }
    Menu.Rectangle = nil
    Menu.Pagination = { Minimum = 1, Maximum = 10, Total = 10 }
    Menu.Safezone = true
    Menu.SafeZoneSize = nil
    Menu.EnableMouse = false
    Menu.Options = 0
    Menu.Closable = true
    Menu.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    Menu.CursorStyle = 1

    if string.starts(Menu.Subtitle, "~") then
        Menu.PageCounterColour = string.lower(string.sub(Menu.Subtitle, 1, 3))
    else
        Menu.PageCounterColour = ""
    end

    if Menu.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(Menu.Subtitle, Menu.X + RageUIv4.Settings.Items.Subtitle.Text.X, Menu.Y + RageUIv4.Settings.Items.Subtitle.Text.Y, 0, RageUIv4.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUIv4.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)

        if SubtitleLineCount > 1 then
            Menu.SubtitleHeight = 18 * SubtitleLineCount
        else
            Menu.SubtitleHeight = 0
        end
    end

    Citizen.CreateThread(function()
        if not HasScaleformMovieLoaded(Menu.InstructionalScaleform) then
            Menu.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
            while not HasScaleformMovieLoaded(Menu.InstructionalScaleform) do
                Citizen.Wait(0)
            end
        end
    end)

    return setmetatable(Menu, RageUIv4.Menus)
end

---CreateSubMenu
---@param ParentMenu function
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return RageUIv4Menus
---@public
function RageUIv4.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    if ParentMenu ~= nil then
        if ParentMenu() then
            local Menu = RageUIv4.CreateMenu(Title or ParentMenu.Title, Subtitle or string.upper(ParentMenu.Subtitle), X or ParentMenu.X, Y or ParentMenu.Y)
            Menu.Parent = ParentMenu
            Menu.WidthOffset = ParentMenu.WidthOffset
            Menu.Safezone = ParentMenu.Safezone
            if ParentMenu.Sprite then
                Menu.Sprite = { Dictionary = TextureDictionary or ParentMenu.Sprite.Dictionary, Texture = TextureName or ParentMenu.Sprite.Texture, Color = { R = R or ParentMenu.Sprite.Color.R, G = G or ParentMenu.Sprite.Color.G, B = B or ParentMenu.Sprite.Color.B, A = A or ParentMenu.Sprite.Color.A } }
            else
                Menu.Rectangle = ParentMenu.Rectangle
            end
            return setmetatable(Menu, RageUIv4.Menus)
        else
            return nil
        end
    else
        return nil
    end
end

function RageUIv4.Menus:DisplayHeader(boolean)
    self.Display.Header = boolean;
    return self.Display.Header;
end

function RageUIv4.Menus:DisplayGlare(boolean)
    self.Display.Glare = boolean;
    return self.Display.Glare;
end

function RageUIv4.Menus:DisplaySubtitle(boolean)
    self.Display.Subtitle = boolean;
    return self.Display.Subtitle;
end

function RageUIv4.Menus:DisplayNavigation(boolean)
    self.Display.Navigation = boolean;
    return self.Display.Navigation;
end

function RageUIv4.Menus:DisplayInstructionalButton(boolean)
    self.Display.InstructionalButton = boolean;
    return self.Display.InstructionalButton;
end

function RageUIv4.Menus:DisplayPageCounter(boolean)
    self.Display.PageCounter= boolean;
    return self.Display.PageCounter;
end

function RageUIv4.Menus:AcceptFilter(boolean)
    self.Display.AcceptFilter = boolean;
    return self.Display.AcceptFilter;
end

---SetTitle
---@param Title string
---@return nil
---@public
function RageUIv4.Menus:SetTitle(Title)
    self.Title = Title
end

function RageUIv4.Menus:SetStyleSize(Value)
    local witdh
    if Value >= 0 and Value <= 100 then
        witdh = Value
    else
        witdh = 100
    end
    self.WidthOffset = witdh
end

---GetStyleSize
---@return any
---@public
function RageUIv4.Menus:GetStyleSize()
    if (self.WidthOffset == 100) then
        return "RageUIv4"
    elseif (self.WidthOffset == 0) then
        return "NativeUI";
    else
        return self.WidthOffset;
    end
end

---SetStyleSize
---@param Int string
---@return void
---@public
function RageUIv4.Menus:SetCursorStyle(Int)
    self.CursorStyle = Int or 1 or 0
    SetMouseCursorSprite(Int)
end

---ResetCursorStyle
---@return void
---@public
function RageUIv4.Menus:ResetCursorStyle()
    self.CursorStyle = 1
    SetMouseCursorSprite(1)
end

---UpdateCursorStyle
---@return void
---@public
function RageUIv4.Menus:UpdateCursorStyle()
    SetMouseCursorSprite(self.CursorStyle)
end

---RefreshIndex
---@return void
---@public
function RageUIv4.Menus:RefreshIndex()
    self.Index = 1
end

---SetSubtitle
---@param Subtitle string
---@return nil
---@public
function RageUIv4.Menus:SetSubtitle(Subtitle)

    self.Subtitle = string.upper(Subtitle) or string.upper(self.Subtitle)

    if string.starts(self.Subtitle, "~") then
        self.PageCounterColour = string.lower(string.sub(self.Subtitle, 1, 3))
    else
        self.PageCounterColour = ""
    end
    if self.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(self.Subtitle, self.X + RageUIv4.Settings.Items.Subtitle.Text.X, self.Y + RageUIv4.Settings.Items.Subtitle.Text.Y, 0, RageUIv4.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUIv4.Settings.Items.Subtitle.Background.Width + self.WidthOffset)

        if SubtitleLineCount > 1 then
            self.SubtitleHeight = 18 * SubtitleLineCount
        else
            self.SubtitleHeight = 0
        end

    else
        self.SubtitleHeight = -37
    end
end

---PageCounter
---@param Subtitle string
---@return nil
---@public
function RageUIv4.Menus:SetPageCounter(Subtitle)
    self.PageCounter = Subtitle
end

---EditSpriteColor
---@param Colors table
---@return nil
---@public
function RageUIv4.Menus:EditSpriteColor(R, G, B, A)
    if self.Sprite.Dictionary == "commonmenu" then
        self.Sprite.Color = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    end
end
---SetPosition
---@param X number
---@param Y number
---@return nil
---@public
function RageUIv4.Menus:SetPosition(X, Y)
    self.X = tonumber(X) or self.X
    self.Y = tonumber(Y) or self.Y
end

---SetTotalItemsPerPage
---@param Value number
---@return nil
---@public
function RageUIv4.Menus:SetTotalItemsPerPage(Value)
    self.Pagination.Total = tonumber(Value) or self.Pagination.Total
end

---SetRectangleBanner
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function RageUIv4.Menus:SetRectangleBanner(R, G, B, A)
    self.Rectangle = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    self.Sprite = nil
end

---SetSpriteBanner
---@param TextureDictionary string
---@param Texture string
---@return nil
---@public
function RageUIv4.Menus:SetSpriteBanner(TextureDictionary, Texture)
    self.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = Texture or "interaction_bgd" }
    self.Rectangle = nil
end

function RageUIv4.Menus:Closable(boolean)
    if type(boolean) == "boolean" then
        self.Closable = boolean
    else
        error("Type is not boolean")
    end
end

function RageUIv4.Menus:AddInstructionButton(button)
    if type(button) == "table" and #button == 2 then
        table.insert(self.InstructionalButtons, button)
        self.UpdateInstructionalButtons(true);
    end
end

function RageUIv4.Menus:RemoveInstructionButton(button)
    if type(button) == "table" then
        for i = 1, #self.InstructionalButtons do
            if button == self.InstructionalButtons[i] then
                table.remove(self.InstructionalButtons, i)
                self.UpdateInstructionalButtons(true);
                break
            end
        end
    else
        if tonumber(button) then
            if self.InstructionalButtons[tonumber(button)] then
                table.remove(self.InstructionalButtons, tonumber(button))
                self.UpdateInstructionalButtons(true);
            end
        end
    end
end

function RageUIv4.Menus:UpdateInstructionalButtons(Visible)

    if not Visible then
        return
    end

    BeginScaleformMovieMethod(self.InstructionalScaleform, "CLEAR_ALL")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.InstructionalScaleform, "TOGGLE_MOUSE_BUTTONS")
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.InstructionalScaleform, "CREATE_CONTAINER")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 176, 0))
    PushScaleformMovieMethodParameterString(GetLabelText("HUD_INPUT2"))
    EndScaleformMovieMethod()

    if self.Closable then
        BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(1)
        PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 177, 0))
        PushScaleformMovieMethodParameterString(GetLabelText("HUD_INPUT3"))
        EndScaleformMovieMethod()
    end

    local count = 2

    if (self.InstructionalButtons ~= nil) then
        for i = 1, #self.InstructionalButtons do
            if self.InstructionalButtons[i] then
                if #self.InstructionalButtons[i] == 2 then
                    BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
                    ScaleformMovieMethodAddParamInt(count)
                    PushScaleformMovieMethodParameterButtonName(self.InstructionalButtons[i][1])
                    PushScaleformMovieMethodParameterString(self.InstructionalButtons[i][2])
                    EndScaleformMovieMethod()
                    count = count + 1
                end
            end
        end
    end

    BeginScaleformMovieMethod(self.InstructionalScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    ScaleformMovieMethodAddParamInt(-1)
    EndScaleformMovieMethod()
end
