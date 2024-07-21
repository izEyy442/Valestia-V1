--[[
----
----Created Date: 2:52 Monday January 2nd 2023
----Author: vCore3
----Made with ❤
----
----File: [main]
----
----Copyright (c) 2023 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

vCore3 = {};

exports("getSharedvCore3", function()
    return vCore3;
end);

exports("RegisterCommand", function(commandName, callback, suggestion, adminOnly)
    return Shared:RegisterCommand(commandName, callback, suggestion, adminOnly)
end);