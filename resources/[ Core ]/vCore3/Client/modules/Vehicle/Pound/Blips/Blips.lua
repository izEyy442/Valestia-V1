--[[
----
----Created Date: 2:57 Monday October 17th 2022
----Author: vCore3
----Made with ❤
----
----File: [Blips]
----
----Copyright (c) 2022 vCore3Work, All Rights Reserved.
----This file is part of vCore3Work project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

if (Config["Pound"]["Blips"]) then
    if (Config["Pound"]["Blips"]["Enabled"]) then
        for i = 1, #Config["Pound"]["Zones"] do
            local zone = Config["Pound"]["Zones"][i]["Menu"];
            if (zone.x and zone.y and zone.z) then
                local coords = vector3(zone.x, zone.y, zone.z);
                if (coords) then
                    Game.Blip(
                        string.format("PoundIn#%s", i),
                        {
                            coords = coords,
                            label = Config["Pound"]["Blips"]["Label"] or "Pound",
                            sprite = Config["Pound"]["Blips"]["Sprite"] or 357,
                            color = Config["Pound"]["Blips"]["Color"] or 49,
                        }
                    );
                end
            end
        end
    end
end