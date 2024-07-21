--[[
----
----Created Date: 1:08 Sunday October 16th 2022
----Author: vCore3
----Made with ❤
----
----File: [Discord]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type Discord
Discord = Class.new(function(class)

    ---@class Discord: BaseObject
    local self = class;

    function self:Constructor(scriptName)
        
        self.webhooks = {};

        -- Society

        self:AddWebhook(
            "ChestTake",
            ("%s | Society"):format(scriptName or "vCore3 Script"),
            Webhooks["Society"]["ChestTake"] or ""
        );

        self:AddWebhook(
            "ChestPut",
            ("%s | Society"):format(scriptName or "vCore3 Script"),
            Webhooks["Society"]["ChestPut"] or ""
        );

        self:AddWebhook(
            "MoneyTake",
            ("%s | Society"):format(scriptName or "vCore3 Script"),
            Webhooks["Society"]["MoneyTake"] or ""
        );

        self:AddWebhook(
            "MoneyPut",
            ("%s | Society"):format(scriptName or "vCore3 Script"),
            Webhooks["Society"]["MoneyPut"] or ""
        );

        -- Admin

        self:AddWebhook(
                "Admin:PlayerConnecting",
                "Admin | Player Connecting",
                Webhooks["Admin"]["PlayerConnecting"] or ""
        );

        self:AddWebhook(
                "Admin:PlayerDropped",
                "Admin | Player Dropped",
                Webhooks["Admin"]["PlayerConnecting"] or ""
        );

        self:AddWebhook(
                "Admin:StaffMode",
                "Admin | Staff Mode",
                Webhooks["Admin"]["StaffMode"] or ""
        );

        self:AddWebhook(
                "Admin:Report",
                "Admin | Report",
                Webhooks["Admin"]["Report"] or ""
        );

        self:AddWebhook(
                "Admin:SetGroup",
                "Admin | Set Group",
                Webhooks["Admin"]["SetGroup"] or ""
        );

        self:AddWebhook(
                "Admin:Bring",
                "Admin | Bring",
                Webhooks["Admin"]["Teleport"] or ""
        );

        self:AddWebhook(
                "Admin:BringBack",
                "Admin | BringBack",
                Webhooks["Admin"]["Teleport"] or ""
        );

        self:AddWebhook(
                "Admin:Goto",
                "Admin | Goto",
                Webhooks["Admin"]["Teleport"] or ""
        );

        self:AddWebhook(
                "Admin:SendMessage",
                "Admin | Send Message",
                Webhooks["Admin"]["SendMessage"] or ""
        );

        self:AddWebhook(
                "Admin:SetPed",
                "Admin | Set Ped",
                Webhooks["Admin"]["SetPed"] or ""
        );

        self:AddWebhook(
                "Admin:GiveItem",
                "Admin | Give Item",
                Webhooks["Admin"]["GiveItem"] or ""
        );

        self:AddWebhook(
                "Admin:RemoveItem",
                "Admin | Remove Item",
                Webhooks["Admin"]["RemoveItem"] or ""
        );

        self:AddWebhook(
                "Admin:ClearItems",
                "Admin | Clear Items",
                Webhooks["Admin"]["ClearItems"] or ""
        );

        self:AddWebhook(
                "Admin:GiveWeapon",
                "Admin | Give Weapon",
                Webhooks["Admin"]["GiveWeapon"] or ""
        );

        self:AddWebhook(
                "Admin:RemoveWeapon",
                "Admin | Remove Weapon",
                Webhooks["Admin"]["RemoveWeapon"] or ""
        );

        self:AddWebhook(
                "Admin:ClearWeapons",
                "Admin | Clear Weapons",
                Webhooks["Admin"]["ClearWeapons"] or ""
        );

        self:AddWebhook(
                "Admin:GiveWeaponAmmo",
                "Admin | Give Weapon Ammo",
                Webhooks["Admin"]["GiveWeaponAmmo"] or ""
        );

        self:AddWebhook(
                "Admin:GiveWeaponComponent",
                "Admin | Give Component",
                Webhooks["Admin"]["GiveWeaponComponent"] or ""
        );

        self:AddWebhook(
                "Admin:GiveAccountMoney",
                "Admin | Give Account Money",
                Webhooks["Admin"]["GiveAccountMoney"] or ""
        );

        self:AddWebhook(
                "Admin:RemoveAccountMoney",
                "Admin | Remove Account Money",
                Webhooks["Admin"]["RemoveAccountMoney"] or ""
        );

        self:AddWebhook(
                "Admin:SetJob",
                "Admin | Set Job",
                Webhooks["Admin"]["SetJob"] or ""
        );

        self:AddWebhook(
                "Admin:SetJob2",
                "Admin | Set Job2",
                Webhooks["Admin"]["SetJob2"] or ""
        );

        self:AddWebhook(
                "Admin:Car",
                "Admin | Car",
                Webhooks["Admin"]["Car"] or ""
        );

        self:AddWebhook(
                "Admin:GiveVehicle",
                "Admin | Give Vehicle",
                Webhooks["Admin"]["GiveVehicle"] or ""
        );

        self:AddWebhook(
                "Admin:DeleteVehicle",
                "Admin | Delete Vehicle",
                Webhooks["Admin"]["DeleteVehicle"] or ""
        );

        return self
    end

    ---@param name string
    ---@param title string
    ---@param webhook string @url of the webhook
    ---@param color hexColor @color of the webhook
    function self:AddWebhook(name, title, webhook, color)
        if (webhook) then
            self.webhooks[string.upper(name)] = { name = name, title = title, url = webhook, color = color or nil };
        else
            Shared.Log:Error(string.format("No URL for discord webhook %s", name));
        end
    end

    ---@param name string
    ---@param message string
    function self:SendMessage(name, message, embedData)

        if (self.webhooks[string.upper(name)]) then

            local embeds_list = {
                {
                    ["author"] = {
                        ["name"] = (self.webhooks[string.upper(name)] ~= nil and self.webhooks[string.upper(name)].title or "__***No title set***__")
                    },
                    ["description"] = (message and message) or "__***No message set***__",
                    ["type"] = "rich",
                    ["fields"] = embedData or {},
                    ["color"] =  self.webhooks[string.upper(name)].color or 652101,
                    ["footer"] =  {
                        ["text"]= self:GetTime(),
                        ["icon_url"] = Config["ServerImage"]
                    }
                }
            }

            PerformHttpRequest(self.webhooks[string.upper(name)].url, function(...)
            end, 'POST', json.encode({
                username = Config["ServerName"],
                avatar_url = Config["ServerImage"],
                embeds = embeds_list or {}
            }), {
                ['Content-Type'] = 'application/json' 
            });

        end

    end

    function self:GetTime()
        local date = os.date('*t')
        if date.day < 10 then date.day = '0' .. tostring(date.day); end
        if date.month < 10 then date.month = '0' .. tostring(date.month); end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour); end
        if date.min < 10 then date.min = '0' .. tostring(date.min); end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec); end
        date.msg = ("%s ©   |   %s:%s:%s"):format("Powered for Valestia", date.hour, date.min, date.sec);
        return date.msg;
    end

    return self;
end);