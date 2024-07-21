TimerBar = {}

-- consts
TimerBar.gfxAlignWidth = 0.952
TimerBar.gfxAlignHeight = 0.949

TimerBar.initialX = 0.795
TimerBar.initialY = 0.923
TimerBar.initialBusySpinnerY = 0.887

TimerBar.bgBaseX = 0.874
TimerBar.progressBaseX = 0.913
TimerBar.checkpointBaseX = 0.9445

TimerBar.bgOffset = 0.008
TimerBar.bgThinOffset = 0.012
TimerBar.textOffset = -0.006
TimerBar.playerTitleOffset = -0.005
TimerBar.barOffset = 0.012
TimerBar.checkpointOffsetX = 0.0094
TimerBar.checkpointOffsetY = 0.012

TimerBar.timerBarWidth = 0.165
TimerBar.timerBarHeight = 0.035
TimerBar.timerBarThinHeight = 0.028
TimerBar.timerBarMargin = 0.0399
TimerBar.timerBarThinMargin = 0.0319

TimerBar.progressWidth = 0.069
TimerBar.progressHeight = 0.011

TimerBar.checkpointWidth = 0.012
TimerBar.checkpointHeight = 0.023

TimerBar.titleScale = 0.288
TimerBar.titleWrap = 0.867
TimerBar.textScale = 0.494
TimerBar.textWrap = 0.95
TimerBar.playertitleScale = 0.447
TimerBar.timerbarUnique = 0

-- list of all created timerbars
TimerBar.pool = {}

-- timerbar types
TimerBar.Progress = 0
TimerBar.Player = 1
TimerBar.Text = 2
TimerBar.Checkpoint = 3

local function DrawTextLabel(label, position, options)
    options.font = Config.UIFontID
    SetTextFont(options.font)
    SetTextScale(0.0, options.scale)
    SetTextColour(options.color[1], options.color[2], options.color[3], options.color[4])
    SetTextJustification(options.justification);

    if options.wrap then
        SetTextWrap(0.0, options.wrap);
    end

    if options.shadow then
        SetTextDropShadow()
    end

    if options.outline then
        SetTextOutline()
    end

    BeginTextCommandDisplayText(label);
    EndTextCommandDisplayText(position[1], position[2]);
end

local function CreateTimerBarBase(title)
    local o = {}

    -- assign unique ID
    TimerBar.timerbarUnique = TimerBar.timerbarUnique + 1

    o._id = TimerBar.timerbarUnique

    -- set initial styling props
    o._thin = false
    o._highlightColor = nil

    -- assign TextEntry for title
    o._titleGxtName = "TMRB_TITLE_" .. o._id
    o._title = title
    AddTextEntry(o._titleGxtName, title)

    -- set initial styling for title
    o.titleDrawParams = {
        font = 0,
        color = {240, 240, 240, 255},
        scale = TimerBar.titleScale,
        justification = 2,
        wrap = TimerBar.titleWrap,
        shadow = false,
        outline = false
    }

    -- set new title
    o.setTitle = function(title)
        o._title = title
        AddTextEntry(o._titleGxtName, title)
    end

    -- set new title color
    o.setTitleColor = function(titleColor)
        o.titleDrawParams.color = titleColor
    end

    -- set new highlight color
    o.setHighlightColor = function(highlightColor)
        o._highlightColor = highlightColor
    end

    -- draw background
    o.drawBackground = function(y)
        y = y + (o._thin and TimerBar.bgThinOffset or TimerBar.bgThinOffset)

        -- draw highlight side of gradient, if it's set
        if o._highlightColor then
            DrawSprite("timerbars", "all_white_bg", TimerBar.bgBaseX, y, TimerBar.timerBarWidth,
                (o._thin and TimerBar.timerBarThinHeight or TimerBar.timerBarHeight), 0.0, o._highlightColor[1],
                o._highlightColor[2], o._highlightColor[3], o._highlightColor[4])
        end
        -- draw black side of gradient background
        DrawSprite("timerbars", "all_black_bg", TimerBar.bgBaseX, y, TimerBar.timerBarWidth,
            (o._thin and TimerBar.timerBarThinHeight or TimerBar.timerBarHeight), 0.0, 255, 255, 255, 140)
    end

    -- draw title
    o.drawTitle = function(y)
        DrawTextLabel(o._titleGxtName, {TimerBar.initialX, y}, o.titleDrawParams)
    end

    -- draw
    o.draw = function(y)
        -- draws background & title
        o.drawBackground(y)
        o.drawTitle(y)
    end

    -- on destroy
    o.onDestroy = function()
        AddTextEntry(o._titleGxtName, "")
    end
    return o
