--
--Created Date: 15:10 24/10/2022
--Author: vCore3
--Made with ❤
--
--File: [Timer]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@type Timer
Timer = Class.new(function(class)

    ---@class Timer: BaseObject
    local self = class;

    ---@param time number seconds
    function self:Constructor(time)
        self.toWait = (time * 1000);
    end

    function self:Start()
        self.time = GetGameTimer();
    end

    function self:Stop()
        self.time = nil;
    end

    ---@return boolean
    function self:HasPassed()
        if (self.time) then
            return (GetGameTimer() - self.time) >= self.toWait;
        end
        return true;
    end

    ---Reset time to actual time
    function self:Reset()
        self.time = GetGameTimer();
    end

    ---@return string
    function self:ShowRemaining()
        if (self.time) then
            local time = self.toWait - (GetGameTimer() - self.time);
            local minutes = math.floor(time / 60000);
            local seconds = math.floor((time - minutes * 60000) / 1000);
            return string.format("%02d:%02d", minutes, seconds);
        end
    end

    return self;
end);