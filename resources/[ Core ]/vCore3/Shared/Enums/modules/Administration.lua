--[[
----
----Created Date: 4:00 Saturday December 24th 2022
----Author: vCore3
----Made with ❤
----
----File: [Administration]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

Enums.Administration = {

    Server = {

        RequestOpenMenu = "vCore3:Valestia:administration:request:open:menu",

        StaffChangeState = "vCore3:Valestia:administration:staff:change:state",

        ReportTake = "vCore3:Valestia:administration:staff:report:take",
        ReportRemove = "vCore3:Valestia:administration:staff:report:remove",

        Actions = {

            CreateGroup = "vCore3:Valestia:administration:staff:actions:create:group",
            DeleteGroup = "vCore3:Valestia:administration:staff:actions:delete:group",
            UpdateGroupPermission = "vCore3:Valestia:administration:staff:actions:update:group:permission",

            SendMessage = "vCore3:Valestia:administration:staff:actions:send:message",

            Player = {

                GetInventory = "vCore3:Valestia:administration:staff:get:inventory",
                GiveItem = "vCore3:Valestia:administration:staff:give:item",
                RemoveItem = "vCore3:Valestia:administration:staff:remove:item",

                GetAccounts = "vCore3:Valestia:administration:staff:get:accounts",
                TeleportCoords = "vCore3:Valestia:administration:staff:actions:teleport:coords",
                Freeze = "vCore3:Valestia:administration:staff:actions:freeze:coords",

            },

            Goto = "vCore3:Valestia:administration:staff:actions:goto",

            Bring = "vCore3:Valestia:administration:staff:actions:bring",
            BringBack = "vCore3:Valestia:administration:staff:actions:bring_back",

            SetPed = "vCore3:Valestia:administration:staff:actions:set:ped",

            Entity = "vCore3:Valestia:administration:entity:execute"

        },

        RequestReportCount = "vCore3:Valestia:administration:staff:request:report:count",

    },

    Client = {

        Init = "vCore3:Valestia:administration:init",

        StaffSetValue = "vCore3:Valestia:administration:staff:set:value",
        StaffAdd = "vCore3:Valestia:administration:staff:add",
        StaffRemove = "vCore3:Valestia:administration:staff:remove",

        PlayerDropped = "vCore3:Valestia:administration:player:dropped",

        GroupSetValue = "vCore3:Valestia:administration:group:set:value",
        GroupAdd = "vCore3:Valestia:administration:group:add",
        GroupDelete = "vCore3:Valestia:administration:group:delete",

        ReportSetValue = "vCore3:Valestia:administration:report:set:value",
        ReportAdd = "vCore3:Valestia:administration:report:add",
        ReportRemove = "vCore3:Valestia:administration:report:remove",

        Actions = {

            Entity = "vCore3:Valestia:administration:entity:execute",

            ReceiveInventory = "vCore3:Valestia:administration:receive:inventory",
            ReceiveAccounts = "vCore3:Valestia:administration:receive:accounts"

        },

        ReceiveReportCount = "vCore3:Valestia:administration:receive:report:count",

    }

};