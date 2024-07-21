--[[
----
----Created Date: 8:27 Friday October 14th 2022
----Author: vCore3
----Made with ❤
----
----File: [KeysManager]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type KeyManager
KeyManager = Class.new(function(class)

    ---@class KeyManager: BaseObject
    local self = class;

    function self:Constructor()
        ---@type Key[][]
        self.keys = {
            vehicle = {};
        };

        Shared:Initialized("KeyManager");
    end

    ---@return Key[][]
    function self:GetKeys()
        return self.keys;
    end

    ---@param keysType string
    ---@return Key[]
    function self:GetKeysByType(keysType)
        return self.keys[keysType];
    end

    ---@param keyType string
    ---@param keyId string
    ---@return Key
    function self:GetKey(keyType, keyId)
        if (self.keys[keyType]) then
            return self.keys[keyType][keyId];
        end
    end

    ---@param owner xPlayer
    ---@param keyClass Key
    ---@param keyId string
    ---@param notify boolean
    function self:AddKey(owner, keyClass, keyId, keyType, notify)
        if (not self.keys[keyType][keyId]) then
            self.keys[keyType][keyId] = keyClass(owner.getIdentifier(), keyId);
            Shared.Log:Debug(Shared.Lang:Translate("keys_vehicle_added", keyId, owner.getName()));
            if (notify) then
                owner.showNotification(Shared.Lang:Translate("keys_vehicle_give", keyId));
            end
        end
    end

    ---@param keyType string
    ---@param keyId string
    ---@param notify boolean
    ---@return boolean
    function self:RemoveKey(keyType, keyId, notify)
        if (self.keys[keyType][keyId]) then
            local xPlayer = ESX.GetPlayerFromIdentifier(self.keys[keyType][keyId]:GetOwner())
            self.keys[keyType][keyId] = nil;
            Shared.Log:Debug(Shared.Lang:Translate("keys_vehicle_removed", keyId, xPlayer.getName()))
            if (notify) then
                xPlayer.showNotification(Shared.Lang:Translate("keys_vehicle_remove", keyId));
            end
            return true;
        end
        return false;
    end

    return self;
end);