end

local function CreateBarTimerBar(title, progress)
    local o = {}

    -- create base class
    o.base = CreateTimerBarBase(title)

    -- progress background and fill props
    o._bgColor = {155, 155, 155, 255};
    o._fgColor = {240, 240, 240, 255};
    o._fgWidth = 0.0;
    o._fgX = 0.0;

    -- set new progress
    o.setProgress = function(v)
        o._progress = Clamp(v, 0.0, 1.0)
        o._fgWidth = TimerBar.progressWidth * o._progress
        o._fgX = (TimerBar.progressBaseX - TimerBar.progressWidth * 0.5) + (o._fgWidth * 0.5)
    end

    o.draw = function(y)
        -- draw TimerBarBase
        o.base.draw(y)

        -- draw progress
        y = y + TimerBar.barOffset
        -- progress background
        DrawRect(TimerBar.progressBaseX, y, TimerBar.progressWidth, TimerBar.progressHeight, o._bgColor[1],
            o._bgColor[2], o._bgColor[3], o._bgColor[4])
        -- progress fill
        DrawRect(o._fgX, y, o._fgWidth, TimerBar.progressHeight, o._fgColor[1], o._fgColor[2], o._fgColor[3],
            o._fgColor[4])
    end

    o.setBackgroundColor = function(color)
        o._bgColor = color
    end

    o.setForegroundColor = function(color)
        o._fgColor = color
    end

    -- set initial progress 
    o._progress = progress;

    -- show initial progress
    o.setProgress(progress)

    o.setHighlightColor = o.base.setHighlightColor
    o.setTitleColor = o.base.setTitleColor
    o._thin = o.base._thin
    o._id = o.base._id
    -- on destroy
    o.onDestroy = function()
        o.base.onDestroy()
    end

    return o
end

local function CreateTextTimerBar(title, text)
    local o = {}

    -- create base class
    o.base = CreateTimerBarBase(title)

    -- assign TextEntry for text
    o._textGxtName = "TMRB_TEXT_" .. o.base._id
    o._text = text
    AddTextEntry(o._textGxtName, text)

    -- assign defailt text params
    o.textDrawParams = {
        font = 0,
        color = {238, 232, 170, 255},
        scale = TimerBar.textScale,
        justification = 2,
        wrap = TimerBar.textWrap
    };

    o.setText = function(newText)
        AddTextEntry(o._textGxtName, newText)
    end

    o.setTextColor = function(color)
        o.textDrawParams.color = color
    end

    -- draw
    o.draw = function(y)
        -- draw TimerBarBase
        o.base.draw(y)
        -- draw text
        y = y + TimerBar.textOffset;
        DrawTextLabel(o._textGxtName, {TimerBar.initialX, y}, o.textDrawParams)
    end

    o.setHighlightColor = o.base.setHighlightColor
    o.setTitleColor = o.base.setTitleColor
    o._thin = o.base._thin
    o._id = o.base._id
    o.setTitle = o.base.setTitle

    -- on destroy
    o.onDestroy = function()
        o.base.onDestroy()
        AddTextEntry(o._textGxtName, "")
    end

    return o
end

local function CreatePlayerTimerBar(title, text)
    local o = {}

    -- create base class
    o.base = CreateTextTimerBar(title, text)

    -- override TextTimerBars title styling 
    local titleDrawParams = o.base.base.titleDrawParams
    titleDrawParams.font = 4
    titleDrawParams.color = {238, 232, 170, 255}
    titleDrawParams.scale = TimerBar.playertitleScale
    titleDrawParams.justification = 2
    titleDrawParams.wrap = TimerBar.titleWrap
    titleDrawParams.shadow = true

    o.draw = function(y)
        -- draw TimerBarBase background
        o.base.base.drawBackground(y)
        -- draw title
        DrawTextLabel(o.base.base._titleGxtName, {TimerBar.initialX, y + TimerBar.playerTitleOffset}, titleDrawParams)
        -- draw text
        DrawTextLabel(o.base._textGxtName, {TimerBar.initialX, y + TimerBar.textOffset}, o.base.textDrawParams)
    end

    o.setTextColor = o.base.setTextColor
    o.setHighlightColor = o.base.base.setHighlightColor
    o.setTitleColor = o.base.base.setTitleColor
    o._thin = o.base.base._thin
    o._id = o.base.base._id

    -- on destroy
    o.onDestroy = function()
        o.base.onDestroy()
    end

    return o
end

