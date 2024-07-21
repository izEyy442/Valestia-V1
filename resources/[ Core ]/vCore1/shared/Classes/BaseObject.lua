---@class BaseObject
BaseObject = {}

setmetatable(BaseObject, {
    __call = function(self, ...)
        return self:new(...);
    end
});

---@private
function BaseObject:GetCreators()
    local creators = [[
        -----------------------------------------------------
        |    Original code has been made by MegaThorx       |
        |    and rewritten by vCore3 to make a code like   |
        |    JavaScript                                     |
        -----------------------------------------------------
    ]]
    print(creators);
    return creators;
end

---@private
function BaseObject:new(...)
    return Class.instance(self, ...);
end

function BaseObject:super(...)
    local metatable = getmetatable(self);
    local super = metatable.__super;
    if (super) then
        if (rawget(super, "Constructor")) then
            rawget(super, "Constructor")(self, ...);
        end
    end
end

---@param methodName string
---@param ... any
---@return function | nil
function BaseObject:CallParentMethod(methodName, ...)
    local metatable = getmetatable(self);
    local metasuper = metatable.__super;
    local method = rawget(metasuper, methodName);
    if (method) then
        return method(self, ...);
    end
    return nil
end

function BaseObject:Delete(...)
	return Class.Delete(self, ...);
end

---@param key string
---@param value any
function BaseObject:SetValue(key, value)
    if (string.sub(key, 1, 2) ~= "__") then
        self[key] = value;
    end
end

---@param key string
---@return any
function BaseObject:GetValue(key)
    if (string.sub(key, 1, 2) ~= "__") then
        return self[key];
    end
end