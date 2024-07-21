--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

-- Citizen.CreateThread(function()
--     -- Ped Vente
--     local model = GetHashKey('a_m_m_eastsa_02')
--     local posspawn = Config.Tabac.Vente
--     RequestModel(model)
--     while not HasModelLoaded(model) do Wait(1) end
--     local ped = CreatePed(4, model, posspawn, 301.24, false, true)
--     FreezeEntityPosition(ped, true)
--     SetEntityInvincible(ped, true)
--     SetBlockingOfNonTemporaryEvents(ped, true)
--     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)

--     -- Blip Recolte
--     local blip = AddBlipForCoord(Config.Tabac.Recolte)
--     SetBlipSprite (blip, 140)
--     SetBlipColour(blip, 28)
--     SetBlipScale  (blip, 0.6)
--     SetBlipAsShortRange(blip, true)

--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("[Activité] Recolte de Tabac")
--     EndTextCommandSetBlipName(blip)

--     -- Blip Traitement
--     local blip = AddBlipForCoord(Config.Tabac.Traitement)
--     SetBlipSprite (blip, 51)
--     SetBlipColour(blip, 28)
--     SetBlipScale  (blip, 0.6)
--     SetBlipAsShortRange(blip, true)

--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("[Activité] Traitement de Tabac")
--     EndTextCommandSetBlipName(blip)

--     -- Blip Vente
--     local blip = AddBlipForCoord(Config.Tabac.Vente)
--     SetBlipSprite (blip, 408)
--     SetBlipColour(blip, 28)
--     SetBlipScale  (blip, 0.6)
--     SetBlipAsShortRange(blip, true)

--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("[Activité] Vente de Tabac")
--     EndTextCommandSetBlipName(blip)
-- end)