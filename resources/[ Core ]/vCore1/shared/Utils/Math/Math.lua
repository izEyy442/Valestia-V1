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