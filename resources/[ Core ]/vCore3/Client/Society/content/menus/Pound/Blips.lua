--
--Created Date: 20:23 26/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Blips]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

if (Config["Society"]["Pound"]["JobCoords"]["Blips"]) then
    if (Config["Society"]["Pound"]["JobCoords"]["Blips"]["Enabled"]) then
        if (Config["Society"]["Pound"]["JobCoords"]["Interact"]) then

            local coords = Config["Society"]["Pound"]["JobCoords"]["Interact"];

            if (coords) then

                Game.Blip(
                    "JobPound",
                    {
                        coords = coords,
                        label = Config["Society"]["Pound"]["JobCoords"]["Blips"]["Label"] or "Pound",
                        sprite = Config["Society"]["Pound"]["JobCoords"]["Blips"]["Sprite"] or 357,
                        color = Config["Society"]["Pound"]["JobCoords"]["Blips"]["Color"] or 49,
                    }
                );

            end

        end
    end
end

if (Config["Society"]["Pound"]["GangCoords"]["Blips"]) then
    if (Config["Society"]["Pound"]["GangCoords"]["Blips"]["Enabled"]) then
        if (Config["Society"]["Pound"]["GangCoords"]["Interact"]) then

            local coords = Config["Society"]["Pound"]["GangCoords"]["Interact"];

            if (coords) then

                Game.Blip(
                    "GangPound",
                    {
                        coords = coords,
                        label = Config["Society"]["Pound"]["GangCoords"]["Blips"]["Label"] or "Pound",
                        sprite = Config["Society"]["Pound"]["GangCoords"]["Blips"]["Sprite"] or 357,
                        color = Config["Society"]["Pound"]["GangCoords"]["Blips"]["Color"] or 49,
                    }
                );

            end

        end
    end
end