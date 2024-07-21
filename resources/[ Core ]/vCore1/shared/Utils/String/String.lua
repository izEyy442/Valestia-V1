---@type String
String = Class.new(function(class)

    ---@class String: BaseObject
    local self = class;
    
    ---@param str string string to split
    ---@param sep string string separator
    function self:Split(str, sep)
        if sep == nil then
            sep = "%s"
        end

        local strTable = {};
        for newStr in string.gmatch(str, "([^"..sep.."]+)") do
            table.insert(strTable, newStr)
        end

        return strTable;
    end

    ---@param str string
    ---@return boolean
    function self:IsNumber(str)
        return str:match("^%-?%d+$");
    end

    --todo repair "," and "-" in numbers
    ---@param x string
    ---@param y string
    ---@param z string
    ---@return vector3 | boolean
    function self:ToCoords(x, y, z)
        if (string.find(x, ",")) then
            x = string.gsub(x, ",", "");
        end
        if (string.find(y, ",")) then
            y = string.gsub(y, ",", "");
        end
        if (string.find(z, ",")) then
            z = string.gsub(z, ",", "");
        end
        --if (Shared:InputIsValid(x, "number") and Shared:InputIsValid(y, "number") and Shared:InputIsValid(z, "number")) then
            return vector3(tonumber(x), tonumber(y), tonumber(z));
        --end
       --return false;
    end

    ---@return string
    function self:DownArrow()
        return "↓";
    end

    return self;
end);
