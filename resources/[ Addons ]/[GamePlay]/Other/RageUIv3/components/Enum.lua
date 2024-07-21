

---@class Enum
local enums = {
    __index = function(table, key)
        if rawget(table.enums, key) then
            return key
        end
    end
}

---Enum
---@param t table
---@return Enum
function RageUIv3.Enum(t)
    local e = { enums = t }
    return setmetatable(e, enums)
end
