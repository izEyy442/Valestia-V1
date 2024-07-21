local riiick = Riiick:new()

local main = RageUI.CreateMenu(" ", "Yacht Builder");

local id = nil
local posg = nil
local tel = nil
local tel2 = nil
local veh1 = nil
local veh2_yacht = nil
local possv = nil
local posv = nil
local posdj = nil
local posdec = nil

local keyID
local keyID2

main:isVisible(function(items)
    if id == nil then 
        items:Button("ID du joueur propriétaire", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                keyID = riiick:KeyboardInput("ID du joueur", "", 4)
                if type(tonumber(keyID)) == "number" then
                    id = keyID
                else
                    ESX.ShowNotification("~r~ID saisie n'est pas un nombre !")
                end       
            end
        });
    else
        items:Button("ID du joueur", "ID select : ~y~"..keyID, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if tel == nil then 
        items:Button("Coord TP entrée yacht", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                tel = GetEntityCoords(PlayerPedId())
            end
        });
    else
        items:Button("Coord TP entrée yacht", "Coord select : ~y~"..tel, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if tel2 == nil then 
        items:Button("Coord TP sortie yacht", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                tel2 = GetEntityCoords(PlayerPedId())
            end
        });
    else
        items:Button("Coord TP sortie yacht", "Coord select : ~y~"..tel2, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if posg == nil then 
        items:Button("Coord garage bateau", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                posg = GetEntityCoords(PlayerPedId())
            end
        });
    else
        items:Button("Coord garage bateau", "Coord select : ~y~"..posg, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if (veh1 == nil) or (veh2_yacht == nil) then 
        items:Button("Choix des véhicules", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                keyID = riiick:KeyboardInput("1er Véhicule (nom de spawn) (1):", "", 10)
                veh1 = keyID   
                if veh1 ~= nil then   
                    keyID2 = riiick:KeyboardInput("2eme Véhicule (nom de spawn) (4):", "", 10)
                    veh2_yacht = keyID2   
                end
            end
        });
    else
        items:Button("Choix des véhicules", "Véhicules choisis : ~y~"..veh1..", "..veh2_yacht, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if possv == nil then 
        items:Button("Coord sortie de bateau", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                possv = GetEntityCoords(PlayerPedId())
            end
        });
    else
        items:Button("Coord sortie de bateau", "Coord select : ~y~"..possv, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if posv == nil then 
        items:Button("Coord Coffre / Vestiaire", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                posv = GetEntityCoords(PlayerPedId())
            end
        });
    else
        items:Button("Coord Coffre / Vestiaire", "Coord select : ~y~"..posv, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if posdj == nil then 
        items:Button("Coord DJ", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                posdj = GetEntityCoords(PlayerPedId())
            end
        });
    else
        items:Button("Coord DJ", "Coord select : ~y~"..posdj, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if posdec == nil then 
        items:Button("Coord Lit (disconect)", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
            onSelected = function()
                posdec = GetEntityCoords(PlayerPedId())
            end
        });
    else
        items:Button("Coord Lit (disconect)", "Coord select : ~y~"..posdec, {LeftBadge = RageUI.BadgeStyle.Star}, false,{});
    end;
    if id ~= nil and posg ~= nil and veh1 ~= nil and veh2_yacht ~= nil and possv ~= nil and posv ~= nil and posdj ~= nil and posdec ~= nil then 
        items:Button("Valider", nil, {LeftBadge = RageUI.BadgeStyle.Star, Color = {BackgroundColor = {56, 171, 114, 100}}}, true,{
            onSelected = function()
                TriggerServerEvent("Riiick:addYacht", id, posg, veh1, veh2_yacht, possv, posv, posdj, posdec, tel, tel2)
                main:toggle();
            end
        });
    else
        items:Button("Valider", nil, {LeftBadge = RageUI.BadgeStyle.Star, Color = {BackgroundColor = {171, 56, 56, 100}}}, false,{});
    end
end);

RegisterNetEvent("Riiick:openYachtBuilder", function()
    id = nil
    tel = nil
    tel2 = nil
    posg = nil
    veh1 = nil 
    veh2_yacht = nil
    possv = nil
    posv = nil
    posdj = nil
    posdec = nil
    main:toggle();
end)

RegisterCommand("yachtbuilder", function()
    TriggerServerEvent("Riiick:checkYachtBuilder")
end);