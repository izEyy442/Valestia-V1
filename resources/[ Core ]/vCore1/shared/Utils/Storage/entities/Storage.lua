---@type Storage
Storage = Class.new(function(class) 

    ---@class Storage: BaseObject
    local self = class;

    ---@param name string
    ---@param data table | nil
    function self:Constructor(name, data)
        self.name = name;
        self.data = data or {};
    end

    ---@return table
    function self:GetAll()
        return self.data;
    end

    ---@param key string
    ---@param value any
    ---@return any
    function self:Set(key, value)
        self.data[key] = value;
        return self.data[key];
    end

    ---@param key string
    ---@return any
    function self:Get(key)
        return self.data[key];
    end

    ---@param key string
    function self:Remove(key)
        self.data[key] = nil;
    end

    return self;
end);