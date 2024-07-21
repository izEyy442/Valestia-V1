--[[
----
----Created Date: 4:42 Sunday November 27th 2022
----Author: vCore3
----Made with ❤
----
----File: [Storage]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

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