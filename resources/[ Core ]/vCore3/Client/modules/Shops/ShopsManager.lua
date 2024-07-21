ShopsManager = ShopsManager or {};

function ShopsManager.GetFromId(shpId)
    return Config["Shops"].list[shpId]
end

CreateThread(function()

    for shp = 1, #Config["Shops"].list do

        local shop = Config["Shops"].list[shp]
        
        for blp = 1, #shop.positions do
            
            Game.Blip(("market_"..blp),
                {
                    coords = { x = shop.positions[blp].x, y = shop.positions[blp].y, z = shop.positions[blp].z },
                    label = ("[Magasin] %s"):format(shop.label),
                    sprite = (shop.blip ~= nil and shop.blip.sprite) or 52,
                    display = (shop.blip ~= nil and shop.blip.display),
                    scale = (shop.blip ~= nil and shop.blip.scale),
                    color = (shop.blip ~= nil and shop.blip.color) or 2,
                    range = (shop.blip ~= nil and shop.blip.range)
                }
            );

        end

        local zone = Game.Zone("markets");

        zone:Start(function()
        
            zone:SetTimer(1000);
        
            for pos = 1, #shop.positions do

                zone:SetCoords(shop.positions[pos]);

                zone:IsPlayerInRadius(5.0, function()
                    zone:SetTimer(0);
                    zone:Marker();
                    
                    zone:IsPlayerInRadius(2.0, function()

                        zone:Text(("Appuyez sur ~c~[~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~E~c~]~s~ pour intéragir avec ~y~%s~s~."):format(shop.label));
                        zone:KeyPressed("E", function()
                            TriggerServerEvent("Shops:RequestToOpen", shp)
                        end);

                    end, false, false);
            
                end, false, false);

                zone:RadiusEvents(3.0, nil, function()

                    ShopsManager.mainMenu:Close();

                end);

            end

        end);

    end

end)