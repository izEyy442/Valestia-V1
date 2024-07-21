-- Author : Morow
-- Github : https://github.com/Morow73

Scaleform = {}
Scaleform.__index = Scaleform

setmetatable(Scaleform, {
    __call = function(cls)
        self = Scaleform.new()
        return self
    end
})

function Scaleform.new()
    local self = setmetatable({}, Scaleform)

    if HasScaleformMovieLoaded("MP_BIG_MESSAGE_FREEMODE") then
        return
    end

    self.scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

    while not HasScaleformMovieLoaded(self.scaleform) do
        Wait(1)
    end

    return self
end

function Scaleform:display()
    DrawScaleformMovieFullscreen(self.scaleform, 255, 255, 255, 255, 0)
end

function Scaleform:destruct()
    SetScaleformMovieAsNoLongerNeeded(self.scaleform)
    self = nil
end

function Scaleform:addContent(t, str)
    BeginScaleformMovieMethod(self.scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
    PushScaleformMovieMethodParameterString(t)
    PushScaleformMovieMethodParameterString(str)
    EndScaleformMovieMethod()

    SetTimeout(2500, function()
        ScaleformActive = false
    end)
end