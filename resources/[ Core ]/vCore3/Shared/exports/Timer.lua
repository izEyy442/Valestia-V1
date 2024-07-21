--
--Created Date: 20:58 11/12/2022
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

---@type Timer[]
local timers = {};

---@param name string
---@param duration number
exports("CreateTimer", function(name, duration)

    local timer = Timer(duration);
    if (not timers[name]) then
        timers[name] = timer;
    end

end);

---@param name string
exports("TimerExist", function(name)

    return timers[name] ~= nil;

end);

exports("RemoveTimer", function(name)

    if (timers[name]) then
        timers[name] = nil;
    end

end);

---@param name string
---@return boolean
exports("HasFinished", function(name)

    if (timers[name]) then
        return timers[name]:HasPassed();
    end

    return true;

end);

---@param name string
exports("Start", function(name)

    if (timers[name]) then
        timers[name]:Start();
    end

end);

---@param name string
exports("Stop", function(name)

    if (timers[name]) then
        timers[name]:Stop();
    end

end);

---@param name string
---@return string
exports("ShowRemaining", function(name)

    if (timers[name]) then
        return timers[name]:ShowRemaining();
    end

end);