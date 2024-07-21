--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local Licensestaff = {
    Staff = {
        ["license:xxxxx"] = true
    },
}

local maintenance = false

local function getLicense(src)
     for k,v in pairs(GetPlayerIdentifiers(src))do
          if string.sub(v, 1, string.len("license:")) == "license:" then
               return v
          end
     end
end

local function devStart(state)
     if state then
        maintenance = true
          local xPlayers = ESX.GetPlayers()
          for i = 1, #xPlayers, 1 do
               local src = tonumber(xPlayers[i])
               if not Licensestaff.Staff[getLicense(src)] then
                    print("Le joueur ^6"..GetPlayerName(src).."^0 connexion ^1reffusé^0 (^5PasDEV^0)")
                    DropPlayer(xPlayers[i], "\n\nLe serveur Valestia RP est actuellement en maintenance. Pour plus d'informations, rendez-vous sur discord.gg/valestiarp !")
               else
                    print("Le joueur ^6"..GetPlayerName(src).."^0 connexion ^2accepté^0 (^5Dev^0)")
               end
          end
     else
        maintenance = false
     end
end

Citizen.CreateThread(function()
    devStart(maintenance)
end)

AddEventHandler('playerConnecting', function(name, setReason)
    if maintenance then
         if not Licensestaff.Staff[getLicense(source)] then
            print("Le joueur ^6"..name.."^0 connexion ^1reffusé^0 (^5Maintenance^0)")
            setReason("\n\nLe serveur Valestia RP est actuellement en maintenance. Pour plus d'informations, rendez-vous sur discord.gg/valestiarp !")
            CancelEvent()
            return
         end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(60*1000*4)
        if maintenance then
            print("Maintenance ^2détecté^0 !")
            local xPlayers = ESX.GetPlayers()
            for i = 1, #xPlayers, 1 do
               local src = tonumber(xPlayers[i])
               if not Licensestaff.Staff[getLicense(src)] then
                    print("Le joueur ^6"..GetPlayerName(src).."^0 est ^1reffusé^0 dans la maintenance et je le kick .")
                    DropPlayer(xPlayers[i], "\n\nLe serveur Valestia RP est actuellement en maintenance. Pour plus d'informations, rendez-vous sur discord.gg/valestiarp !")
               else
                    print("Le joueur ^6"..GetPlayerName(src).."^0 est ^2accepté^0 dans la maintenance .")
               end
            end
        end
    end
end)

RegisterCommand("maintenance", function(source)
    if source == 0 then
         if not maintenance then
              print("Maintenance ^2actif^0 !")
              devStart(true)
         else
              print("Maintenance non ^1actif^0 !")
              devStart(false)
         end
    end
end)