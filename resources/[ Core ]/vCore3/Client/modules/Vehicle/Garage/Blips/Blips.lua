--[[
----
----Created Date: 2:42 Sunday October 16th 2022
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

if (Config["Garage"]["Blips"]) then

    if (Config["Garage"]["Blips"]["Enabled"]) then

        for i = 1, #Config["Garage"]["Zones"] do

            local garage_zones = Config["Garage"]["Zones"][i];
            local garage_type = garage_zones["Type"] == nil and "default" or garage_zones["Type"]
            local garage_blip = Config["Garage"]["Blips"]["List"][garage_type]

            if ((garage_type ~= nil and garage_blip ~= nil) and (garage_zones ~= nil and garage_zones["Spawn"].x and garage_zones["Spawn"].y and garage_zones["Spawn"].z)) then

                local spawn_coords = vector3(garage_zones["Spawn"].x, garage_zones["Spawn"].y, garage_zones["Spawn"].z);

                if (spawn_coords) then

                    Game.Blip(

                        string.format("GarageIn#%s", i),

                        {
                            coords = spawn_coords,
                            label = ("[Garage] %s"):format(garage_blip.label),
                            sprite = garage_blip.sprite or 357,
                            color = garage_blip.color or 49,
                        }

                    );

                end

            end

        end

    end

end