local function CreateCheckpointTimerBar(title, numCheckpoints)
    local o = {}

    -- create base class
    o.base = CreateTimerBarBase(title)
    o.base._thin = false

    -- checkpoints
    o._checkpointStates = {}
    o._numCheckpoints = numCheckpoints

    -- colors
    o._color = {113, 204, 111, 255}
    o._inProgressColor = {255, 255, 255, 51}
    o._failedColor = {0, 0, 0, 255}

    -- initialize list
    for i = 1, numCheckpoints, 1 do
        o._checkpointStates[i] = 0
    end

    -- set value on all checkpoints
    o.toggleAll = function(toggle)
        for i = 1, numCheckpoints, 1 do
            o._checkpointStates[i] = toggle
        end
    end

    -- change num checkpoints
    o.changeNumCheckpoints = function(newCount)
        o._numCheckpoints = newCount
        -- initialize list
        for i = 1, numCheckpoints, 1 do
            o._checkpointStates[i] = 0
        end
    end

    -- set all checkpoints checked
    o.checkAll = function()
        o.toggleAll(1)
    end

    -- set all checkpoints unchecked
    o.uncheckAll = function()
        o.toggleAll(0)
    end

    -- set checkpoint state
    o.setCheckpointState = function(index, state)
        if o._checkpointStates[index] == nil then
            return
        end
        o._checkpointStates[index] = state
    end

    -- draw
    o.draw = function(y)
        o.base.draw(y)
        y = y + TimerBar.checkpointOffsetY

        local cpX = TimerBar.checkpointBaseX

        for i = 1, o._numCheckpoints, 1 do
            local state = o._checkpointStates[i]
            local drawColor = (state == 0 and o._inProgressColor or (state == -1 and o._failedColor or o._color))
            DrawSprite("timerbars", "circle_checkpoints", cpX, y, TimerBar.checkpointWidth, TimerBar.checkpointHeight,
                0.0, drawColor[1], drawColor[2], drawColor[3], drawColor[4])
            cpX = cpX - TimerBar.checkpointOffsetX;
        end
    end

    o.setHighlightColor = o.base.setHighlightColor
    o.setTitleColor = o.base.setTitleColor
    o._thin = o.base._thin
    o._id = o.base._id
    o.setTextColor = o.base.setTextColor

    -- on destroy
    o.onDestroy = function()
        o.base.onDestroy()
    end

    return o
end

TimerBar.Create = function(type, title, value)
    local o = nil
    if type == 0 then
        o = CreateBarTimerBar(title, value)
    elseif type == 1 then
        o = CreatePlayerTimerBar(title, value)
    elseif type == 2 then
        o = CreateTextTimerBar(title, value)
    elseif type == 3 then
        o = CreateCheckpointTimerBar(title, value)
    end
    table.insert(TimerBar.pool, o)
    o.visible = true
    return o
end

TimerBar.Destroy = function(bar)
    for index, value in pairs(TimerBar.pool) do
        if value == bar then
            bar.onDestroy()
            table.remove(TimerBar.pool, index)
        end
    end
end

TimerBar.DestroyAll = function()
    for index, value in pairs(TimerBar.pool) do
        value.onDestroy()
    end
    TimerBar.pool = {}
end

TimerBar.BeginDraw = function()
    HideHudComponentThisFrame(6); -- HUD_VEHICLE_NAME
    HideHudComponentThisFrame(7); -- HUD_AREA_NAME
    HideHudComponentThisFrame(8); -- HUD_VEHICLE_CLASS
    HideHudComponentThisFrame(9); -- HUD_STREET_NAME

    SetScriptGfxAlign(82, 66)
    SetScriptGfxAlignParams(0.0, 0.0, TimerBar.gfxAlignWidth, TimerBar.gfxAlignHeight)
end

TimerBar.EndDraw = function()
    ResetScriptGfxAlign()
end

TimerBar.DrawAll = function()
    if #(TimerBar.pool) == 0 then
        return
    end
    if not ENABLE_HUD then
        return
    end
    TimerBar.BeginDraw()
    local busySpinner = BusyspinnerIsOn()
    local drawY = (busySpinner and TimerBar.initialBusySpinnerY or TimerBar.initialY)
    if INSTRUCTIONAL_BUTTONS_ACTIVE then
        drawY = 0.877
    end
    for _, v in pairs(TimerBar.pool) do
        if v.visible then
            v.draw(drawY)
            drawY = drawY - (v._thin and TimerBar.timerBarThinMargin or TimerBar.timerBarMargin);
        end
    end
    TimerBar.EndDraw()
end
