--[[
----
----Created Date: 2:10 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Math]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type Math
Math = Class.new(function(class)

    ---@class Math: BaseObject
    local self = class;

    function self:Round(value, numDecimalPlaces)
        if numDecimalPlaces then
            local power = 10^numDecimalPlaces
            return math.floor((value * power) + 0.5) / (power)
        else
            return math.floor(value + 0.5)
        end
    end
    
    function self:Trim(value)
        if value then
            return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
        else
            return nil
        end
    end

    ---@param percent number
    ---@param maxvalue number
    function self:Percent(percent, maxvalue)
        if tonumber(percent) and tonumber(maxvalue) then
            return (maxvalue * percent) / 100;
        end
        return false;
    end

    return self;
end);